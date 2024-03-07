//
//  GGBaseFuncSliderViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/7.
//

#import "GGBaseFuncSliderViewController.h"

@interface GGBaseFuncSliderViewController ()

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray<UIViewController *> *containSubControllers;

@end

@implementation GGBaseFuncSliderViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
}

#pragma mark ------------------------- Config -------------------------
- (void)config {
    self.titles = [self baseFuncSliderConfigTitles];
    
    self.containSubControllers = [self baseFuncSliderConfigSubControllers];
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpSubViews {
    [super uibase_setUpSubViews];
    
    [self.view addSubview:self.listContainerView];
    self.listContainerView.scrollView.backgroundColor = UIColorForBackground;
    
    [self.view addSubview:self.categoryView];

    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationContentTop);
        make.height.mas_equalTo(40);
        make.left.right.mas_equalTo(self.view);
    }];
    
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
//    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    QMUILog(nil, @"%@", NSStringFromSelector(_cmd));
}

#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return [self.containSubControllers gg_safeObjectAtIndex:index];
//    if (0 == index) {
//        return [CXGPurchasedEbookListViewController new];
//    } else if (1 == index) {
//        return [PurchasedOnlineCourseListViewController new];
//    } else if (2 == index) {
////        switch ([CXGUserInfoManager sharedManager].role_type) {
////            case UserInfoManagerRoleType_Student: {
//                return [CXGPurchasedGotGiftBagListViewController new];
////            }
////                break;
////            case UserInfoManagerRoleType_Teacher: {
////                return [MineTeachingMaterialOrderListViewController new];
////            }
////                break;
////        }
//    } else {
//        return [CXGPurchasedGotGiftBagListViewController new];
//    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}


#pragma mark ------------------------- Interface -------------------------
- (NSArray *)baseFuncSliderConfigTitles {
    return nil;
}

/// 配置子控制数组
/// 供子类重写
- (NSArray *)baseFuncSliderConfigSubControllers {
    return nil;
}

/// 刷新 title 与 subVC
- (void)baseRefreshTitles:(NSArray<NSString *> *)titles subControllers:(NSArray<UIViewController *> *)subControllers {
    self.categoryView.titles = titles;
    self.titles = titles;
    
    self.containSubControllers = subControllers;
    
    [self.categoryView reloadData];
    
//    [self.listContainerView reloadData];
}

#pragma mark ------------------------- set / get -------------------------
- (JXCategoryTitleView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
        _categoryView.listContainer = self.listContainerView;
        _categoryView.delegate = self;
        _categoryView.titles = [self baseFuncSliderConfigTitles];
        _categoryView.titleSelectedColor = UIColor.qd_tintColor;
        _categoryView.titleColor = UIColor.qd_mainTextColor;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.titleFont = [UIFont systemFontOfSize:14];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:14];
        _categoryView.cellSpacing = 24;
        _categoryView.contentEdgeInsetLeft = 16;
        _categoryView.averageCellSpacingEnabled = NO;
        _categoryView.titleLabelZoomEnabled = NO;
        _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    }
    return _listContainerView;
}

//#pragma mark ------------------------- Delegate / Protocol -------------------------
//#pragma mark --- 是否自动展示/隐藏网络状态改变提示图
//- (BOOL)autoShowNetStatusChangeAlertView {
//    return YES;
//}
//
//#pragma mark --- 导航栏相关
///// 设置每个界面导航栏的显示/隐藏，为了减少对项目的侵入性，默认不开启这个接口的功能，只有当 shouldCustomizeNavigationBarTransitionIfHideable 返回 YES 时才会开启此功能。如果需要全局开启，那么就在 Controller 基类里面返回 YES；如果是老项目并不想全局使用此功能，那么则可以在单独的界面里面开启。
///// 通过 QMUIConfigurationTemplate 的 navigationBarHiddenInitially 修改默认值(默认NO)
//- (BOOL)preferredNavigationBarHidden {
//    return NO;
//}
//
///**
// *  当切换界面时，如果不同界面导航栏的显隐状态不同，可以通过 shouldCustomizeNavigationBarTransitionIfHideable 设置是否需要接管导航栏的显示和隐藏。从而不需要在各自的界面的 viewWillAppear 和 viewWillDisappear 里面去管理导航栏的状态。
// *  @see UINavigationController+NavigationBarTransition.h
// *  @see preferredNavigationBarHidden
// */
//- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
//    return YES;
//}
//
///// 当自定义了`leftBarButtonItem`按钮之后，系统的手势返回就失效了。可以通过`forceEnableInteractivePopGestureRecognizer`来决定要不要把那个手势返回强制加回来。当 interactivePopGestureRecognizer.enabled = NO 或者当前`UINavigationController`堆栈的viewControllers小于2的时候此方法无效。
//- (BOOL)forceEnableInteractivePopGestureRecognizer {
//    return YES;
//}
//
///// 设置 titleView 的 tintColor
//- (nullable UIColor *)qmui_titleViewTintColor {
//    return UIColorWhite;
//}
//
////
/////// 设置导航栏的背景图，默认为 NavBarBackgroundImage，
/////// 可以修改 QMUIConfigurationTemplate 的 themeTintColor 来更改
////- (nullable UIImage *)qmui_navigationBarBackgroundImage;
////
/////// 设置导航栏底部的分隔线图片，默认为 NavBarShadowImage，必须在 navigationBar 设置了背景图后才有效（系统限制如此）
/////// 可以通过 QMUIConfigurationTemplate 的 navBarShadowImage、navBarShadowImageColor 来更改
////- (nullable UIImage *)qmui_navigationBarShadowImage;
////
/////// 设置当前导航栏的 barTintColor，默认为 NavBarBarTintColor
/////// 默认与 qmui_navigationBarTintColor 相同，可以自行更改
////- (nullable UIColor *)qmui_navigationBarBarTintColor;
////
/////// 设置当前导航栏的 barStyle，默认为 NavBarStyle
/////// 通过 QMUIConfigurationTemplate 的 navBarStyle 修改
////- (UIBarStyle)qmui_navigationBarStyle;
////
/////// 设置当前导航栏的 UIBarButtonItem 的 tintColor，默认为NavBarTintColor
/////// 通过 QMUIConfigurationTemplate 的 navBarBarTintColor 修改
////- (nullable UIColor *)qmui_navigationBarTintColor;

@end
