//
//  GGNetWorkConfigModel.h
//  GGNetWorkManager
//
//  Created by GG on 2022/5/17.
//  自定义请求参数类

#import <Foundation/Foundation.h>
#import <GGNetWorkManager.h>

NS_ASSUME_NONNULL_BEGIN

/// 用户登录后重新配置网络请求成功回调
extern NSString *const Notify_GGNetWorkConfigModelReconfigNetworkForUserLogin;

// 网络请求配置类
@interface GGNetWorkConfigModel : NSObject<GGNetWorkManagerConfigProtocol>

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END








// 菊花样式配置类
@interface GGNetWorkConfigLoadingModel : NSObject<GGNetWorkManagerLoadingProtocol>

@end
