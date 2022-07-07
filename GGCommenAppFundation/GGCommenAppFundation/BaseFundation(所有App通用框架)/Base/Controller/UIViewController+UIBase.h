//
//  UIViewController+UIBase.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
//

#import <UIKit/UIKit.h>
#import <QMUIKit.h>
#import "UIViewController+GG.h"

NS_ASSUME_NONNULL_BEGIN

// 规定一些格式，来定准代码应该在哪写
@protocol UIViewControllerUIBaseSpecificationProtocol <NSObject>

/// @warning: 确认下父类是否有配置，如果有调用一下 super
@optional
// 配置
- (void)uibase_config;

// 绑定 viewModel
- (void)uibase_bindViewModel;

// 初始化通知服务
- (void)uibase_setUpNotification;

// UI
- (void)uibase_setUpSubViews;
- (void)uibase_setUpNavigationItems;

@end





@interface UIViewController (UIBase)<UIViewControllerUIBaseSpecificationProtocol>

@end











@interface UIViewController (UIBaseNavgationConfig)

// 返回按钮回调, 默认返回上一页
- (void)handleBackButtonEvent:(id)sender;

- (UIBarButtonItem *)addNavBackBarItem;

- (UIBarButtonItem *)addNavBackBarItemWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
