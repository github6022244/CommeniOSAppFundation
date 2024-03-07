//
//  QQSharedManager.h
//  CXGrainStudentApp
//
//  Created by Hyman Gao on 2020/8/16.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<TencentOpenAPI/TencentOAuth.h>) && __has_include(<TencentOpenAPI/QQApiInterface.h>)
//    #import <TencentOpenAPI/TencentOAuth.h>
//    #import <TencentOpenAPI/QQApiInterface.h>
#import "TencentOpenAPI/TencentOAuth.h"
#import "TencentOpenAPI/QQApiInterface.h"
#endif

#import "QQUserInfo.h"
//#import <TencentOAuth.h>
//#import <TencentOAuthObject.h>
//#import <QQApiInterface.h>
//#import <QQApiInterfaceObject.h>

NS_ASSUME_NONNULL_BEGIN

// 分享类型
typedef NS_ENUM(NSUInteger, QQShareType) {
    QQShareType_QQ,            // 分享到QQ
    QQShareType_QZone,         // 分享到QQ空间
};

// 分享到哪儿
typedef NS_ENUM(NSUInteger, QQShareDestType) {
    QQShareDestType_QQ,        // 分享到QQ
    QQShareDestType_TIM,       // 分享到TIM
};

@interface QQSharedManager : NSObject

#if __has_include(<TencentOpenAPI/TencentOAuth.h>) && __has_include(<TencentOpenAPI/QQApiInterface.h>)
/// 初始化SDK的appID
@property (nonatomic, copy, readonly) NSString *appID;
/// 授权成功后的信息保存在此对象里面，需要什么信息自己去拿
@property (nonatomic, strong, readonly, nullable) TencentOAuth *oauth;
/// QQ登录获取的个人信息
@property (nonatomic, strong, readonly, nullable) QQUserInfo *userInfo;
#endif

+ (instancetype)sharedManager;

#pragma mark Init
/// QQ SDK初始化
/// @param appID appID
/// @param universalLink 可以为空，根据目前QQ SDK里面提供的初始化方法，`universalLink`是可选的。测试发现`universalLink`为空或者填写不正确，分享会失败
- (void)initWithAppID:(NSString *)appID universalLink:(nullable NSString *)universalLink;

/// handleOpenURL
/// @param URL URL
- (BOOL)handleOpenURL:(NSURL *)URL;

/// handleUniversalLink
/// @param universalLink universalLink
- (BOOL)handleUniversalLink:(NSURL *)universalLink;

#pragma mark -- Auth
/// QQ授权
/// @param showHUD 是否显示hUD
/// @param completionBlock  回调(如果isSuccess为YES，代表授权成功，授权信息保存在oauth对象里面)
- (void)authWithShowHUD:(BOOL)showHUD completionBlock:(void(^_Nullable)(BOOL isSuccess))completionBlock;


#pragma mark -- Shared
/// 网页分享(缩略图为URL)
/// @param URL URL
/// @param title 标题
/// @param description 描述
/// @param thumbImageURL 分享的缩略图片链接
/// @param shareTye 分享类型
/// @param shareDestType 分享到哪儿
/// @param showHUD 是否显示HUD
/// @param completionBlock 分享完成回调（是否分享成功）
- (void)shareWebWithURL:(NSString *)URL
                  title:(NSString *)title
            description:(NSString *)description
          thumbImageURL:(nullable NSString *)thumbImageURL
              shareType:(QQShareType)shareTye
          shareDestType:(QQShareDestType)shareDestType
                showHUD:(BOOL)showHUD
        completionBlock:(void(^_Nullable)(BOOL isSuccess))completionBlock;

@end

NS_ASSUME_NONNULL_END
