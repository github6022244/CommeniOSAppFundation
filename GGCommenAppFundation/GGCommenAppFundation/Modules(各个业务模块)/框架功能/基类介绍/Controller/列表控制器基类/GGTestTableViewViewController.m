//
//  GGTestTableViewViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
//

#import "GGTestTableViewViewController.h"
#import "GGCommenDefine.h"
#import "UILabel+GG.h"
#import "GGBaseVCFuncDesView.h"
#import <Masonry.h>
#import "MGJRouter+GG.h"
#import "GGAppModulesDefine.h"

@interface GGTestTableViewViewController ()

@property (nonatomic, strong) GGBasePageModel *pageModel;

@property (nonatomic, strong) GGBaseVCFuncDesView *headerView;

@end

@implementation GGTestTableViewViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_BaseTableViewController_OpenBaseTableViewController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        UIViewController *preVC = param.senderData.preController;
        
        GGTestTableViewViewController *vc = [GGTestTableViewViewController new];
        
        [preVC showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self api_requestListDataWithRefreshType:GGRefreshType_Refresh];
}

#pragma mark ------------------------- Net -------------------------
- (void)api_requestListDataWithRefreshType:(GGRefreshType)rType {
    [QMUITips showLoadingInView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self tableViewEndRefreshing];
        
        [QMUITips hideAllTipsInView:self.view];
        
        if (self.isNetReachable) {
            [QMUITips showSucceed:@"请求完成"];
            
            [self.pageModel refreshDataSourceWithArray:@[@1, @2, @3, @4] refreshType:GGRefreshType_Refresh];
            [self.tableView reloadData];
        }
        
        [self tableViewEndRefreshingWithPageModel:self.pageModel];
    });
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    self.title = @"GGBaseTableViewController子类";
}

- (void)uibase_setUpSubViews {
    [super uibase_setUpSubViews];
    
}

- (void)uibase_initTableView {
    [super uibase_initTableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)uibase_configTableView {
    [super uibase_configTableView];
}

- (BOOL)hideRefreshFooterAfterInitialied {
    return YES;
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark --- Tableview Delegate 、DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pageModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = NSStringFormat(@"Index: %ld %ld", (long)indexPath.section, (long)indexPath.row);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.1;
    return self.headerView.qmui_height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return [UIView new];
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

#pragma mark --- 刷新协议
- (MJRefreshHeader *)uibase_createARefreshHeader {
    return [MJRefreshNormalHeader headerWithRefreshingBlock:nil];
}

- (MJRefreshFooter *)uibase_createARefreshFooter {
    return [MJRefreshAutoNormalFooter footerWithRefreshingBlock:nil];
}

- (void)tableViewRefreshWithType:(GGRefreshType)rType {
    // 一般处理网络请求
    QMUILog(nil, @"刷新");
    
    [self api_requestListDataWithRefreshType:rType];
}

- (UITableViewStyle)uibase_tableViewStyle {
    return UITableViewStyleGrouped;
}

// 是否是一个 tableviewController
- (BOOL)uibase_useTableViewControllerStyle {
    return YES;
}

#pragma mark --- 自动显隐无网络视图
- (BOOL)autoShowNetStatusChangeAlertView {
    // 如果无内容，则自动显示，如果有列表数据则不显示
    return !self.pageModel.dataSource.count;
}

#pragma mark --- EmptyData
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return !self.pageModel.dataSource.count;
}

#pragma mark ------------------------- set / get -------------------------
- (GGBasePageModel *)pageModel {
    if (!_pageModel) {
        _pageModel = [GGBasePageModel new];
    }
    
    return _pageModel;
}

- (GGBaseVCFuncDesView *)headerView {
    if (!_headerView) {
        _headerView = [GGBaseVCFuncDesView view];
    }
    
    return _headerView;
}

@end
