//
//  GGViewController.m
//  GGFuncSliderViewController_Example
//
//  Created by GG on 2022/5/27.
//  Copyright © 2022 1563084860@qq.com. All rights reserved.
//

#import "GGViewController.h"
#import "GGSubViewController.h"
#import <QMUIKit/UIColor+QMUI.h>
#import <MJRefresh/MJRefresh.h>
#import <QMUIKit/QMUICommonDefines.h>
#import <QMUIKit/QMUIConfigurationMacros.h>
#import <QMUIKit/UIView+QMUI.h>
#import <QMUIKit/UIImage+QMUI.h>
#import <YYKit.h>

#import "QMUIInteractiveDebugger.h"
#import "UIViewController+UIBase.h"
#import "GGAppModulesDefine.h"
#import "MGJRouter+GG.h"

@interface GGViewController ()

@property (nonatomic, strong) NSArray *subControllersArray;// 存储子控制器的数组

@property (nonatomic, strong) UIView *headerView;// header view

@property (nonatomic, strong) QMUINavigationButton *navDebugButton;

@end

@implementation GGViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_BaseFunctionsViewController_Open toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        GGViewController *vc = [GGViewController new];
        
        [param.senderData.preController showControllerInSameWay:vc animated:YES block:nil];
    }];
    
    [MGJRouter gg_registerURLPattern:GGModulesUrl_BaseFunctionsViewController_Get toObjectHandler:^id _Nullable(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        return [GGViewController new];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 为了设置导航栏标题颜色、导航栏颜色 不会被下个控制器影响
    [self mainScrollDidScroll:self.pagerView.mainTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark ------------------------- Net -------------------------
#pragma mark --- header 刷新
- (void)headerRefresh {
    GGSubViewController *subVC = _subControllersArray[self.categoryView.selectedIndex];
    [subVC UIBaseFuncSliderControllerHeaderRefresh];
}

#pragma mark ------------------------- Config -------------------------
- (void)uibase_config {
    NSMutableArray *marr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 2; i++) {
        GGSubViewController *vc = [[GGSubViewController alloc] init];
        vc.delegate = self;
        
        [marr addObject:vc];
    }
    
    _subControllersArray = marr;
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpSubViews {
    // 设置 pagerView 距离上方悬停距离
    self.pagerView.pinSectionHeaderVerticalOffset = NavigationContentTop;
}

- (void)uibase_setUpNavigationItems {
    self.title = @"主控制器";
    
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: UIColorClear,
    };
    
    QMUINavigationButton *navDebugButton = [[QMUINavigationButton alloc] initWithType:QMUINavigationButtonTypeNormal title:@"UITabBar调试"];
    _navDebugButton = navDebugButton;
    _navDebugButton.adjustsImageTintColorAutomatically = NO;
    [_navDebugButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
    
    UIBarButtonItem *debugItem = [UIBarButtonItem qmui_itemWithTitle:@"UITabBar调试" target:self action:@selector(actions_clickNavDebugTabbar)];
    
    /// @warning
    /// 勿用 self.navigationController.navigationItem.xxx ，不起作用
//    self.navigationController.navigationItem.rightBarButtonItem = item;
    self.navigationItem.rightBarButtonItem = debugItem;
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark --- 配置 Pager View
// 自己配置 pagerView ，有默认实现
- (JXPagerView *)preferredPagingView {
    JXPagerView *view = [super preferredPagingView];
    view.mainTableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#F7F7F7"];
    return view;
}

#pragma mark --- 配置 CategoryView
// 自己配置 categoryView
- (void)configCategorySliderStyle {
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15 * 2, [self categorySliderHeight])];
    cover.layer.cornerRadius = 6.0;
    cover.backgroundColor = UIColorWhite;
    cover.userInteractionEnabled = YES;
    
    [self.categoryView addSubview:cover];
    [self.categoryView sendSubviewToBack:cover];
    self.categoryView.backgroundColor = UIColorClear;
    
    self.categoryView.contentEdgeInsetLeft = 15.0;
    self.categoryView.contentEdgeInsetRight = 15.0;
    self.categoryView.cellWidth = (SCREEN_WIDTH - cover.qmui_left * 2) / [self categorySliderTitles].count;
}

- (CGRect)configPagerViewFrame {
    CGRect baseRect = [super configPagerViewFrame];
    
    baseRect = CGRectSetY(baseRect, - NavigationContentTop);
    baseRect = CGRectSetHeight(baseRect, SCREEN_HEIGHT);
    
    return baseRect;
}

// 分类栏标题数组
- (NSArray *)categorySliderTitles {
    return @[@"子控制器-1", @"子控制器-2"];
}

// 分类栏高度
- (CGFloat)categorySliderHeight {
    return 50.f;
}

#pragma mark --- 配置 Header
// 下拉刷新控件
- (void)configRefreshHeader {
    __weak typeof(self) ws = self;
    self.pagerView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws headerRefresh];
    }];
}

// 返回 headerView
- (UIView *)configHeaderView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300.0)];
    
    header.backgroundColor = [UIColor qmui_randomColor];
    
    UILabel *label = [[UILabel alloc] qmui_initWithSize:header.mj_size];
    [header addSubview:label];
    label.text = @"Header View";
    label.font = UIFontBoldMake(20.f);
    label.textAlignment = NSTextAlignmentCenter;
    
    self.headerView = header;
    
    return header;
}

#pragma mark --- 设置每一页的控制器
/// 每一页的控制器
- (UIBaseFuncSliderSubController *)configPagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    return _subControllersArray[index];
}

#pragma mark --- 导航栏配置
// 是否开启自动导航栏渐变
- (BOOL)autoAlphaNavigationBar {
    return YES;
}
// 在多少滑动距离内计算导航栏转换颜色
- (CGFloat)autoAlphaNavigationBarScrollOffset {
    return self.headerView.qmui_height - NavigationContentTop;
}

// 导航栏初始颜色/滑动动画最终颜色
- (NSArray<UIColor *> *)navigationBarDefaultAndFullColor {
    return @[
        UIColorClear,
        UIColorBlue,
    ];
}

#pragma mark --- 子控制器要求 开始/停止刷新 回调
// 主控制器开始刷新
- (void)mainControllerBeginRefresh {
    if (!self.pagerView.mainTableView.mj_header.isRefreshing) {
        [self.pagerView.mainTableView.mj_header beginRefreshing];
    }
}
// 主控制器停止刷新
- (void)mainControllerEndRefresh {
    [self.pagerView.mainTableView.mj_header endRefreshing];
}
// 主控制器是否在刷新
- (BOOL)mainControllerIsRefreshing {
    return self.pagerView.mainTableView.mj_header.isRefreshing;
}

#pragma mark --- 其他
// self.pagerView.mainTableView 滑动回调
- (void)mainScrollDidScroll:(UIScrollView *)scrollView {
    CGFloat thresholdDistance = [self autoAlphaNavigationBarScrollOffset];
    CGFloat percent = scrollView.contentOffset.y / thresholdDistance;
    percent = MAX(0, MIN(1, percent));
    
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColorBlack colorWithAlphaComponent:percent],
    };
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

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- UITabbar调试
- (void)actions_clickNavDebugTabbar {
    [QMUIInteractiveDebugger presentTabBarDebuggerInViewController:self];
}

#pragma mark ------------------------- set / get -------------------------
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
