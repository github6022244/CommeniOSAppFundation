//
//  AppDelegate+GGService.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/1.
//

#import "AppDelegate+GGService.h"
#import <IQKeyboardManager.h>
#import "GGAppManager.h"
#import "AppWelcomeController.h"
#import "WMZPermission.h"
#import <QMUIKit.h>
#import "GGTabBarViewController.h"
#import <AFNetworking.h>
#import <GGNetWorkManager.h>
#import "GGNetWorkConfigModel.h"
//#import "WechatShareManager.h"
//#import "AppDelegate+JPush.h"
#import "AppDefine.h"

@implementation AppDelegate (GGService)

/// 初始化本地数据
- (void)setUpLocalData {
//    [[WMZPermission shareInstance] permissonType:PermissionTypePhoto withHandle:nil];
//    [[WMZPermission shareInstance] permissonType:PermissionTypeCamera withHandle:nil];
//    [[WMZPermission shareInstance] permissonType:PermissionTypeLocationAlways withHandle:^(BOOL granted, NSNumber *data) {
//        QMUILog(nil, @"请求定位权限结果: %ld, %ld", granted, data.integerValue);
//    }];
    
//    [[SYCLLocation shareLocation] locationStart:^(CLLocation *location, CLPlacemark *placemark) {
//        NSLog(@"%@", placemark);
//    } faile:^(NSError *error) {
//        NSLog(@"%@", error.localizedDescription);
//    }];
    
    // 是否允许控制台打印
    GGAppManager.logAble = YES;
}

/// 初始化 window
- (void)setUpWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColorForBackground;
    
    if ([GGAppManager isFirstLaunch]) {
        __weak typeof(self) weakSelf = self;
        self.window.rootViewController = [[AppWelcomeController alloc] initWithEnterBlock:^{
            weakSelf.window.rootViewController = [GGTabBarViewController new];
        }];
        
        [GGAppManager updateFirstLaunch];
    } else {
        self.window.rootViewController = [GGTabBarViewController new];
    }
    
    [self.window makeKeyAndVisible];
}

/// 初始化网络请求相关
- (void)setUpNetwork {
    // 配置网络
    [GGNetWorkManager setUpConfigModel:[GGNetWorkConfigModel new]];
    [GGNetWorkManager share].debugLogEnable = GGAppManager.logAble;
    
    // 检测网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
//            MRLostNetAlertController *alertVC = [[MRLostNetAlertController alloc] init];
//            UIViewController *topVC = [QMUIHelper visibleViewController];
//            if (![topVC isKindOfClass:[MRLostNetAlertController class]] && ![topVC isKindOfClass:[AppWelcomeController class]]) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    MRBaseNavigationController *nav = [[MRBaseNavigationController alloc] initWithRootViewController:alertVC];
//                    [topVC fullScreenPresentViewController:nav animated:YES completion:nil];
//                });
//            }
            
//            [QMUITips showError:@"失去网络连接"];
        }
        
        if ([AFNetworkReachabilityManager sharedManager].reachable) {
//            [QMUITips showSucceed:@"网络状态变更\n正常"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_AppNetStatusChange object:nil userInfo:@{
            @"status": @(status),
        }];
    }];
}

/// KeyBoard
- (void)setUpKeyBoard {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    [IQKeyboardManager sharedManager].toolbarTintColor = UIColorTestRed;
}

/// 微信
- (void)setUpWechatSDK {
//    BOOL isSuccess = [WXApi registerApp:WeiXinPayKey universalLink:WeiXinLinks];
//    if (!isSuccess) {
//        NSLog(@"微信sdk登录失败");
//    }
}

/// 样式
- (void)setUpUIConfigration {
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else if (@available(iOS 13, *)) {
        /// 其实 QMUI 已经自动设置了
        /// 当 contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever 时，自动设置 automaticallyAdjustsScrollIndicatorInsets = NO
        /// 在👁👁 QMUIConfigurationTemplate.m 搜索 adjustScrollIndicatorInsetsByContentInsetAdjustment = YES;
        [UIScrollView appearance].automaticallyAdjustsScrollIndicatorInsets = NO;
    } else if (@available(iOS 15.0, *)) {
        /// UITableView.sectionHeaderTopPadding 的适配用 QMUI 的，默认 0
        /// 在👁👁 QMUIConfigurationTemplate.m 搜索 sectionHeaderTopPadding 来按需修改
//        [UITableView appearance].sectionHeaderTopPadding = 0.f;
    }
}

#warning -gg 注释推送
/// 推送
- (void)setUpJPushWithOptions:(NSDictionary *)options {
//    [MRPushManager setUp];
//    [self jpush_setUpJPushWithOptions:options];
}

@end
