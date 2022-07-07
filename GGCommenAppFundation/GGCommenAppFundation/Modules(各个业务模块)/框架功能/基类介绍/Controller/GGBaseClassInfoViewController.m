//
//  GGBaseClassInfoViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/28.
//

#import "GGBaseClassInfoViewController.h"
#import "GGAppModulesDefine.h"
#import "MGJRouter+GG.h"

@interface GGBaseClassInfoViewController ()

@end

@implementation GGBaseClassInfoViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_BaseClass_OpenInfoViewController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        GGBaseClassInfoViewController *vc = [GGBaseClassInfoViewController new];
        
        UIViewController *preVC = param.senderData.preController;
        
        [preVC showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- Override -------------------------
- (NSArray<GGBaseFunctionsItem *> *)configFunctionsItems {
    NSArray *array = @[
        @{
            @"title": @"ViewController示例",
            @"sel": @"pv_jumpDetailVC",
        },
        @{
            @"title": @"TableViewController示例",
            @"sel": @"pv_jumpTableViewDemoVC",
        },
        @{
            @"title": @"分类栏控制器",
            @"sel": @"pv_jumpPagerVC",
        },
    ].mutableCopy;
    
    return [self buildFunctionsItemsWithKeyValues:array];
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
- (BOOL)autoShowNetStatusChangeAlertView {
    return NO;
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 展示detail控制器
- (void)pv_jumpDetailVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_BaseViewController_OpenBaseViewController withParam:param completion:nil];
}

#pragma mark --- 跳转列表示例控制器
- (void)pv_jumpTableViewDemoVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_BaseTableViewController_OpenBaseTableViewController withParam:param completion:nil];
}

#pragma mark --- 跳转Pager控制器
- (void)pv_jumpPagerVC {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_BaseFunctionsViewController_Open withParam:param completion:nil];
}

@end
