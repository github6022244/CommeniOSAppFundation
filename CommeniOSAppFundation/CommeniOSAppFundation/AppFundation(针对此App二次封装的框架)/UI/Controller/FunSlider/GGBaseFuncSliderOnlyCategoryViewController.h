//
//  GGBaseFuncSliderOnlyCategoryViewController.h
//  ChangXiangGrain
//
//  Created by GG on 2023/5/15.
//  Copyright © 2023 ChangXiangCloud. All rights reserved.
/// 不能设置 headerView，只有CategoryView

#import "GGBaseViewController.h"

#import <JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGBaseFuncSliderOnlyCategoryViewController : GGBaseViewController<JXCategoryListContainerViewDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

/// 配置子控制器
- (NSArray<UIViewController<JXCategoryListContentViewDelegate> *> *)configSubControllers;

/// 配置子标题
- (NSArray<NSString *> *)configTitles;

/// 子类重写
- (void)configCategoryView;

@end

NS_ASSUME_NONNULL_END
