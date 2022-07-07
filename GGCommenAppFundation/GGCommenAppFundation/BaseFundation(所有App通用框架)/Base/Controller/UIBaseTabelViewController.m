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
#import "QDThemeManager.h"

@interface UIBaseTabelViewController ()

@end

@implementation UIBaseTabelViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- UI -------------------------

#pragma mark ------------------------- Interface -------------------------
- (void)uibase_initTableView {
    
}

- (void)uibase_configTableView {
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- Tableview Delegate 、DataSource
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

#pragma mark --- 刷新协议
- (MJRefreshHeader *)uibase_createARefreshHeader {
    return nil;
}

- (MJRefreshFooter *)uibase_createARefreshFooter {
    return nil;
}

- (void)tableViewRefreshWithType:(GGRefreshType)rType {
    // 一般处理网络请求
}

- (UITableViewStyle)uibase_tableViewStyle {
    return UITableViewStyleGrouped;
}

// 是否是一个 tableviewController
- (BOOL)uibase_useTableViewControllerStyle {
    return YES;
}

#pragma mark-- empty dataSource and delegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{NSFontAttributeName : UIFont.qd_boldTitleTextFont,
                                 NSForegroundColorAttributeName : UIColor.qd_titleTextColor};
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_placeholder"];
}

//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
//    return self.tableViewEmptyView;
//}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 15.f;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -80.f;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return NO;
}

#pragma mark --- DEBUG
/// 是否在 debug 模式下，当显示出页面时打印类名
- (BOOL)debugLogClassName {
    return YES;
}

#pragma mark ------------------------- set / get -------------------------
//- (QMUIEmptyView *)tableViewEmptyView {
//    if (!_tableViewEmptyView && self.isViewLoaded) {
//        _tableViewEmptyView = [[QMUIEmptyView alloc] initWithFrame:self.tableView.bounds];
//    }
//    return _tableViewEmptyView;
//}

@end
