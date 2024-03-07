//
//  WechatSharedManager.h
//  CXGrainStudentApp
//
//  Created by User on 2020/8/14.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#if __has_include(<WechatOpenSDK/WXApi.h>)
    #import <WechatOpenSDK/WXApi.h>
#elif __has_include("WXApi.h")
    #import "WXApi.h"
#endif
#import "WechatAuthResult.h"
#import "WechatUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 分享类型
 */
typedef NS_ENUM(NSUInteger, WechatShareType) {
    WechatShareType_Session,              // 分享至聊天界面
    WechatShareType_Timeline,             // 分享至朋友圈
};

@interface WechatSharedManager : NSObject

/// 初始化SDK的appID
@property (nonatomic, copy, nullable, readonly) NSString *appID;
/// 初始化SDK的appSecret
@property (nonatomic, copy, nullable, readonly) NSString *appSecret;
/// 授权获取的code
@property (nonatomic, copy, nullable, readonly) NSString *code;
/// 授权信息
@property (nonatomic, strong, nullable, readonly) WechatAuthResult *authResult;
/// 用户信息
@property (nonatomic, strong, nullable, readonly) WechatUserInfo *userInfo;

+ (instancetype)sharedManager;

/// SDK初始化
/// @param appID appID
/// @param appSecret appSecret(当只需要获取code时，appSecret可以为空)
/// @param universalLink Universal Link(根据最新微信SDK，需要`Universal Link`参数)
- (void)initWithAppID:(NSString *)appID
            appSecret:(nullable NSString *)appSecret
        universalLink:(NSString *)universalLink;

/// 处理微信通过URL启动App时传递的数据
/// @param URL URL
- (BOOL)handleOpenURL:(NSURL *)URL;

/// 处理微信通过`Universal Link`启动App时传递的数据
/// @param userActivity 微信启动第三方应用时系统API传递过来的userActivity
- (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity;


#pragma mark Auth
/// 获取code（获取code调用的是SDK里面的方法）
/// @param showHUD 是否显示HUD
/// @param completionBlock 回调(是否获取成功，code保存在属性`code`里面)
- (void)authForGetCodeWithShowHUD:(BOOL)showHUD completionBlock:(void(^_Nullable)(BOOL isGetCodeSuccess))completionBlock;


#pragma mark Share
/**
 微信分享网页
 注意：
 新版本微信SDK分享的时候，即使点击微信分享页面的取消按钮时，也是回调的分享成功。具体请看:https://mp.weixin.qq.com/s?__biz=MjM5NDAwMTA2MA==&mid=2695730124&idx=1&sn=666a448b047d657350de7684798f48d3&chksm=83d74a07b4a0c311569a748f4d11a5ebcce3ba8f6bd5a4b3183a4fea0b3442634a1c71d3cdd0&scene=21#wechat_redirect
 
 @param URL 链接
 @param title 标题
 @param description 描述
 @param thumbImage 缩略图
 @param shareType 分享类型（目前只能分享到朋友圈和聊天界面）
 @param showHUD 是否显示HUD
 @param completionBlock 分享完成后在主线程的回调
 */
- (void)shareWebWithURL:(NSString *)URL
                  title:(nullable NSString *)title
            description:(nullable NSString *)description
             thumbImage:(nullable UIImage *)thumbImage
              shareType:(WechatShareType)shareType
                showHUD:(BOOL)showHUD
        completionBlock:(void(^_Nullable)(BOOL isSuccess))completionBlock;

@end

NS_ASSUME_NONNULL_END
