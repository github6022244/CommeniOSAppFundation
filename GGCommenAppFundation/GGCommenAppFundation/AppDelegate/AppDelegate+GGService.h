//
//  AppDelegate+GGService.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/1.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (GGService)

/// 初始化本地数据
- (void)setUpLocalData;

/// 初始化 window
- (void)setUpWindow;

/// 初始化网络请求相关
- (void)setUpNetwork;

/// KeyBoard
- (void)setUpKeyBoard;

/// 微信
- (void)setUpWechatSDK;

/// 样式
- (void)setUpUIConfigration;

/// 推送
- (void)setUpJPushWithOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
