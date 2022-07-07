//
//  UIBaseTabBarViewController.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/5.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UIBaseTabBarViewController.h"
#import "UIBaseViewController.h"

@interface UIBaseTabBarViewController ()

@end

@implementation UIBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- Interface -------------------------
- (void)setUpChildViewControllersWithTitlesArray:(NSArray *)titlesArray normalImgArray:(NSArray *)normalImgArray selectImgArray:(NSArray *)selectImgArray controllersClass:(NSArray *)controllersClass {

    NSMutableArray *controllers = [NSMutableArray array];
    NSString *title = nil;
    NSString *normalImage = nil;
    NSString *selectImage = nil;
    NSString *vcName = nil;
    
    for (NSInteger i = 0; i < titlesArray.count; i++) {
        title = titlesArray[i];
        normalImage = normalImgArray[i];
        selectImage = selectImgArray[i];
        vcName = controllersClass[i];
        UINavigationController *nav = [self viewController:vcName title:title image:normalImage selectedImage:selectImage tag:i];
        [controllers addObject:nav];
    }
    
    self.viewControllers = controllers;
}

- (void)noNavControllerSetUpChildViewControllersWithTitlesArray:(NSArray *)titlesArray normalImgArray:(NSArray *)normalImgArray selectImgArray:(NSArray *)selectImgArray controllersClass:(NSArray *)controllersClass {
    NSMutableArray *controllers = [NSMutableArray array];
    NSString *title = nil;
    NSString *normalImage = nil;
    NSString *selectImage = nil;
    NSString *vcName = nil;
    for (NSInteger i = 0; i < titlesArray.count; i++) {
        title = titlesArray[i];
        normalImage = normalImgArray[i];
        selectImage = selectImgArray[i];
        vcName = controllersClass[i];
        UIViewController *nav = [self noNavControllerWithviewController:vcName title:title image:normalImage selectedImage:selectImage tag:i];
        [controllers addObject:nav];
    }
    
    self.viewControllers = controllers;
}

- (UINavigationController *)viewController:(NSString *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag
{
    UIBaseViewController *uikitViewController = [[NSClassFromString(vc) alloc] init];
    uikitViewController.hidesBottomBarWhenPushed = NO;
    
    Class navClass = [self getNavigationControllerClass];
    
    UINavigationController *uikitNavController = [[navClass alloc] initWithRootViewController:uikitViewController];
    
    uikitViewController.title = title;
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImageMake(image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:tag];
    tabBarItem.selectedImage = [UIImageMake(selectedImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    uikitViewController.tabBarItem = tabBarItem;
    
    return uikitNavController;
}

- (UIViewController *)noNavControllerWithviewController:(NSString *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag {
    UIBaseViewController *uikitViewController = [[NSClassFromString(vc) alloc] init];
    
    uikitViewController.title = title;
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImageMake(image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:tag];
    tabBarItem.selectedImage = [UIImageMake(selectedImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    uikitViewController.tabBarItem = tabBarItem;
    
    return uikitViewController;
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- DEBUG
/// 是否在 debug 模式下，当显示出页面时打印类名
- (BOOL)debugLogClassName {
    return YES;
}

#pragma mark --- UIBaseTabBarViewControllerProtocol
- (Class)getNavigationControllerClass {
    return [UIBaseNavigationController class];
}

@end
