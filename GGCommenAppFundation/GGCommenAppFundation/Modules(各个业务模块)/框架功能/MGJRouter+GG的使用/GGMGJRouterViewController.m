//
//  GGMGJRouterViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/27.
//

#import "GGMGJRouterViewController.h"
#import "GGAppModulesDefine.h"
#import "GGCommenDefine.h"
#import "MGJRouter+GG.h"
#import "GGBaseCXGAlertView.h"
#import <NSDictionary+YYAdd.h>

@interface GGMGJRouterViewController ()

@end

@implementation GGMGJRouterViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    // 页面跳转
    [MGJRouter gg_registerURLPattern:GGModulesUrl_Router_OpenMGJRouterController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        
        [self _jumpNewVCWithPreVC:param.senderData.preController];
        
    }]; 
    
    // 处理逻辑
    [MGJRouter gg_registerURLPattern:GGModulesUrl_Router_OpenHandleEvent toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        [self _jumpNewVCWithPreVC:param.senderData.preController];
    }];
    
    // 获取object
    [MGJRouter gg_registerURLPattern:GGModulesUrl_Router_GetObject toObjectHandler:^id _Nullable(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        return [self _returnObjectWithAcceptValue:nil returnValue:@"321"];
    }];
    
    // 自定义传参在 GGMGJRouterAlertViewController
    
    // 处理返回值block
    [MGJRouter gg_registerURLPattern:GGModulesUrl_Router_HandleReturnBlock toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        NSString *subTitle = [NSString stringWithFormat:@"①传过来的参数:%@\n②completion block:%@\n③点击确定将调用 completion block", param.senderData.data, param.senderData.completion];
        
        [GGBaseCXGAlertView alertViewWithTitle:@"处理返回值block" subTitle:subTitle subTitleTextViewConfigBlock:^(QMUITextView *textView) {
            textView.textAlignment = NSTextAlignmentLeft;
        } leftCancelButtonTitle:@"取消" rightDownButtonTitle:@"确定" inView:nil block:^(NSInteger tag, NSString *textFieldText, GGBaseAlertView *alertView) {
            if (tag == 1) {
                // block 返回值
                param.senderData.completion(@"321");
                
                [alertView dismissView];
            }
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    self.title = @"MGJRouter+GG";
}

#pragma mark ------------------------- Override -------------------------
- (NSArray<GGBaseFunctionsItem *> *)configFunctionsItems {
    NSArray *array = @[
        @"处理逻辑(跳转页面等)",
        @"获取object",
        @"自定义参数传值",
        @"处理返回值block",
    ];
    
    NSMutableArray *marr_data = @[].mutableCopy;
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        NSString *actionName = [NSString stringWithFormat:@"action_%ld", (long)i];
        
        GGBaseFunctionsItem *item = [GGBaseFunctionsItem itemWithTitle:obj selectorName:actionName];
        
        [marr_data addObject:item];
    }];
    
    return marr_data;
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 处理逻辑
- (void)action_0 {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:nil];
    
    [MGJRouter gg_openURL:GGModulesUrl_Router_OpenHandleEvent withParam:param completion:nil];
}

#pragma mark --- 获取object
- (void)action_1 {
    NSDictionary *result = [MGJRouter gg_objectForURL:GGModulesUrl_Router_GetObject withUserInfo:nil];
    
    NSString *subTitle = [NSString stringWithFormat:@"%@", [result jsonPrettyStringEncoded]];
    
    [GGBaseCXGAlertView alertViewWithTitle:@"返回值" subTitle:subTitle subTitleTextViewConfigBlock:^(QMUITextView *textView) {
        textView.textAlignment = NSTextAlignmentLeft;
    } leftCancelButtonTitle:@"确定" rightDownButtonTitle:nil inView:nil block:nil];
}

#pragma mark --- 自定义传参
- (void)action_2 {
    MGJRouterParam *param = [MGJRouterParam objectWithPreController:self theWayToShowController:MGJRouterParamShowNewControllerWay_Automatic data:@{
        @"value": @"123",
    }];
    
    [MGJRouter gg_openURL:GGModulesUrl_Router_CustomeParam withParam:param completion:nil];
}

#pragma mark --- 处理返回值block
- (void)action_3 {
    MGJRouterParam *param = [MGJRouterParam objectWithData:@{
        @"value": @"123",
    }];
    
    [MGJRouter gg_openURL:GGModulesUrl_Router_HandleReturnBlock withParam:param completion:^(id  _Nullable data) {
        NSString *subTitle = [NSString stringWithFormat:@"completion block 被调用\n返回值:%@", data];
        
        [GGBaseCXGAlertView alertViewWithTitle:@"completion block" subTitle:subTitle subTitleTextViewConfigBlock:^(QMUITextView *textView) {
            textView.textAlignment = NSTextAlignmentLeft;
        } leftCancelButtonTitle:@"确定" rightDownButtonTitle:nil inView:nil block:nil];
    }];
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 处理逻辑
+ (void)_jumpNewVCWithPreVC:(UIViewController *)preVc {
    GGMGJRouterViewController *vc = [GGMGJRouterViewController new];
    
    [preVc showControllerInSameWay:vc animated:YES block:nil];
}

#pragma mark --- 获取object
+ (NSDictionary *)_returnObjectWithAcceptValue:(NSString *)acceptValue returnValue:(id)returnValue {
    return @{
        @"传过来的参数": NSStringTransformEmpty(acceptValue),
        @"返回参数": returnValue,
    };
}

@end
