//
//  GGBaseTableViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
//

#import "GGBaseTableViewController.h"

@interface GGBaseTableViewController ()

@end

@implementation GGBaseTableViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpSubViews {
    [super uibase_setUpSubViews];
    
//    self.needRefresh = NO;
//#error -gg 将列表的 header 、footer 用协议方式控制，生成时机放到 - (void)uibase_setUpSubViews {} 里
}

- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    if (self.qmui_isPresented || self.qmui_previousViewController) {
        [self addNavBackBarItem];
    }
}

#pragma mark ------------------------- Interface -------------------------
- (void)uibase_initTableView {
    [super uibase_initTableView];
}

- (void)uibase_configTableView {
    [super uibase_configTableView];
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark --- Tableview Delegate 、DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark --- 刷新协议
- (MJRefreshHeader *)uibase_createARefreshHeader {
    return [CXGRefreshHeader headerWithRefreshingBlock:nil];
}

- (MJRefreshFooter *)uibase_createARefreshFooter {
    return [CXGRefreshFooter footerWithRefreshingBlock:nil];
}

- (void)tableViewRefreshWithType:(GGRefreshType)rType {
    // 一般处理网络请求
}

- (UITableViewStyle)uibase_tableViewStyle {
    return UITableViewStyleGrouped;
}

// 是否是一个 tableviewController
- (BOOL)uibase_useTableViewControllerStyle {
    return YES;
}

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

//#pragma mark-- empty dataSource and delegate
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
//    NSString *title = @"暂无数据";
//    NSDictionary *attributes = @{NSFontAttributeName : UIFont.qd_boldTitleTextFont,
//                                 NSForegroundColorAttributeName : UIColor.qd_titleTextColor};
//    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
//}
//
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"icon_bg_kongyemian"];
}
//
////- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
////    return self.tableViewEmptyView;
////}
//
//- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
//    return YES;
//}
//
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
//    return 15.f;
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
//    return -80.f;
//}
//
//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
//    return NO;
//}

//#pragma mark ------------------------- set / get -------------------------
//#warning: -gg👇🏻这个代码会影响 不同颜色导航栏的控制器切换问题，所以不用了，注意布局问题
//- (UIRectEdge)edgesForExtendedLayout {
//    return UIRectEdgeNone;
//}

@end
