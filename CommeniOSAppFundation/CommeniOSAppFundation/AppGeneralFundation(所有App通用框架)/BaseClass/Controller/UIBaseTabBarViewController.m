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

- (void)uibase_setUpSubViews {
    
}

- (void)uibase_setUpNavigationItems {
    
}

- (void)uibase_config {
    
}

- (void)uibase_bindViewModel {
    
}

- (void)uibase_setUpNotification {
    
}

#pragma mark ------------------------- Interface -------------------------
- (void)setUpChildViewControllersWithTitlesArray:(NSArray *)titlesArray normalTitleColors:(NSArray< UIColor *> *)normalTitleColors selectTitleColors:(NSArray< UIColor *> *)selectTitleColors normalImgArray:(NSArray *)normalImgArray selectImgArray:(NSArray *)selectImgArray controllersClass:(NSArray *)controllersClass {

    NSMutableArray *controllers = [NSMutableArray array];
    NSString *title = nil;
    NSString *normalImage = nil;
    NSString *selectImage = nil;
    NSString *vcName = nil;
    UIColor *normalTitleColor = nil;
    UIColor *selectTitleColor = nil;
    
    for (NSInteger i = 0; i < titlesArray.count; i++) {
        title = titlesArray[i];
        normalImage = normalImgArray[i];
        selectImage = selectImgArray[i];
        vcName = controllersClass[i];
        normalTitleColor = [normalTitleColors gg_safeObjectAtIndex:i];
        selectTitleColor = [selectTitleColors gg_safeObjectAtIndex:i];
        
        UINavigationController *nav = [self viewController:vcName title:title normalTitleColor:normalTitleColor selectTitleColor:selectTitleColor image:normalImage selectedImage:selectImage tag:i];
        [controllers addObject:nav];
    }
    
    self.viewControllers = controllers;
}

- (void)noNavControllerSetUpChildViewControllersWithTitlesArray:(NSArray *)titlesArray normalTitleColors:(NSArray< UIColor *> *)normalTitleColors selectTitleColors:(NSArray< UIColor *> *)selectTitleColors  normalImgArray:(NSArray *)normalImgArray selectImgArray:(NSArray *)selectImgArray controllersClass:(NSArray *)controllersClass {
    NSMutableArray *controllers = [NSMutableArray array];
    NSString *title = nil;
    NSString *normalImage = nil;
    NSString *selectImage = nil;
    NSString *vcName = nil;
    UIColor *normalTitleColor = nil;
    UIColor *selectTitleColor = nil;
    
    for (NSInteger i = 0; i < titlesArray.count; i++) {
        title = titlesArray[i];
        normalImage = normalImgArray[i];
        selectImage = selectImgArray[i];
        vcName = controllersClass[i];
        normalTitleColor = [normalTitleColors gg_safeObjectAtIndex:i];
        selectTitleColor = [selectTitleColors gg_safeObjectAtIndex:i];
        
        UIViewController *nav = [self noNavControllerWithviewController:vcName title:title normalTitleColor:nil selectTitleColor:nil image:normalImage selectedImage:selectImage tag:i];
        [controllers addObject:nav];
    }
    
    self.viewControllers = controllers;
}

- (UINavigationController *)viewController:(NSString *)vc title:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag
{
    UIBaseViewController *uikitViewController = [[NSClassFromString(vc) alloc] init];
    uikitViewController.hidesBottomBarWhenPushed = NO;
    
    Class navClass = [self getNavigationControllerClass];
    
    UINavigationController *uikitNavController = [[navClass alloc] initWithRootViewController:uikitViewController];
    
    uikitViewController.title = title;
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImageMake(image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:tag];
    tabBarItem.selectedImage = [UIImageMake(selectedImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    uikitViewController.tabBarItem = tabBarItem;
    
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{
            NSForegroundColorAttributeName: normalTitleColor ? : UIColorMakeWithHex(@"#020822"),
    //        NSFontAttributeName: UIFontMake(10 * kScaleFit),
        };
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{
            NSForegroundColorAttributeName: selectTitleColor ? : UIColorMakeWithHex(@"#020822"),
    //        NSFontAttributeName: UIFontMake(10 * kScaleFit),
        };
        
        uikitNavController.tabBarItem.standardAppearance = appearance;
    } else {
        [uikitNavController.tabBarItem setTitleTextAttributes:@{
            NSForegroundColorAttributeName: normalTitleColor ? : UIColorMakeWithHex(@"#020822"),
    //        NSFontAttributeName: UIFontMake(10 * kScaleFit),
        } forState:UIControlStateNormal];
        
        [uikitViewController.tabBarItem setTitleTextAttributes:@{
            NSForegroundColorAttributeName: selectTitleColor ? : UIColorMakeWithHex(@"#020822"),
    //        NSFontAttributeName: UIFontMake(10 * kScaleFit),
        } forState:UIControlStateSelected];
    }
    
    return uikitNavController;
}

- (UIViewController *)noNavControllerWithviewController:(NSString *)vc title:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag {
    UIBaseViewController *uikitViewController = [[NSClassFromString(vc) alloc] init];
    
    uikitViewController.title = title;
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImageMake(image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:tag];
    tabBarItem.selectedImage = [UIImageMake(selectedImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    uikitViewController.tabBarItem = tabBarItem;
    
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{
            NSForegroundColorAttributeName: normalTitleColor ? : UIColorMakeWithHex(@"#020822"),
    //        NSFontAttributeName: UIFontMake(10 * kScaleFit),
        };
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{
            NSForegroundColorAttributeName: selectTitleColor ? : UIColorMakeWithHex(@"#020822"),
    //        NSFontAttributeName: UIFontMake(10 * kScaleFit),
        };
        
        uikitViewController.tabBarItem.standardAppearance = appearance;
    } else {
        [uikitViewController.tabBarItem setTitleTextAttributes:@{
            NSForegroundColorAttributeName: normalTitleColor ? : UIColorMakeWithHex(@"#020822"),
    //        NSFontAttributeName: UIFontMake(10 * kScaleFit),
        } forState:UIControlStateNormal];
        
        [uikitViewController.tabBarItem setTitleTextAttributes:@{
            NSForegroundColorAttributeName: selectTitleColor ? : UIColorMakeWithHex(@"#020822"),
    //        NSFontAttributeName: UIFontMake(10 * kScaleFit),
        } forState:UIControlStateSelected];
    }
    
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
