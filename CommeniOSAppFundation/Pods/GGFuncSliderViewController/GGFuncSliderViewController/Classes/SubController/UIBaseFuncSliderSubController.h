//
//  UIBaseFuncSliderSubController.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/8.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXPagingView/JXPagerListContainerView.h>
#import "UIBaseFuncSliderControllerRefreshProtocol.h"
#import "UIBaseFuncSliderSubControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIBaseFuncSliderSubController : UIViewController<UIBaseFuncSliderSubControllerProtocol, UITableViewDataSource, UITableViewDelegate, JXPagerViewListViewDelegate, UIBaseFuncSliderSubControllerConfigProtocol>

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, assign, getter=isShowing) BOOL showing;// 此页面是否正在展示

@property (nonatomic, weak) id<UIBaseFuncSliderControllerRefreshProtocol> delegate;// 这里其实是主控制器

/// 暴露一些简便方法给继承于本类的控制器调用
/// 开始/停止主控制器刷新
- (void)controlMainControllerHeaderEndRefresh;// (可在网络请求完成后调用)
- (void)controlMainControllerHeaderBeginRefresh;

@end

NS_ASSUME_NONNULL_END
