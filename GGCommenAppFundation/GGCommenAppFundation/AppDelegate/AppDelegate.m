//
//  AppDelegate.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/5/31.
//

#import "AppDelegate.h"
#import "AppDelegate+GGService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /// 初始化本地数据
    [self setUpLocalData];
    
    /// 初始化网络请求
    [self setUpNetwork];
    
    // 样式
    [self setUpUIConfigration];
    
    /// 初始化 window
    [self setUpWindow];
    
//    /// 版本更新（放到window初始化后使用）
//    [self checkVersionUpdate];
    
    /// KeyBoard
    [self setUpKeyBoard];
    
    /// 微信
    [self setUpWechatSDK];
    
    /// 推送
    [self setUpJPushWithOptions:launchOptions];
    
    return YES;
}


//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
