//
//  GGSubViewController.m
//  GGFuncSliderViewController_Example
//
//  Created by GG on 2022/5/27.
//  Copyright © 2022 1563084860@qq.com. All rights reserved.
//

#import "GGSubViewController.h"
#import <QMUIKit/UIColor+QMUI.h>
#import <MJRefresh/MJRefresh.h>
#import <QMUIKit/QMUICommonDefines.h>
#import <QMUIKit/QMUIConfigurationMacros.h>
#import <QMUIKit/UIView+QMUI.h>
#import <QMUILog.h>
#import "UIViewController+GG.h"
#import "GGAppModulesDefine.h"
#import "QDThemeManager.h"

#import "GGViewController.h"
#import "UIViewController+UIBase.h"
#import "GGBaseTableViewCell.h"

@interface GGSubViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation GGSubViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark ------------------------- Config -------------------------
- (void)uibase_config {
    _dataSource = @[
        @{
            @"title": @"选择图片",
            @"sel": @"pv_showPicker",
        },
        @{
            @"title": @"基类介绍示例",
            @"sel": @"pv_jumpBaseClassInfoVC",
        },
        @{
            @"title": @"改变导航栏颜色",
            @"sel": @"pv_jumpChangeNavColorVC",
        },
        @{
            @"title": @"权限请求",
            @"sel": @"pv_jumpPermissionVC",
        },
        @{
            @"title": @"网络请求",
            @"sel": @"pv_jumpNetTestVC",
        },
        @{
            @"title": @"缓存处理",
            @"sel": @"pv_jumpMemoryVC",
        },
        @{
            @"title": @"DEBUG打印控制器类名",
            @"sel": @"pv_jumpDEBUGVC",
        },
        @{
            @"title": @"Router",
            @"sel": @"pv_jumpRouterVC",
        },
    ];
}

#pragma mark ------------------------- Net -------------------------
#pragma mark --- 刷新方法
/// @param isHeaderRefresh 是否是 header 下拉刷新
- (void)tableViewRefreshWithIsHeaderRefresh:(BOOL)isHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    
    // 模拟耗时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (isHeaderRefresh) {
            // 下拉刷新
            [weakSelf controlMainControllerHeaderEndRefresh];
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            // footer 上拉加载
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    });
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpSubViews {
    self.view.backgroundColor = UIColorWhite;
}

- (void)initTableView {
    [self.tableView registerClass:[GGBaseTableViewCell class] forCellReuseIdentifier:@"GGBaseTableViewCell"];
}

- (void)configTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = UIColorMakeWithHex(@"EBEBEB");
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf tableViewRefreshWithIsHeaderRefresh:NO];
    }];
}

#pragma mark ------------------------- Delegate -------------------------
- (CGRect)layoutuibase_configTableViewFrame {
    return self.view.bounds;
}

- (void)UIBaseFuncSliderControllerHeaderRefresh {
    if (self.isShowing) {
        [self tableViewRefreshWithIsHeaderRefresh:YES];
    }
}

- (void)listDidAppear {
//    if (self.isShowing && <#是不是空数据#>) {
//        [self tableViewRefreshWithIsHeaderRefresh:YES];
//    }
    if (self.isShowing) {
        [self tableViewRefreshWithIsHeaderRefresh:YES];
    }
}

#pragma mark --- TableView Delegate 、 DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = _dataSource[indexPath.section];
    
    GGBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GGBaseTableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = dict[@"title"];
    
    cell.contentView.backgroundColor = [UIColor qmui_randomColor];
    cell.textLabel.textColor = UIColorForBackground;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = _dataSource[indexPath.section];
    
    NSString *sel = dict[@"sel"];
    
    BeginIgnorePerformSelectorLeaksWarning
    [self performSelector:NSSelectorFromString(sel)];
    EndIgnorePerformSelectorLeaksWarning
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 展示图片选择器
- (void)pv_showPicker {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_Photo_OpenPhotoController withParam:param completion:nil];
}

#pragma mark --- 跳转基类介绍
- (void)pv_jumpBaseClassInfoVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_BaseClass_OpenInfoViewController withParam:param completion:nil];
}

#pragma mark --- 跳转导航栏颜色不同的控制器
- (void)pv_jumpChangeNavColorVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_NavChangeColor_OpenNavChangeColorController withParam:param completion:nil];
}

#pragma mark --- 跳转权限请求
- (void)pv_jumpPermissionVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_Permission_OpenPermissionController withParam:param completion:nil];
}

#pragma mark --- 跳转网络请求VC
- (void)pv_jumpNetTestVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_Net_OpenNetTestController withParam:param completion:nil];
}

#pragma mark --- 跳转缓存VC
- (void)pv_jumpMemoryVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    [MGJRouter gg_openURL:GGModulesUrl_Caches_OpenCachesController withParam:param completion:nil];
}

#pragma mark --- 跳转DEBUG控制器
- (void)pv_jumpDEBUGVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_DEBUG_OpenDEUBGController withParam:param completion:^(id  _Nullable data) {
        QMUILog(@"completion", @"%@", data);
    }];
}

#pragma mark --- 跳转router控制器
- (void)pv_jumpRouterVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_Router_OpenMGJRouterController withParam:param completion:nil];
}

@end

