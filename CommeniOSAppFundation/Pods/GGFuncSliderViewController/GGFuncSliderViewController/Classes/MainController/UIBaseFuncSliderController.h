//
//  UIBaseFuncSliderController.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/8.
//  Copyright © 2020 ruikang. All rights reserved.
//  主控制器基类

#import <UIKit/UIKit.h>
#import "UIBaseFuncSliderMainControllerProtocol.h"
#import "UIBaseFuncSliderControllerRefreshProtocol.h"
#import <JXCategoryView/JXCategoryTitleView.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBaseFuncSliderController : UIViewController
<UIBaseFuncSliderMainControllerProtocol, UIBaseFuncSliderControllerRefreshProtocol, JXPagerViewDelegate, UIBasePagerViewDelegate, JXPagerMainTableViewGestureDelegate, JXCategoryViewDelegate, JXPagerViewDelegate, UIBasePagerViewDelegate>

@property (nonatomic, strong, readonly) UIBasePagerView *pagerView;

@property (nonatomic, strong, readonly) JXCategoryTitleView *categoryView;

@end


NS_ASSUME_NONNULL_END
