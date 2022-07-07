//
//  UIBaseFuncSliderSubController.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/8.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UIBaseFuncSliderSubController.h"
#import <QMUIKit/QMUILog.h>

@interface UIBaseFuncSliderSubController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

@implementation UIBaseFuncSliderSubController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self gg_setUpUI];
}

#pragma mark ------------------------- UI -------------------------
- (void)gg_setUpUI {
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self initTableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 44.0;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //列表的contentInsetAdjustmentBehavior失效，需要自己设置底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self configTableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.tableView.frame = [self layoutConfigTableViewFrame];
}

#pragma mark ------------------------- Protocol -------------------------
- (void)initTableView {
    
}

- (void)configTableView {
    
}

- (CGRect)layoutConfigTableViewFrame {
    return self.view.bounds;
}

#pragma mark ------------------------- Interface -------------------------
- (void)controlMainControllerHeaderEndRefresh {
    if ([_delegate respondsToSelector:@selector(mainControllerEndRefresh)]) {
        [_delegate mainControllerEndRefresh];
    }
}

- (void)controlMainControllerHeaderBeginRefresh {
    if ([_delegate respondsToSelector:@selector(mainControllerBeginRefresh)]) {
        [_delegate mainControllerBeginRefresh];
    }
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listWillAppear {
    _showing = YES;
}

- (void)listDidAppear {
    _showing = YES;
}

- (void)listWillDisappear {
    _showing = NO;
}

- (void)listDidDisappear {
    _showing = NO;
}

#pragma mark ------------------------- Delegate -------------------------
// 主控制器下拉刷新回调
- (void)UIBaseFuncSliderControllerHeaderRefresh {
    [self controlMainControllerHeaderEndRefresh];
}

@end
