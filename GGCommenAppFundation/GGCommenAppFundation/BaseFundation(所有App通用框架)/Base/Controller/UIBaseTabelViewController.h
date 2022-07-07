//
//  MRBaseTabelViewController.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/6.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UIBaseViewController.h"
#import <GGBasePageModel.h>
#import <MJRefresh.h>
#import "UIViewController+UIBaseTableView.h"
#import "UIViewController+GGDEBUG.h"
#import "UIScrollView+EmptyDataSet.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIBaseTabelViewController : UIBaseViewController<
    GGUIBaseViewControllerDebugProtocol,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>

//@property (nonatomic, strong) QMUIEmptyView *tableViewEmptyView;

@end

NS_ASSUME_NONNULL_END
