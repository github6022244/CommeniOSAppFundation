//
//  GGTestPermissionViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/6.
//

#import "GGTestPermissionViewController.h"
#import "WMZPermission.h"
#import "QMUIButton+GG.h"
#import "GGCommenDefine.h"
#import "MGJRouter+GG.h"
#import "GGAppModulesDefine.h"

@interface GGTestPermissionViewController ()

@property (nonatomic, strong) QMUIGridView *gridView;

@end

@implementation GGTestPermissionViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_Permission_OpenPermissionController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        UIViewController *preVC = param.senderData.preController;
        
        GGTestPermissionViewController *vc = [GGTestPermissionViewController new];
        
        [preVC showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    self.title = @"权限";
}

#pragma mark ------------------------- Override -------------------------
- (NSArray<GGBaseFunctionsItem *> *)configFunctionsItems {
    NSArray *array = @[
        @"相机权限",
        @"相册权限",
        @"位置权限(使用中)",
        @"位置权限(一直使用)",
    ];
    
    NSMutableArray *marr_data = @[].mutableCopy;
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *selStr = NSStringFormat(@"actions_request%ld", (long)idx);
        
        GGBaseFunctionsItem *item = [GGBaseFunctionsItem itemWithTitle:obj selectorName:selStr];
        
        [marr_data addObject:item];
    }];
    
    return marr_data;
}

#pragma mark ------------------------- Actions -------------------------
- (void)actions_request0 {
    [[WMZPermission shareInstance] permissonType:PermissionTypeCamera withHandle:^(BOOL granted, NSNumber *data) {
        QMUILog(nil, @"请求权限结果: %ld, %ld", (long)granted, (long)data.integerValue);
    }];
}

- (void)actions_request1 {
    [[WMZPermission shareInstance] permissonType:PermissionTypePhoto withHandle:^(BOOL granted, NSNumber *data) {
        QMUILog(nil, @"请求权限结果: %ld, %ld", (long)granted, (long)data.integerValue);
    }];
}

- (void)actions_request2 {
    [[WMZPermission shareInstance] permissonType:PermissionTypeLocationWhen withHandle:^(BOOL granted, NSNumber *data) {
        QMUILog(nil, @"请求权限结果: %ld, %ld", (long)granted, (long)data.integerValue);
    }];
}

- (void)actions_request3 {
    [[WMZPermission shareInstance] permissonType:PermissionTypeLocationAlways withHandle:^(BOOL granted, NSNumber *data) {
        QMUILog(nil, @"请求权限结果: %ld, %ld", (long)granted, (long)data.integerValue);
    }];
}

@end
