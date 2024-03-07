//
//  UIBaseViewController.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/2.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UIBaseViewController.h"
#import <UIView+QMUI.h>
#import "NSArray+GG.h"
#import "UIViewController+GG.h"

@interface UIBaseViewController ()

@end

@implementation UIBaseViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)didInitialize {
    [super didInitialize];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    if (self.qmui_isPresented || self.qmui_previousViewController) {
        [self addNavBackBarItem];
    }
}
//- (void)uibase_setUpNavigationItems {
//    [super uibase_setUpNavigationItems];
//
//    if (self.qmui_isPresented || self.qmui_previousViewController) {
//        [self addNavBackBarItem];
//    }
//}

- (void)uibase_setUpSubViews {
    
}

#pragma mark ------------------------- 初始化 -------------------------
// 绑定 viewModel
- (void)uibase_bindViewModel {
    
}

// 初始化通知服务
- (void)uibase_setUpNotification {
    
}

// 配置
- (void)uibase_config {
    
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- QMUINavagation Delegate
- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (BOOL)forceEnableInteractivePopGestureRecognizer {
    return YES;
}

#pragma mark --- DEBUG
/// 是否在 debug 模式下，当显示出页面时打印类名
- (BOOL)debugLogClassName {
    return YES;
}

@end
