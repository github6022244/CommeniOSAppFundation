//
//  UIViewController+UIBase.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
//

#import "UIViewController+UIBase.h"
#import <UIView+QMUI.h>
#import "NSArray+GG.h"

@implementation UIViewController (UIBase)

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(viewDidLoad), @selector(UIBase_viewDidLoad));
    });
}

- (void)UIBase_viewDidLoad {
    [self UIBase_viewDidLoad];
    
    if ([self respondsToSelector:@selector(uibase_config)]) {
        [self uibase_config];
    }
    
    if ([self respondsToSelector:@selector(uibase_bindViewModel)]) {
        [self uibase_bindViewModel];
    }
    
    if ([self respondsToSelector:@selector(uibase_setUpNotification)]) {
        [self uibase_setUpNotification];
    }
    
    if ([self respondsToSelector:@selector(uibase_setUpSubViews)]) {
        [self uibase_setUpSubViews];
    }
    
    if ([self respondsToSelector:@selector(uibase_setUpNavigationItems)]) {
        [self uibase_setUpNavigationItems];
    }
}

@end
















@implementation UIViewController (UIBaseNavgationConfig)

- (UIBarButtonItem *)addNavBackBarItem {
    self.navigationItem.leftBarButtonItem = nil;
    
    QMUINavigationButton *navBackBtn = [[QMUINavigationButton alloc] initWithType:QMUINavigationButtonTypeBack];
    [navBackBtn setImage:NavBarBackIndicatorImage forState:UIControlStateNormal];
    navBackBtn.qmui_size = CGSizeMake(44.0, 44.0);
//    navBackBtn.adjustsImageTintColorAutomatically = YES;
    
//    UIBarButtonItem *item = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(handleBackButtonEvent:)];// 自定义返回按钮要自己写代码去 pop 界面
    UIBarButtonItem *item = [UIBarButtonItem qmui_itemWithButton:navBackBtn target:self action:@selector(handleBackButtonEvent:)];
    item.tag = 4009;
    self.navigationItem.leftBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)addNavBackBarItemWithImage:(UIImage *)image {
    self.navigationItem.leftBarButtonItem = nil;
    
    QMUINavigationButton *button = [[QMUINavigationButton alloc] initWithType:QMUINavigationButtonTypeBack];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleBackButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.qmui_size = CGSizeMake(44.0, 44.0);
//    button.adjustsImageTintColorAutomatically = YES;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    barButtonItem.tag = 4009;
    self.navigationItem.leftBarButtonItem = barButtonItem;
    return barButtonItem;
}

- (void)handleBackButtonEvent:(id)sender {
    if (self.gg_popTargetControllerClassName) {
        [self exitControllerClassName:self.gg_popTargetControllerClassName completion:nil];
    } else {
        [self exitController];
    }
}

@end
