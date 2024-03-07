//
//  UIBaseNavigationController.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/4.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UIBaseNavigationController.h"

@interface UIBaseNavigationController ()

@end

@implementation UIBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.count > 0 ) {
        UIViewController *popController = self.viewControllers.lastObject;
//        if ([popController isKindOfClass:[CustomCViewController class]]) {
            popController.hidesBottomBarWhenPushed = NO;
//        }
    }
    return [super popToRootViewControllerAnimated:animated];

}

@end
