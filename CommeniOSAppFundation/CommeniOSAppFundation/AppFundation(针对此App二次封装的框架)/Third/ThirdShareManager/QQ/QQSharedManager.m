//
//  QQSharedManager.m
//  CXGrainStudentApp
//
//  Created by Hyman Gao on 2020/8/16.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import "QQSharedManager.h"

#define kGetUserInfoAPI @"https://graph.qq.com/user/get_user_info"

@interface QQSharedManager ()
#if __has_include(<TencentOpenAPI/TencentOAuth.h>) && __has_include(<TencentOpenAPI/QQApiInterface.h>)
    <TencentSessionDelegate, QQApiInterfaceDelegate>
#endif
#if __has_include(<TencentOpenAPI/TencentOAuth.h>) && __has_include(<TencentOpenAPI/QQApiInterface.h>)
@property (nonatomic, copy) NSString *appID;
@property (nonatomic, strong) TencentOAuth *oauth;
@property (nonatomic, strong) QQUserInfo *userInfo;

@property (nonatomic, copy) void (^authComplectionBlock)(BOOL isSuccess);
@property (nonatomic, copy) void (^shareComplectionBlock)(BOOL isSuccess);

#endif

@end

@implementation QQSharedManager

static QQSharedManager *instance = nil;

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
    return [QQSharedManager sharedManager];
}

#if __has_include(<TencentOpenAPI/TencentOAuth.h>) && __has_include(<TencentOpenAPI/QQApiInterface.h>)
#pragma mark Init
- (void)initWithAppID:(NSString *)appID universalLink:(NSString *)universalLink {
    if (self.oauth) {
        self.oauth = nil;
    }
    if (!appID) {
        return;
    }
    self.appID = appID;
    if (universalLink) {
        self.oauth = [[TencentOAuth alloc] initWithAppId:appID andUniversalLink:universalLink andDelegate:self];
    } else {
        self.oauth = [[TencentOAuth alloc] initWithAppId:appID andDelegate:self];
    }
}

- (BOOL)handleOpenURL:(NSURL *)URL {
    [QQApiInterface handleOpenURL:URL delegate:self];
    return [TencentOAuth HandleOpenURL:URL];
}

- (BOOL)handleUniversalLink:(NSURL *)universalLink {
    [QQApiInterface handleOpenUniversallink:universalLink delegate:self];
    return [TencentOAuth HandleUniversalLink:universalLink];
}

#pragma mark Auth
- (void)authWithShowHUD:(BOOL)showHUD completionBlock:(void (^)(BOOL))completionBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.appID) {
            return;
        }

        self.authComplectionBlock = completionBlock;

        NSArray *permissions = @[ kOPEN_PERMISSION_GET_INFO,
                                  kOPEN_PERMISSION_GET_USER_INFO,
                                  kOPEN_PERMISSION_GET_SIMPLE_USER_INFO ];
        BOOL result = [self.oauth authorize:permissions];
        if (!result) {
            if (completionBlock) {
                completionBlock(NO);
            }
            self.authComplectionBlock = nil;
        }
    });
}

#pragma mark-- share
- (void)shareWebWithURL:(NSString *)URL
                  title:(NSString *)title
            description:(NSString *)description
          thumbImageURL:(nullable NSString *)thumbImageURL
              shareType:(QQShareType)shareTye
          shareDestType:(QQShareDestType)shareDestType
                showHUD:(BOOL)showHUD
        completionBlock:(void (^_Nullable)(BOOL isSuccess))completionBlock {
    
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
        
        weakSelf.shareComplectionBlock = completionBlock;
        
        QQApiNewsObject *object = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareUrl] title:title description:description previewImageURL:[NSURL URLWithString:thumbImageURL]];
        
        ShareDestType destType = ShareDestTypeQQ;
        if (shareDestType == QQShareDestType_QQ) {
            destType = ShareDestTypeQQ;
        } else if (shareDestType == QQShareDestType_TIM) {
            destType = ShareDestTypeTIM;
        }
        object.shareDestType = destType;
        
        SendMessageToQQReq *rq = [SendMessageToQQReq reqWithContent:object];
        
        QQApiSendResultCode sendResultCode = EQQAPISENDFAILD;
        if (shareTye == QQShareType_QQ) {
            sendResultCode = [QQApiInterface sendReq:rq];
        } else if (shareTye == QQShareType_QZone) {
            sendResultCode = [QQApiInterface SendReqToQZone:rq];
        }
        if (sendResultCode != EQQAPISENDSUCESS) {
            if (completionBlock) {
                completionBlock(NO);
            }
            weakSelf.shareComplectionBlock = nil;
        }
    });
}

#pragma mark-- <TencentLoginDelegate>
// 登录成功后的回调.
- (void)tencentDidLogin {
    QMUILog(nil, @"[QQ] [授权] [TencentLoginDelegate] tencentDidLogin");
    if (self.authComplectionBlock) {
        self.authComplectionBlock(YES);
    }
    self.authComplectionBlock = nil;
}

// 授权失败后的回调.
- (void)tencentDidNotLogin:(BOOL)cancelled {
    QMUILog(nil, @"[QQ] [授权] [TencentLoginDelegate] tencentDidNotLogin");
    if (self.authComplectionBlock) {
        self.authComplectionBlock(NO);
    }
    self.authComplectionBlock = nil;
}

// 授权时网络有问题的回调.
- (void)tencentDidNotNetWork {
    QMUILog(nil, @"[QQ] [授权] [TencentLoginDelegate] tencentDidNotNetWork");
    if (self.authComplectionBlock) {
        self.authComplectionBlock(NO);
    }
    self.authComplectionBlock = nil;
}

- (void)didGetUnionID {
    QMUILog(nil, @"[QQ] [didGetUnionID] %@", self.oauth.unionid);
}

#pragma mark <QQApiInterfaceDelegate>
// 处理来至QQ的请求.
- (void)onReq:(QQBaseReq *)req {
    QMUILog(nil, @"[QQ] [QQApiInterfaceDelegate] [onReq] %@ [type] %d", req, req.type);
}

// 处理来至QQ的响应.
- (void)onResp:(QQBaseResp *)resp {
    QMUILog(nil, @"[QQ] [QQApiInterfaceDelegate] [onResp] %@", resp);
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        SendMessageToQQResp *response = (SendMessageToQQResp *)resp;
        QMUILog(nil, @"[QQ] [分享] [QQApiInterfaceDelegate] [onResp] [SendMessageToQQResp] [result] %@", response.result);
        if ([response.result isEqualToString:@"0"]) {
            if (self.shareComplectionBlock) {
                self.shareComplectionBlock(YES);
            }
            self.shareComplectionBlock = nil;
        } else {
            if (self.shareComplectionBlock) {
                self.shareComplectionBlock(NO);
            }
            self.shareComplectionBlock = nil;
        }
    }
}

// 处理QQ在线状态的回调.
- (void)isOnlineResponse:(NSDictionary *)response {
    QMUILog(nil, @"[QQ] [QQApiInterfaceDelegate] [isOnlineResponse] %@", response);
}

#endif

@end
