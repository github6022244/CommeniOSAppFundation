//
//  UIBaseTabBarViewController.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/5.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <QMUITabBarViewController.h>
#import "UIBaseNavigationController.h"
#import "UIViewController+GGDEBUG.h"


@protocol UIBaseTabBarViewControllerProtocol <NSObject>

@optional
/// 用什么导航栏，返回类
/// @warning 必须是 UINavigationController 的子类
- (Class _Nonnull)getNavigationControllerClass;

@end


NS_ASSUME_NONNULL_BEGIN

@interface UIBaseTabBarViewController : QMUITabBarViewController<GGUIBaseViewControllerDebugProtocol, UIBaseTabBarViewControllerProtocol>

- (void)setUpChildViewControllersWithTitlesArray:(NSArray *)titlesArray normalTitleColors:(NSArray< UIColor *> *)normalTitleColors selectTitleColors:(NSArray< UIColor *> *)selectTitleColors normalImgArray:(NSArray *)normalImgArray selectImgArray:(NSArray *)selectImgArray controllersClass:(NSArray *)controllersClass;

- (void)noNavControllerSetUpChildViewControllersWithTitlesArray:(NSArray *)titlesArray normalTitleColors:(NSArray< UIColor *> *)normalTitleColors selectTitleColors:(NSArray< UIColor *> *)selectTitleColors  normalImgArray:(NSArray *)normalImgArray selectImgArray:(NSArray *)selectImgArray controllersClass:(NSArray *)controllersClass;

- (UINavigationController *)viewController:(NSString *)vc title:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag;

- (UIViewController *)noNavControllerWithviewController:(NSString *)vc title:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
