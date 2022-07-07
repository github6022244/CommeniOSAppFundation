//
//  GGTabBarViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/1.
//

#import "GGTabBarViewController.h"
#import <QMUIKit.h>
#import "GGViewController.h"

@interface GGTabBarViewController ()

@end

@implementation GGTabBarViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark ------------------------- UI -------------------------
- (void)setUpUI {
    [self setUpChildViewControllersWithTitlesArray:@[
        @"首页",
    ] normalImgArray:@[
        @"tabbar_normal_1",
    ] selectImgArray:@[
        @"tabbar_light_1",
    ] controllersClass:@[
        @"GGViewController",
    ]];
}

@end
