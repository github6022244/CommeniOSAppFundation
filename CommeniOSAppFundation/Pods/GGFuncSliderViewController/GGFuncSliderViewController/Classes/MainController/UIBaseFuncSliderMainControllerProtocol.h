//
//  UIBaseFuncSliderMainControllerProtocol.h
//  GGFuncSliderViewController
//
//  Created by GG on 2022/5/27.
//  主控制器子类可以配置的项

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GGFuncSliderDefine.h"
#import "UIBasePagerView.h"
#import "UIBaseFuncSliderSubController.h"
#import <JXCategoryView/JXCategoryView.h>

/// 需要 子类 按需 实现配置 的方法
@protocol UIBaseFuncSliderMainControllerProtocol <NSObject>

#pragma mark --- PagerView
@optional
// 有默认实现
- (UIBasePagerView *)preferredPagingView;// 返回自定义 pagerView
@required
// pagerView frame
- (CGRect)configPagerViewFrame;

#pragma mark --- CategoryView
@optional
// 返回分类栏类型
- (UIBaseFuncSliderControllerCategoryViewType)categoryViewType;
/// 返回自定义 categoryView
/// 有默认实现 可以获取到 self.categoryView
- (JXCategoryTitleView *)preferredCategoryView;
/// 这里可以获取到 self.categoryView，可以重新设置也可以修改其属性
/// 可以修改 self.categoryView.indicators
- (void)configCategorySliderStyle;
@required
// 分类栏配置
- (NSArray *)categorySliderTitles;// 返回分类标题数组
- (CGFloat)categorySliderHeight;// 分类栏高度

#pragma mark --- Header
/// 可以在这里配置主控制器的下拉刷新控件
/// 例如： self.pagerView.mainTableView = [MJRefreshHeader new];
- (void)configRefreshHeader;

// 返回自定义 headerView
- (UIView *)configHeaderView;

#pragma mark --- 自动导航栏渐变
// 随页面滑动改变导航栏颜色 的配置项
- (BOOL)autoAlphaNavigationBar;// 是否开启滑动导航栏渐变功能
// (注意下面👇🏻两个方法: 当 - (BOOL)autoAlphaNavigationBar; 返回 YES 才会调用）
- (CGFloat)autoAlphaNavigationBarScrollOffset;// 在多少滑动距离内计算导航栏转换颜色
- (NSArray<UIColor *> *)navigationBarDefaultAndFullColor;// 导航栏初始颜色、渐变导航栏最终颜色

#pragma mark --- 每个 item 对应控制器
@required
// 配置每一个分类对应的 控制器
- (UIBaseFuncSliderSubController *)configPagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index;

#pragma mark --- 其他
// self.pagerView.mainTableView 滑动回调
- (void)mainScrollDidScroll:(UIScrollView *)scrollView;

@end
