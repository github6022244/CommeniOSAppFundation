//
//  GGBaseTabBarViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/29.
//

#import "GGBaseTabBarViewController.h"
#import "GGBaseNavigationController.h"

@interface GGBaseTabBarViewController ()

@end

@implementation GGBaseTabBarViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- UIBaseTabBarViewControllerProtocol
- (Class)getNavigationControllerClass {
    return [GGBaseNavigationController class];
}

@end
