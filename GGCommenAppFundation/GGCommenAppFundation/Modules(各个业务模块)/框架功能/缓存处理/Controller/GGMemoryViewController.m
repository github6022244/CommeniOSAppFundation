//
//  GGMemoryViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/8.
//

#import "GGMemoryViewController.h"
#import "GGAppManager.h"
#import "GGBaseCXGAlertView.h"
#import "GGAddCachesViewController.h"
#import "GGAppModulesDefine.h"

@interface GGMemoryViewController ()

@property (nonatomic, strong) QMUIGridView *gridView;

@end

@implementation GGMemoryViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_Caches_OpenCachesController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        UIViewController *preVC = param.senderData.preController;
        
        GGMemoryViewController *vc = [GGMemoryViewController new];
        
        [preVC showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    self.title = @"缓存处理";
    
    QMUINavigationButton *button = [[QMUINavigationButton alloc] initWithType:QMUINavigationButtonTypeNormal];
    [button setTitle:@"添加缓存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actions_clickNavAddCaches:) forControlEvents:UIControlEventTouchUpInside];
    button.qmui_size = CGSizeMake(44.0, 44.0);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

#pragma mark ------------------------- Override -------------------------
- (NSArray<GGBaseFunctionsItem *> *)configFunctionsItems {
    NSArray *array = @[
        @"获取所有缓存(包含磁盘)大小",
        @"获取图片缓存(磁盘)大小",
        @"获取网络请求缓存大小",
        @"清图片缓存",
        @"清网络请求缓存",
        @"清所有缓存",
    ];
    
    NSMutableArray *marr_data = @[].mutableCopy;
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        NSString *actionName = [NSString stringWithFormat:@"test_action%ld", (long)i];
        
        GGBaseFunctionsItem *item = [GGBaseFunctionsItem itemWithTitle:obj selectorName:actionName];
        
        [marr_data addObject:item];
    }];
    
    return marr_data;
}

#pragma mark ------------------------- Actions -------------------------
- (void)test_action0 {
    NSString *cachesSize = [GGAppManager getCacheSizeWithType:GGAppManagerClearMemoryTypeAll];
    
    NSString *title = [self pv_getFuncTitle:_cmd];
    
    [GGBaseCXGAlertView alertViewWithTitle:title subTitle:cachesSize leftCancelButtonTitle:@"确定" rightDownButtonTitle:nil inView:nil block:nil];
}

- (void)test_action1 {
    NSString *cachesSize = [GGAppManager getCacheSizeWithType:GGAppManagerClearMemoryTypeImage];
    
    NSString *title = [self pv_getFuncTitle:_cmd];
    
    [GGBaseCXGAlertView alertViewWithTitle:title subTitle:cachesSize leftCancelButtonTitle:@"确定" rightDownButtonTitle:nil inView:nil block:nil];
}

- (void)test_action2 {
    NSString *cachesSize = [GGAppManager getCacheSizeWithType:GGAppManagerClearMemoryTypeYTKNetWork];
    
    NSString *title = [self pv_getFuncTitle:_cmd];
    
    [GGBaseCXGAlertView alertViewWithTitle:title subTitle:cachesSize leftCancelButtonTitle:@"确定" rightDownButtonTitle:nil inView:nil block:nil];
}

- (void)test_action3 {
    __weak __typeof(self)weakSelf = self;
    [GGAppManager clearMemoryWithType:GGAppManagerClearMemoryTypeImage complateBlock:^{
        [weakSelf test_action1];
    }];
}

- (void)test_action4 {
    __weak __typeof(self)weakSelf = self;
    [GGAppManager clearMemoryWithType:GGAppManagerClearMemoryTypeYTKNetWork complateBlock:^{
        [weakSelf test_action2];
    }];
}

- (void)test_action5 {
    __weak __typeof(self)weakSelf = self;
    [GGAppManager clearMemoryWithType:GGAppManagerClearMemoryTypeAll complateBlock:^{
        [weakSelf test_action0];
    }];
}

#pragma mark --- 点击添加缓存
- (void)actions_clickNavAddCaches:(id)sender {
    GGAddCachesViewController *vc = [GGAddCachesViewController new];
    
    [self showControllerInSameWay:vc animated:YES block:nil];
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 获取方法下标
- (NSString *)pv_getFuncTitle:(SEL)selector {
    NSString *funcStr = NSStringFromSelector(selector);
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"selectorName = %@", funcStr];
    
    GGBaseFunctionsItem *item = [self.itemsArray filteredArrayUsingPredicate:pre].firstObject;
    
    return item.title;
}

@end
