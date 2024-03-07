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
    QMUITableViewDelegate,
    QMUITableViewDataSource,
    GGUIBaseViewControllerDebugProtocol,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>

//@property (nonatomic, strong) QMUITableView *tableView;
//
//@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic, assign) BOOL needRefresh;// 是否需要刷新控件，默认 YES

@property (nonatomic, assign) BOOL canDelete;// 是否可以删除

//// tableview init 后立即调用，可以用来做一些初始化后的操作，比如注册cell
//- (void)initTableView;
//// 在所有布局完成后调用，可以做一些像是重新设定 tableview 的布局
//- (void)configTableView;

//// 刷新回调
//- (void)tableViewRefreshWithType:(GGRefreshType)rType;
//
//// 结束 tableview.mj_header .mj_footer 的loading
//- (void)tableViewEndRefreshing;
//
//// 根据传入的 pageModel 控制 .mj_footer 的文字状态
//- (void)tableViewFooterConfigNoMoreDataWithPageModel:(GGBasePageModel *)pageModel;

// 删除回调
- (void)tableViewDeleteQueryAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
