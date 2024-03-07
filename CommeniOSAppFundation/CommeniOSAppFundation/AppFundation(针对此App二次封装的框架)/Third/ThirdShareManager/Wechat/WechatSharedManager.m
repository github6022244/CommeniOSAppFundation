//
//  WechatSharedManager.m
//  CXGrainStudentApp
//
//  Created by User on 2020/8/14.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import "WechatSharedManager.h"
#import <CommonCrypto/CommonCrypto.h>
#import <objc/message.h>
#import <QMUIKit.h>
#import "UIWindow+GG.h"


#define kGetAccessTokenAPI   @"https://api.weixin.qq.com/sns/oauth2/access_token"
#define kGetUserInfoAPI      @"https://api.weixin.qq.com/sns/userinfo"

@interface WechatSharedManager () <WXApiDelegate>

@property (nonatomic, copy) NSString *appID;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) WechatAuthResult *authResult;
@property (nonatomic, strong) WechatUserInfo *userInfo;

@property (nonatomic, copy) void(^getCodeCompletionBlock)(BOOL isSuccess);
@property (nonatomic, copy) void(^shareWebCompletionBlock)(BOOL isSuccess);

@property (nonatomic, strong) QMUITips *tips;

@end

@implementation WechatSharedManager

static WechatSharedManager *instance = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[super allocWithZone:nil] init];
        }
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [WechatSharedManager sharedManager];
}


- (void)initWithAppID:(NSString *)appID
            appSecret:(NSString *)appSecret
        universalLink:(NSString *)universalLink{
    if (!appID) {
        return;
    }
    self.appID = appID;
    self.appSecret = appSecret;
    
#ifdef DEBUG
    //在 register 之前打开 log , 后续可以根据 log 排查问题
    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString *log) {
        NSLog(@"WeChatSDK: %@", log);
    }];
#endif
    BOOL reslut = [WXApi registerApp:appID universalLink:universalLink];

    if (!reslut) {
#ifdef DEBUG
        //调用自检函数
        [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult* result) {
            NSLog(@"\nWeChatSDK自检: 步骤:%@, 结果:%u, 错误信息:%@, SDK建议:%@", @(step), result.success, result.errorInfo, result.suggestion);
        }];
#endif
        QMUILog(nil, @"WeChatSDK: [WXApi registerApp:] 注册失败");
    }
}

- (BOOL)handleOpenURL:(NSURL *)URL{
    return [WXApi handleOpenURL:URL delegate:self];
}

- (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity{
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

#pragma mark -- Auth
- (void)authForGetCodeWithShowHUD:(BOOL)showHUD completionBlock:(void (^)(BOOL))completionBlock{
    if (!self.appID) {
        return;
    }
    
    self.getCodeCompletionBlock = completionBlock;
    
    SendAuthReq *rq = [[SendAuthReq alloc] init];
    rq.scope = @"snsapi_userinfo";
    rq.state = @"changxianggu";
    
    if (showHUD) {
        [self.tips showLoading];
    }
    
    __weak typeof(self) weakSelf = self;
    [WXApi sendAuthReq:rq viewController:[UIWindow getKeyWindow].rootViewController delegate:self completion:^(BOOL success) {
        [weakSelf.tips hideAnimated:YES];
        if (!success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionBlock) {
                    completionBlock(NO);
                }
                weakSelf.getCodeCompletionBlock = nil;
            });
        }
    }];
}



#pragma mark -- share
- (void)shareWebWithURL:(NSString *)URL
                  title:(NSString *)title
            description:(NSString *)description
             thumbImage:(UIImage *)thumbImage
              shareType:(WechatShareType)shareType
                showHUD:(BOOL)showHUD
        completionBlock:(void (^)(BOOL))completionBlock {
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!weakSelf.appID) {
            return;
        }
        
        // 学生端修改分享url
        NSString *shareUrl = URL.mutableCopy;
        if ([URL containsString:@"//cxgl"]) {
            shareUrl = [URL stringByReplacingOccurrencesOfString:@"//cxgl" withString:@"//cxgy"];
        } else if ([URL containsString:@"//test01"]) {
            shareUrl = [URL stringByReplacingOccurrencesOfString:@"//test01" withString:@"//cxgy"];
        }
        
        weakSelf.shareWebCompletionBlock = completionBlock;
        
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        webpageObject.webpageUrl = shareUrl;
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = description;
        [message setThumbImage:thumbImage];
        message.mediaObject = webpageObject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO; // YES:文本消息    NO:多媒体消息
        req.message = message;
        
        enum WXScene scene = WXSceneSession;
        if (shareType == WechatShareType_Session) {
            scene = WXSceneSession;
        } else if (shareType == WechatShareType_Timeline) {
            scene = WXSceneTimeline;
        }
        req.scene = scene;
        
        [WXApi sendReq:req completion:^(BOOL success) {
            if (!success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completionBlock) {
                        completionBlock(NO);
                    }
                    weakSelf.shareWebCompletionBlock = nil;
                });
            }
        }];
    });
}

#pragma mark -- wxApi delegate
- (void)onReq:(BaseReq *)req{
    QMUILog(nil, @"[微信] [onReq] [req] %@ [type] %d", req, req.type);
}



/*
 WXSuccess           = 0,    // 成功
 WXErrCodeCommon     = -1,   // 普通错误类型
 WXErrCodeUserCancel = -2,   // 用户点击取消并返回
 WXErrCodeSentFail   = -3,   // 发送失败
 WXErrCodeAuthDeny   = -4,   // 授权失败
 WXErrCodeUnsupport  = -5,   // 微信不支持
 */
- (void)onResp:(BaseResp *)resp {
    __weak typeof(self) weakSelf = self;
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        // 授权
        SendAuthResp *response = (SendAuthResp *)resp;
        QMUILog(nil, @"[微信] [onResp] [SendAuthResp] [errCode] %d", response.errCode);
        QMUILog(nil, @"[微信] [onResp] [SendAuthResp] [code] %@", response.code);
        QMUILog(nil, @"[微信] [onResp] [SendAuthResp] [state] %@", response.state);
        QMUILog(nil, @"[微信] [onResp] [SendAuthResp] [lang] %@", response.lang);
        QMUILog(nil, @"[微信] [onResp] [SendAuthResp] [country] %@", response.country);
        
        if (response.errCode == WXSuccess) {
            NSString *code = response.code; // code
            weakSelf.code = code;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.getCodeCompletionBlock) {
                    weakSelf.getCodeCompletionBlock(YES);
                }
                self.getCodeCompletionBlock = nil;
            });
        } else if (response.errCode == WXErrCodeCommon ||
                   response.errCode == WXErrCodeUserCancel ||
                   response.errCode == WXErrCodeSentFail ||
                   response.errCode == WXErrCodeAuthDeny ||
                   response.errCode == WXErrCodeUnsupport) {
            weakSelf.code = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.getCodeCompletionBlock) {
                    weakSelf.getCodeCompletionBlock(NO);
                }
                self.getCodeCompletionBlock = nil;
            });
        }
    } else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        // 分享
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        QMUILog(nil, @"[微信] [onResp] [SendMessageToWXResp] [errCode] %d", response.errCode);
        if (response.errCode == WXSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.shareWebCompletionBlock) {
                    weakSelf.shareWebCompletionBlock(YES);
                }
                weakSelf.shareWebCompletionBlock = nil;
            });
        } else if (response.errCode == WXErrCodeCommon ||
                   response.errCode == WXErrCodeUserCancel ||
                   response.errCode == WXErrCodeSentFail ||
                   response.errCode == WXErrCodeAuthDeny ||
                   response.errCode == WXErrCodeUnsupport) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.shareWebCompletionBlock) {
                    weakSelf.shareWebCompletionBlock(NO);
                }
                weakSelf.shareWebCompletionBlock = nil;
            });
        }
    }
}

- (QMUITips *)tips {
    if (!_tips) {
        _tips = [QMUITips createTipsToView:[UIWindow getKeyWindow]];
    }
    
    return _tips;
}

@end
