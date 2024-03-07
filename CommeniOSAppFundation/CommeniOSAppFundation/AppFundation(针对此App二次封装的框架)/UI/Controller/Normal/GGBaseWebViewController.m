//
//  GGBaseWebViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/29.
//

#import "GGBaseWebViewController.h"

@interface GGBaseWebViewController ()

@end

@implementation GGBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/// 设置 titleView 的 tintColor
//- (nullable UIColor *)qmui_titleViewTintColor {
//    return UIColorWhite;
//}

@end
