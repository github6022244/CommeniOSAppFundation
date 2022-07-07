//
//  UIViewController+UIBaseTableView.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
//

#import "UIViewController+UIBaseTableView.h"
#import <Masonry.h>
#import "NSArray+GG.h"

@implementation UIViewController (UIBaseTableView)

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(viewDidLoad), @selector(UIBaseTableView_viewDidLoad));
    });
}

- (void)UIBaseTableView_viewDidLoad {
    if ([self respondsToSelector:@selector(uibase_useTableViewControllerStyle)]) {
        BOOL use = [self uibase_useTableViewControllerStyle];
        if (use) {
            // 这里先添加 tableview 再 viewDidLoad，防止在 - (void)uibase_setUpSubViews; 里拿不到
            [self pv_addTableView];
        }
    }
    
    [self UIBaseTableView_viewDidLoad];
}

#pragma mark ------------------------- Interface -------------------------
- (void)tableViewEndRefreshing {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)tableViewEndRefreshingWithPageModel:(GGBasePageModel *)pageModel {
    [self tableViewEndRefreshing];
    
    if (self.tableView.mj_footer.isHidden) {
        self.tableView.mj_footer.hidden = NO;
    }
    
    if (pageModel.loadAndLessDataCount) {
        // 上拉加载 并且没有更多数据
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
    }
}

#pragma mark ------------------------- Private -------------------------
- (void)pv_addTableView {
    UITableViewStyle style = UITableViewStyleGrouped;
    if ([self respondsToSelector:@selector(uibase_tableViewStyle)]) {
        style = [self uibase_tableViewStyle];
    }
    
    self.tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:style];
    
    if ([self respondsToSelector:@selector(uibase_initTableView)]) {
        [self uibase_initTableView];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 如果设置了👇🏻这个代码，则 tableview 布局需要顶在 self.view 边缘
//        - (UIRectEdge)edgesForExtendedLayout {
//            return UIRectEdgeNone;
//        }
//        make.edges.equalTo(self.view);
        
        if (self.edgesForExtendedLayout == UIRectEdgeNone || self.edgesForExtendedLayout == UIRectEdgeTop) {
            make.edges.equalTo(self.view);
        } else {
            make.left.bottom.right.equalTo(self.view);
            make.top.mas_equalTo(self.qmui_navigationBarMaxYInViewCoordinator);
        }
    }];
    
    if ([self respondsToSelector:@selector(uibase_configTableView)]) {
        [self uibase_configTableView];
    }
    
    if ([self respondsToSelector:@selector(uibase_createARefreshHeader)]) {
        // 设置 header
        if (!self.tableView.mj_header) {
            MJRefreshHeader *header = [self uibase_createARefreshHeader];
            
            NSAssert(header, @"- (MJRefreshHeader *)uibase_createARefreshHeader; 协议返回nil");
            
            self.tableView.mj_header = header;
            
            __weak typeof(self) weakSelf = self;
            
            header.refreshingBlock = ^{
                if ([weakSelf respondsToSelector:@selector(tableViewRefreshWithType:)]) {
                    [weakSelf tableViewRefreshWithType:GGRefreshType_Refresh];
                }
            };
        }
    }
    
    if ([self respondsToSelector:@selector(uibase_createARefreshFooter)]) {
        // 设置 footer
        if (!self.tableView.mj_footer) {
            MJRefreshFooter *footer = [self uibase_createARefreshFooter];
            
            NSAssert(footer, @"- (MJRefreshFooter *)uibase_createARefreshFooter; 协议返回nil");
            
            self.tableView.mj_footer = footer;
            
            __weak typeof(self) weakSelf = self;
            
            footer.refreshingBlock = ^{
                if ([weakSelf respondsToSelector:@selector(tableViewRefreshWithType:)]) {
                    [weakSelf tableViewRefreshWithType:GGRefreshType_LoadMore];
                }
            };
            
            BOOL hideFooterAfterInitialied = NO;
            if ([self respondsToSelector:@selector(hideRefreshFooterAfterInitialied)]) {
                hideFooterAfterInitialied = [self hideRefreshFooterAfterInitialied];
                
                footer.hidden = hideFooterAfterInitialied;
            }
        }
    }
}

#pragma mark ------------------------- set / get -------------------------
- (QMUITableView *)tableView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTableView:(QMUITableView *)tableView {
    objc_setAssociatedObject(self, @selector(tableView), tableView, OBJC_ASSOCIATION_RETAIN);
}

//- (void)setNeedRefresh:(BOOL)needRefresh {
//    if (needRefresh) {
//        __weak typeof(self) weakSelf = self;
//        
//        // 设置 header
//        if (!self.tableView.mj_header) {
//            MJRefreshHeader *header = [self uibase_createARefreshHeader];
//            
//            NSAssert(header, @"- (MJRefreshHeader *)uibase_createARefreshHeader; 协议返回nil");
//            
//            self.tableView.mj_header = header;
//            
//            header.refreshingBlock = ^{
//                [weakSelf tableViewRefreshWithType:GGRefreshType_Refresh];
//            };
//        }
//        
//        // 设置 footer
//        if (!self.tableView.mj_footer) {
//            MJRefreshFooter *footer = [self uibase_createARefreshFooter];
//            
//            NSAssert(footer, @"- (MJRefreshFooter *)uibase_createARefreshFooter; 协议返回nil");
//            
//            self.tableView.mj_footer = footer;
//            
//            footer.refreshingBlock = ^{
//                [weakSelf tableViewRefreshWithType:GGRefreshType_LoadMore];
//            };
//        }
//    } else {
//        self.tableView.mj_header = nil;
//        self.tableView.mj_footer = nil;
//    }
//}

@end
