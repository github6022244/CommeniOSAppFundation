//
//  UIWindow+GG.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (GG)

#pragma mark --- 获取根window
+ (UIWindow *)getKeyWindow;

@end

NS_ASSUME_NONNULL_END
