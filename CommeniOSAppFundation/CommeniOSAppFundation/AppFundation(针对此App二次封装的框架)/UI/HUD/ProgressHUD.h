//
//  ProgressHUD.h
//  ChangXiangStudent
//
//  Created by User on 2018/3/15.
//  Copyright © 2018年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGTips.h"

@interface ProgressHUD : NSObject

+ (void)showSuccess;

+ (void)showSuccess:(NSString *)success;

+ (void)showMessage:(NSString *)message;

+ (void)showError:(NSString *)error;

+ (QMUITips *)showLoading;

+ (QMUITips *)showLoading:(NSString *)message;

+ (QMUITips *)showLoading:(NSString *)message toView:(UIView *)view;

+ (void)showWithProgress:(CGFloat)progress message:(NSString *)message;

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

+ (void)dismiss;

+ (void)dismissTips:(QMUITips *)tips;

@end
