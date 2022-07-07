//
//  GGChangeNavBackImageViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/6.
//

#import "GGChangeNavBackImageViewController.h"
#import "UILabel+GG.h"
#import "QMUIInteractiveDebugger.h"
#import "GGAppModulesDefine.h"

@interface GGChangeNavBackImageViewController ()

@end

@implementation GGChangeNavBackImageViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_NavChangeColor_OpenNavChangeColorController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        UIViewController *preVC = param.senderData.preController;
        
        GGChangeNavBackImageViewController *vc = [GGChangeNavBackImageViewController new];
        
        [preVC showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpSubViews {
    [super uibase_setUpSubViews];
    
    [self showEmptyViewWithText:@"VC切换时导航栏如果背景色不同，\n转换时会出现两个导航栏" detailText:@"点击蓝色文字，然后自己手势返回看下效果" buttonTitle:@"跳转导航栏颜色不同的控制器" buttonAction:@selector(actions_jumpNewVC)];
}

- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    switch (self.navBarType) {
        case GGChangeNavBackImageViewControllerNavType_Light:
            self.title = @"亮色";
            break;
        case GGChangeNavBackImageViewControllerNavType_Dark:
            self.title = @"暗色";
            break;
        case GGChangeNavBackImageViewControllerNavType_Hidden:
//            self.title = @"隐藏";
            break;
        default:
            break;
    }
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:@"调试" target:self action:@selector(actions_navDebug)];
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- 导航栏
- (UIImage *)qmui_navigationBarBackgroundImage {
    UIImage *navBackImage = nil;
    
    switch (self.navBarType) {
        case GGChangeNavBackImageViewControllerNavType_Light:
            navBackImage = [UIImage qmui_imageWithColor:UIColorTestBlue];
            break;
        case GGChangeNavBackImageViewControllerNavType_Dark:
            navBackImage = [UIImage qmui_imageWithColor:UIColorGrayLighten];
            break;
        case GGChangeNavBackImageViewControllerNavType_Hidden:
            break;
        default:
            break;
    }
    
    return navBackImage;
}

- (BOOL)preferredNavigationBarHidden {
    return self.navBarType == GGChangeNavBackImageViewControllerNavType_Hidden;
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 跳转新控制器
- (void)actions_jumpNewVC {
    GGChangeNavBackImageViewController *vc = [GGChangeNavBackImageViewController new];
    
    if (self.navBarType == 2) {
        vc.navBarType = 0;
    } else {
        vc.navBarType = self.navBarType + 1;
    }
    
    [self showControllerInSameWay:vc animated:YES block:nil];
}

#pragma mark --- 导航栏调试
- (void)actions_navDebug {
    [QMUITips showInfo:@"慎重使用这个功能，有问题"];
    [QMUIInteractiveDebugger presentNavigationBarDebuggerInViewController:self];
}

@end
