//
//  GGBaseFuncSliderOnlyCategoryViewController.m
//  ChangXiangGrain
//
//  Created by GG on 2023/5/15.
//  Copyright © 2023 ChangXiangCloud. All rights reserved.
//

#import "GGBaseFuncSliderOnlyCategoryViewController.h"

@interface GGBaseFuncSliderOnlyCategoryViewController ()

@end

@implementation GGBaseFuncSliderOnlyCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)uibase_setUpSubViews {
    [super uibase_setUpSubViews];
    
    [self.view addSubview:self.listContainerView];
    
    [self.view addSubview:self.categoryView];
    [self configCategoryView];

    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.left.right.mas_equalTo(self.view);
    }];

    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

//- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
//    //侧滑手势处理
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    QMUILog(nil, @"%@", NSStringFromSelector(_cmd));
}

#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return [[self configSubControllers] gg_safeObjectAtIndex:index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return [self configSubControllers].count;
}

//#pragma mark - JXPagerMainTableViewGestureDelegate
//
//- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
//    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
//        return NO;
//    }
//    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
//}

#pragma mark --- 子类实现
- (NSArray<NSString *> *)configTitles {
    return @[];
}

- (NSArray<UIViewController<JXCategoryListContentViewDelegate> *> *)configSubControllers {
    return @[];
}

- (void)configCategoryView {
    
}

#pragma mark ------------------------- set / get -------------------------
#pragma mark - Lazy
- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [[JXCategoryTitleView alloc] qmui_initWithSize:CGSizeMake(SCREEN_WIDTH, 40.f)];
        _categoryView.listContainer = self.listContainerView;
        _categoryView.delegate = self;
        _categoryView.titles = [self configTitles];
        _categoryView.titleSelectedColor = UIColor.qd_tintColor;
        _categoryView.titleColor = [UIColorBlack colorWithAlphaComponent:0.6];
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.titleFont = [UIFont systemFontOfSize:14];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:14];
        _categoryView.cellSpacing = 24;
        _categoryView.contentEdgeInsetLeft = 16;
        _categoryView.averageCellSpacingEnabled = NO;
        _categoryView.titleLabelZoomEnabled = NO;
        _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
        _categoryView.backgroundColor = UIColorForBackground;
        
//        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//        lineView.indicatorColor = RGBColor(0x3E6AF7);
//        lineView.indicatorWidth = 16;
//        _categoryView.indicators = @[ lineView ];
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

@end
