//
//  UIViewController+GG.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/5.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UIViewController+GG.h"
#import <QMUIKit.h>

@implementation UIViewController (GG)

- (void)fullScreenPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (!viewControllerToPresent) {
        QMUILog(nil, @"拦截跳转: 控制器 == nil");
        return;
    }
    
    if (@available(iOS 13.0, *)) {
        if (UIModalPresentationPageSheet == viewControllerToPresent.modalPresentationStyle) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:viewControllerToPresent animated:flag completion:completion];
    });
}

- (void)showControllerInSameWay:(UIViewController *)controller {
    [self showControllerInSameWay:controller animated:YES block:nil];
}

- (void)showControllerInSameWay:(UIViewController *)controller animated:(BOOL)animated block:(void (^)(void))block {
    if (!controller) {
        QMUILog(nil, @"拦截跳转: 控制器 == nil");
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isPresented] && !self.navigationController) {
            [self fullScreenPresentViewController:controller animated:animated completion:block];
        } else {
            if (self.navigationController) {
                [self.navigationController pushViewController:controller animated:animated];
            } else {
                [self fullScreenPresentViewController:controller animated:animated completion:block];
            }
        }
    });
}

- (void)exitController {
    [self exitControllerWithCompletion:nil];
}

- (void)exitControllerWithCompletion:(void(^)(void))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isPresented]) {
            [self dismissViewControllerAnimated:YES completion:^{
                if (completion) {
                    completion();
                }
            }];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
            if (completion) {
                completion();
            }
        }
    });
}

- (void)exitControllerClassName:(NSString *)controllerClassName completion:(void(^)(void))completion {
    UIViewController *targetVC = [self getTargetControllerFromStackWithClassName:controllerClassName];
    
    if (targetVC) {
        if ([self isPresented]) {
            [targetVC dismissViewControllerAnimated:YES completion:completion];
        } else {
            [self.navigationController popToViewController:targetVC animated:YES];
        }
    }
}

- (UIViewController *)lastViewController {
    if ([self isPresented]) {
        return self.presentingViewController;
    } else {
        return [self previousViewController];
    }
}

- (UIViewController *)rootViewControllerInStack {
    if ([self isPresented]) {
        UIViewController *fatherVC = self.presentingViewController;
        while (fatherVC) {
            if (!fatherVC.presentingViewController) {
                return fatherVC;
            } else {
                fatherVC = fatherVC.presentingViewController;
            }
        }
    } else {
        return [self rootViewControllerInNavigation];
    }
    
    return nil;
}

/// 从栈中根据类名查找控制器
- (UIViewController *)getTargetControllerFromStackWithClassName:(NSString *)className {
    if ([self isPresented]) {
        UIViewController *fatherVC = self.presentingViewController;
        while (fatherVC) {
            if ([NSStringFromClass([fatherVC class]) isEqualToString:className]) {
                [fatherVC dismissViewControllerAnimated:YES completion:nil];
                return fatherVC;
            } else {
                fatherVC = fatherVC.presentingViewController;
            }
        }
    } else {
        NSInteger index = self.navigationController.viewControllers.count - 1;
        for (; index >= 0; index--) {
            UIViewController *targetVC = [self.navigationController.viewControllers objectAtIndex:index];
            if ([NSStringFromClass([targetVC class]) isEqualToString:className]) {
                return targetVC;
            }
        }
    }
    
    return nil;
}

- (BOOL)isPresented {
    UIViewController *viewController = self;
    if (self.navigationController) {
        if ([self rootViewControllerInNavigation] != self) {
            return NO;
        }
        viewController = self.navigationController;
    }
    BOOL result = viewController.presentingViewController.presentedViewController == viewController;
    return result;
}

- (nullable UIViewController *)rootViewControllerInNavigation {
    return self.navigationController.viewControllers.firstObject;
}

- (UIViewController *)previousViewController {
    if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 1 && self.navigationController.topViewController == self) {
        NSUInteger count = self.navigationController.viewControllers.count;
        return (UIViewController *)[self.navigationController.viewControllers objectAtIndex:count - 2];
    }
    return nil;
}

- (BOOL)containTabBar {
    if (!self.tabBarController.tabBar || self.tabBarController.tabBar.hidden) {
        return NO;
    }
    if (self.hidesBottomBarWhenPushed && self.navigationController.qmui_rootViewController != self) {
        return NO;
    }
    
    return YES;
}

@end
