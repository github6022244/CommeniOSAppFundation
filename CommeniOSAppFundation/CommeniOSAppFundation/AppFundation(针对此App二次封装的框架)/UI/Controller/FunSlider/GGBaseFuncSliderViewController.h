//
//  GGBaseFuncSliderViewController.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/7.
//

//#import <UIBaseFuncSliderController.h>
//#import "UIViewController+GGNetWorkAlert.h"
//#import <QMUIKit.h>
#import "GGBaseViewController.h"

#import <JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGBaseFuncSliderViewController : GGBaseViewController<JXCategoryListContainerViewDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

/// 配置分类标题数组
/// 供子类重写
/// @warning 适用于定死 titles 的情况
- (NSArray *)baseFuncSliderConfigTitles;

/// 配置子控制数组
/// 供子类重写
/// @warning 适用于定死 subVC 的情况
- (NSArray<UIViewController *> *)baseFuncSliderConfigSubControllers;

/// 刷新 title 与 subVC
- (void)baseRefreshTitles:(NSArray<NSString *> *)titles subControllers:(NSArray<UIViewController *> *)subControllers;

@end

NS_ASSUME_NONNULL_END
