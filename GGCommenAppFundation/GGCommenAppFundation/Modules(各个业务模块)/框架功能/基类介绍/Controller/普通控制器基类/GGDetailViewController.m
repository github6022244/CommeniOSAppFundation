//
//  GGDetailViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
//

#import "GGDetailViewController.h"
#import "UILabel+GG.h"
#import "GGBaseVCFuncDesView.h"
#import "MGJRouter+GG.h"
#import "GGAppModulesDefine.h"

@interface GGDetailViewController ()

@property (nonatomic, strong) GGBaseVCFuncDesView *desView;

@end

@implementation GGDetailViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_BaseViewController_OpenBaseViewController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        UIViewController *preVC = param.senderData.preController;
        
        GGDetailViewController *vc = [GGDetailViewController new];
        
        [preVC showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    self.title = @"GGBaseViewController子类";
}

- (void)uibase_setUpSubViews {
    [super uibase_setUpNavigationItems];
    
    // 功能介绍
    GGBaseVCFuncDesView *desView = [GGBaseVCFuncDesView view];
    [self.view addSubview:desView];
    desView.qmui_top = 100.f;
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- 无网络视图
// 是否自动展示
- (BOOL)autoShowNetStatusChangeAlertView {
    // 这里可以添加一些判断条件，比如如果有内容则不自动显示
    return YES;
}

// 配置 lostNetAlertView
- (void)configLostNetAlertView:(QMUIEmptyView *)lostNetAlertView {
    /// @warning 如果指定了按钮的 action，则无法使用默认的功能
    [lostNetAlertView.actionButton addTarget:self action:@selector(acitons_clickLostLostNetAlertViewButton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 点击无网络视图按钮
- (void)acitons_clickLostLostNetAlertViewButton {
    QMUILog(nil, @"点击了");
    
    if (self.isNetReachable) {
        [self hideLostNetAlertView];
    } else {
        [QMUITips showError:@"无网络连接"];
    }
}

@end
