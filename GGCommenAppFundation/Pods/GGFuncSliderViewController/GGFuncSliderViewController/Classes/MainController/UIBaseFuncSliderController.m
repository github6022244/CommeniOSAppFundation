//
//  UIBaseFuncSliderController.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/8.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UIBaseFuncSliderController.h"
#import <QMUIKit/QMUICommonDefines.h>
#import <QMUIKit/UIColor+QMUI.h>
#import <QMUIKit/UIImage+QMUI.h>

@interface UIBaseFuncSliderController ()

@property (nonatomic, strong) UIBasePagerView *pagerView;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;

@property (nonatomic, strong) NSArray <NSString *> *titles;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation UIBaseFuncSliderController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

//    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
    if ([self autoAlphaNavigationBar]) {
        [self changeNavColorWithScrollView:self.pagerView.mainTableView];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self gg_setUpUI];
}

#pragma mark ------------------------- UI -------------------------
- (void)gg_setUpUI {
    if ([self autoAlphaNavigationBar]) {
//        if (@available(iOS 13.0, *)) {
//            _pagerView.mainTableView.automaticallyAdjustsScrollIndicatorInsets = NO;
//        } else if (@available(iOS 11.0, *)) {
//            _pagerView.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = NO;
//        }
//        
//        if (@available(iOS 15.0, *)) {
//           _pagerView.mainTableView.sectionHeaderTopPadding = 0.f;
//        }
        UIColor *firstColor = [self navigationBarDefaultAndFullColor].firstObject;
        NSAssert(firstColor, @"在 - (NSArray<UIColor *> *)navigationBarDefaultAndFullColor; 中返回颜色数组");
        
        UIImage *bgImage = [UIImage qmui_imageWithColor:firstColor];
        [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = bgImage;
    }
    
    _titles = [self categorySliderTitles];
    
    _headerView = [self configHeaderView];

    _categoryView = [self preferredCategoryView];
    
    [self configCategorySliderStyle];

    _pagerView = [self preferredPagingView];
    _pagerView.basePagerDelegate = self;
    self.pagerView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pagerView];
    self.pagerView.pinSectionHeaderVerticalOffset = NavigationContentTop;

    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    
    self.pagerView.listContainerView.categoryNestPagingEnabled = YES;
    
    //导航栏隐藏的情况，处理扣边返回，下面的代码要加上
//    [self.pagerView.listContainerView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
//    [self.pagerView.mainTableView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    
//    self.pagerView.mainTableView.mj_header = [self configRefreshHeader];
    [self configRefreshHeader];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagerView.frame = [self configPagerViewFrame];
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return self.headerView.frame.size.height;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return [self categorySliderHeight];
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.categoryView.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    return [self configPagerView:pagerView initListAtIndex:index];
}

- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView; {
    [self changeNavColorWithScrollView:scrollView];
    
    [self mainScrollDidScroll:scrollView];
}

//#pragma mark - JXCategoryViewDelegate
//- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
//    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
//}

#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark --- 子控制器要求 开始/停止刷新 回调
- (void)mainControllerBeginRefresh {

}

- (void)mainControllerEndRefresh {
    
}

- (BOOL)mainControllerIsRefreshing {
    return NO;
}

#pragma mark --- UIBasePagerViewDelegate
- (void)basePagerView_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

#pragma mark ------------------------- Protocol -------------------------
#pragma mark --- Pager View
// 有默认实现
- (UIBasePagerView *)preferredPagingView {
    return [[UIBasePagerView alloc] initWithDelegate:self];
}

// frame
- (CGRect)configPagerViewFrame {
    return self.view.bounds;
}

#pragma mark --- Category View
- (UIBaseFuncSliderControllerCategoryViewType)categoryViewType {
    return UIBaseFuncSliderControllerCategoryViewType_Title;
}

// 分类栏配置
- (JXCategoryTitleView *)preferredCategoryView {
    UIBaseFuncSliderControllerCategoryViewType cType = [self categoryViewType];
    
    switch (cType) {
        case UIBaseFuncSliderControllerCategoryViewType_Title: {
            _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [self categorySliderHeight])];
        }
            break;
        case UIBaseFuncSliderControllerCategoryViewType_TitleAndRedDot: {
            _categoryView = [[JXCategoryDotView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [self categorySliderHeight])];
        }
            break;
        default:
            break;
    }
    self.categoryView.titles = self.titles;
    
    self.categoryView.contentEdgeInsetLeft = 0.0;
    self.categoryView.contentEdgeInsetRight = 0.0;
    self.categoryView.cellSpacing = 0.0;
    self.categoryView.cellWidth = SCREEN_WIDTH / self.categoryView.titles.count;
    
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor qmui_colorWithHexString:@"#333333"];
    self.categoryView.titleFont = UIFontMake(14);
    self.categoryView.titleSelectedFont = UIFontBoldMake(14);
    self.categoryView.titleColor = [UIColor qmui_colorWithHexString:@"#666666"];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
    self.categoryView.separatorLineShowEnabled = YES;
    self.categoryView.separatorLineColor = [UIColor qmui_colorWithHexString:@"#EBEBEB"];
    self.categoryView.separatorLineSize = CGSizeMake(1/[UIScreen mainScreen].scale, 10);

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor blackColor];
    lineView.indicatorWidth = 30;
    lineView.verticalMargin = 8;
    self.categoryView.indicators = @[lineView];
    
    return _categoryView;
}

// 分类栏标题数组
- (NSArray *)categorySliderTitles {
    return @[];
}
// 分类栏高度
- (CGFloat)categorySliderHeight {
    return 50.0;
}
// 分类栏自定义配置
- (void)configCategorySliderStyle {
    
}

#pragma mark --- Header
// 下拉刷新控件
- (void)configRefreshHeader {
    
}

// 返回 headerView
- (UIView *)configHeaderView {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark --- 自动导航栏渐变
// 自动配置导航栏颜色配置
- (BOOL)autoAlphaNavigationBar {
    return NO;
}

// 在多少滑动距离内计算转换颜色
- (CGFloat)autoAlphaNavigationBarScrollOffset {
    return 100.f;
}

// 导航栏初始颜色/滑动动画最终颜色
- (NSArray<UIColor *> *)navigationBarDefaultAndFullColor {
    return nil;
}

#pragma mark --- 设置每个 item 对应的控制器
- (UIBaseFuncSliderSubController *)configPagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    return nil;
}

#pragma mark --- 其他
#pragma mark --- self.pagerView.maintableView 滑动回调
- (void)mainScrollDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 改变导航栏颜色
- (void)changeNavColorWithScrollView:(UIScrollView *)scrollView {
    if ([self autoAlphaNavigationBar]) {
        CGFloat thresholdDistance = [self autoAlphaNavigationBarScrollOffset];
        CGFloat percent = scrollView.contentOffset.y / thresholdDistance;
        percent = MAX(0, MIN(1, percent));
        
        NSArray *colorArray = [self navigationBarDefaultAndFullColor];
        
        if (colorArray.count) {
            UIColor *defaultColor = colorArray.firstObject;
            
            UIColor *fullColor = colorArray.lastObject;
            
            UIColor *targetColor = [defaultColor qmui_transitionToColor:fullColor progress:percent];
            
            UIImage *navBackImage = [UIImage qmui_imageWithColor:targetColor];
            
            [self.navigationController.navigationBar setBackgroundImage:navBackImage forBarMetrics:UIBarMetricsDefault];
            
            self.navigationController.navigationBar.shadowImage = navBackImage;
        }
    }
}

@end











