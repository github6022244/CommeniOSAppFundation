//
//  GGMGJRouterAlertViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/28.
//

#import "GGMGJRouterAlertViewController.h"
#import "MGJRouter+GG.h"
#import "GGAppModulesDefine.h"

@interface GGMGJRouterAlertViewController ()

@property (nonatomic, copy) NSString *alertString;

@end

@implementation GGMGJRouterAlertViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_Router_CustomeParam toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        GGMGJRouterAlertViewController *vc = [GGMGJRouterAlertViewController new];
        
        NSString *alertStr = param.senderData.data[@"value"];
        
        vc.alertString = alertStr;
        
        UIViewController *preController = param.senderData.preController;
        
        [preController showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpSubViews {
    [super uibase_setUpSubViews];
    
    [self showEmptyViewWithText:@"传过来的参数" detailText:self.alertString buttonTitle:@"返回" buttonAction:@selector(actions_clickSureButton)];
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 点击确定
- (void)actions_clickSureButton {
    [self exitController];
}

@end
