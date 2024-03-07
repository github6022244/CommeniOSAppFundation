//
//  GGBaseViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
//

#import "GGBaseViewController.h"

@interface GGBaseViewController ()

@end

@implementation GGBaseViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- Config -------------------------
- (void)uibase_config {
    [super uibase_config];
}

- (void)uibase_bindViewModel {
    [super uibase_bindViewModel];
}

- (void)uibase_setUpNotification {
    [super uibase_setUpNotification];
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
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
    [super uibase_setUpSubViews];
    
    self.emptyView.backgroundColor = UIColorForBackground;
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- 是否自动展示/隐藏网络状态改变提示图
- (BOOL)autoShowNetStatusChangeAlertView {
    return YES;
}

#pragma mark --- 导航栏相关
/// 设置每个界面导航栏的显示/隐藏，为了减少对项目的侵入性，默认不开启这个接口的功能，只有当 shouldCustomizeNavigationBarTransitionIfHideable 返回 YES 时才会开启此功能。如果需要全局开启，那么就在 Controller 基类里面返回 YES；如果是老项目并不想全局使用此功能，那么则可以在单独的界面里面开启。
/// 通过 QMUIConfigurationTemplate 的 navigationBarHiddenInitially 修改默认值(默认NO)
- (BOOL)preferredNavigationBarHidden {
    return NO;
}

/**
 *  当切换界面时，如果不同界面导航栏的显隐状态不同，可以通过 shouldCustomizeNavigationBarTransitionIfHideable 设置是否需要接管导航栏的显示和隐藏。从而不需要在各自的界面的 viewWillAppear 和 viewWillDisappear 里面去管理导航栏的状态。
 *  @see UINavigationController+NavigationBarTransition.h
 *  @see preferredNavigationBarHidden
 */
- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

/// 当自定义了`leftBarButtonItem`按钮之后，系统的手势返回就失效了。可以通过`forceEnableInteractivePopGestureRecognizer`来决定要不要把那个手势返回强制加回来。当 interactivePopGestureRecognizer.enabled = NO 或者当前`UINavigationController`堆栈的viewControllers小于2的时候此方法无效。
- (BOOL)forceEnableInteractivePopGestureRecognizer {
    return YES;
}

///// 设置 titleView 的 tintColor
//- (nullable UIColor *)qmui_titleViewTintColor {
//    return UIColorWhite;
//}
//
///// 设置导航栏的背景图，默认为 NavBarBackgroundImage，
///// 可以修改 QMUIConfigurationTemplate 的 themeTintColor 来更改
//- (nullable UIImage *)qmui_navigationBarBackgroundImage;
//
///// 设置导航栏底部的分隔线图片，默认为 NavBarShadowImage，必须在 navigationBar 设置了背景图后才有效（系统限制如此）
///// 可以通过 QMUIConfigurationTemplate 的 navBarShadowImage、navBarShadowImageColor 来更改
//- (nullable UIImage *)qmui_navigationBarShadowImage;
//
///// 设置当前导航栏的 barTintColor，默认为 NavBarBarTintColor
///// 默认与 qmui_navigationBarTintColor 相同，可以自行更改
//- (nullable UIColor *)qmui_navigationBarBarTintColor;
//
///// 设置当前导航栏的 barStyle，默认为 NavBarStyle
///// 通过 QMUIConfigurationTemplate 的 navBarStyle 修改
//- (UIBarStyle)qmui_navigationBarStyle;
//
///// 设置当前导航栏的 UIBarButtonItem 的 tintColor，默认为NavBarTintColor
///// 通过 QMUIConfigurationTemplate 的 navBarBarTintColor 修改
//- (nullable UIColor *)qmui_navigationBarTintColor;

//#pragma mark ------------------------- set / get -------------------------
//#warning: -gg👇🏻这个代码会影响 不同颜色导航栏的控制器切换问题，所以不用了，注意布局问题
//- (UIRectEdge)edgesForExtendedLayout {
//    return UIRectEdgeNone;
//}

@end
