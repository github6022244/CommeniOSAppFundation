//
//  MRBaseTabelViewController.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/6.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UIBaseTabelViewController.h"
#import <Masonry.h>
#import "NSArray+GG.h"
#import <QMUIKit.h>
#import "QMUISupport.h"

@interface UIBaseTabelViewController ()

@end

@implementation UIBaseTabelViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpSubViews {
    [super uibase_setUpSubViews];
    
//    self.tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
//    [self initTableView];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
////    self.tableView.estimatedRowHeight = 44.0;
//    self.tableView.emptyDataSetSource = self;
//    self.tableView.emptyDataSetDelegate = self;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.backgroundColor = UIColorMakeWithHex(@"#F7F7FA");
//    if (@available(iOS 11.0, *)) {
//        self.tableView.estimatedSectionFooterHeight = 0;
//        self.tableView.estimatedSectionHeaderHeight = 0;
//    } else {
//        
//    }
//    self.needRefresh = YES;
//    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.estimatedRowHeight = 44.0;
//        self.tableView.estimatedSectionFooterHeight = 0;
//        self.tableView.estimatedSectionHeaderHeight = 0;
//    } else {
//        
//    }
//    
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
}

- (BOOL)uibase_useTableViewControllerStyle {
    return YES;
}

- (UITableViewStyle)uibase_tableViewStyle {
    return UITableViewStylePlain;
}

#pragma mark ------------------------- Interface -------------------------
- (void)uibase_initTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (void)uibase_configTableView {
    
}

- (void)tableViewRefreshWithType:(GGRefreshType)rType {
    
}

//- (void)tableViewFooterConfigNoMoreDataWithPageModel:(GGBasePageModel *)pageModel {
//    if (pageModel.loadAndLessDataCount) {
//        [self tableViewFooterEndRefreshingWithNoMoreData];
//    } else {
//        [self tableViewFooterResetNoMoreData];
//    }
//}

//- (void)tableViewFooterEndRefreshingWithNoMoreData {
//    [self.tableView.mj_footer endRefreshingWithNoMoreData];
//    self.tableView.mj_footer.hidden = YES;
//}
//
//- (void)tableViewFooterResetNoMoreData {
//    [self.tableView.mj_footer resetNoMoreData];
//    self.tableView.mj_footer.hidden = NO;
//}
//
//- (void)tableViewEndRefreshing {
//    [self.tableView.mj_header endRefreshing];
//    [self.tableView.mj_footer endRefreshing];
//}

- (void)tableViewDeleteQueryAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (MJRefreshHeader *)uibase_createARefreshHeader {
    return [MJRefreshNormalHeader headerWithRefreshingBlock:nil];
}

- (MJRefreshFooter *)uibase_createARefreshFooter {
    return [MJRefreshAutoNormalFooter footerWithRefreshingBlock:nil];
}

#pragma mark ------------------------- Delegate -------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

// 点击了“左滑出现的Delete按钮”会调用这个方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self base_deleteQueryAtIndexPath:indexPath];

}

#pragma mark - empty dataSource and delegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"icon_bg_kongyemian"];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 15.f;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -80;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return NO;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

// 修改Delete按钮文字为“删除”
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return _canDelete;
}

//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
      return NO;
}

#pragma mark --- DEBUG
/// 是否在 debug 模式下，当显示出页面时打印类名
- (BOOL)debugLogClassName {
    return YES;
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 删除
- (void)base_deleteQueryAtIndexPath:(NSIndexPath *)indexPath {
    [self tableViewDeleteQueryAtIndexPath:indexPath];
}

#pragma mark ------------------------- set / get -------------------------
- (void)setNeedRefresh:(BOOL)needRefresh {
    _needRefresh = needRefresh;
    
    if (needRefresh) {
        __weak __typeof(self)weakSelf = self;
        if (!self.tableView.mj_header) {
            self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
                [weakSelf tableViewRefreshWithType:GGRefreshType_Refresh];
            }];
        }
        if (!self.tableView.mj_footer) {
            self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
                [weakSelf tableViewRefreshWithType:GGRefreshType_LoadMore];
            }];
        }
    } else {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    }
}

//- (QMUIEmptyView *)tableViewEmptyView {
//    if (!self.tableViewEmptyView && self.isViewLoaded) {
//        self.tableViewEmptyView = [[QMUIEmptyView alloc] initWithFrame:self.tableView.bounds];
//    }
//    return self.tableViewEmptyView;
//}

@end
