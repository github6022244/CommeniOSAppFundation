//
//  UIViewController+GG.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/5.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GG)

@property (nonatomic, strong, readonly) UIViewController *lastViewController;/// 上一个页面

@property (nonatomic, strong, readonly) UIViewController *rootViewControllerInStack;/// 栈中的第一个vc

#pragma mark --- 全屏 present 一个控制器
- (void)fullScreenPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(nullable void (^)(void))completion;

#pragma mark --- 以相同方式(present / push)展示出一个控制器
- (void)showControllerInSameWay:(UIViewController *)controller animated:(BOOL)animated block:(nullable void (^)(void))block;

#pragma mark --- 返回相关(适配 dismiss / pop)
- (void)exitController;
- (void)exitControllerWithCompletion:(nullable void(^)(void))completion;
/// 退出到一个类名为 xxx 的控制器
/// @param controllerClassName 返回目标控制器类名
/// @param completion block
- (void)exitControllerClassName:(NSString *)controllerClassName completion:(nullable void(^)(void))completion;

#pragma mark --- 从栈中根据类名查找控制器
- (UIViewController *)getTargetControllerFromStackWithClassName:(NSString *)className;

#pragma mark --- 是否是 present 出来的
- (BOOL)isPresented;

@end

NS_ASSUME_NONNULL_END
