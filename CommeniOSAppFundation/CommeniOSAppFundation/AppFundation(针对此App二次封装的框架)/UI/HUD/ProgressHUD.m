//
//  ProgressHUD.m
//  ChangXiangStudent
//
//  Created by User on 2018/3/15.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "ProgressHUD.h"
//#import <SVProgressHUD.h>

@implementation ProgressHUD

+ (void)initialize
{
//    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
////    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [SVProgressHUD setMaximumDismissTimeInterval:10];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

+ (void)showError:(NSString *)error
{
    dispatch_async_on_main_queue(^{
        [GGTips showError:error inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
    });
    
    return;
    // [SVProgressHUD showErrorWithStatus:error];
}

+ (void)showSuccess
{
    dispatch_async_on_main_queue(^{
        [self showSuccess:nil];
    });
}

+ (void)showSuccess:(NSString *)success
{
    dispatch_async_on_main_queue(^{
        [GGTips showSucceed:success inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
    });

    return;
    // [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    // [SVProgressHUD showSuccessWithStatus:success];
}

+ (QMUITips *)showLoading
{
    __block QMUITips *tips = nil;
    dispatch_async_on_main_queue(^{
        tips = [self showLoading:nil];
    });
    
    return tips;
}

+ (QMUITips *)showLoading:(NSString *)message
{
    return [self showLoading:message toView:DefaultTipsParentView];
    
    // [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    // [SVProgressHUD showWithStatus:message];
}

+ (QMUITips *)showLoading:(NSString *)message toView:(UIView *)view
{
    __block QMUITips *tips = nil;
    
    dispatch_async_on_main_queue(^{
        tips = [GGTips showLoading:message inView:view ? : DefaultTipsParentView];
    });
    
    return tips;
    
    // [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    // [SVProgressHUD showWithStatus:message];
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    return [GGTips hideAllToastInView:view animated:animated];
}

+ (void)showMessage:(NSString *)message
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [GGTips showInfo:message detailText:nil];
    });
    return;
    // [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    // [SVProgressHUD showInfoWithStatus:message];
}

+ (void)showWithProgress:(CGFloat)progress message:(NSString *)message
{
    [ProgressHUD showLoading:message];
    // [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//     [SVProgressHUD showProgress:progress status:message];
}

+ (void)dismiss
{
    dispatch_async_on_main_queue(^{
        [GGTips hideAllTips];
    });
    
    return;
    // [SVProgressHUD dismiss];
}

+ (void)dismissTips:(QMUITips *)tips {
    dispatch_async_on_main_queue(^{
        tips.removeFromSuperViewWhenHide = YES;
        [tips hideAnimated:YES];
    });
}

@end
