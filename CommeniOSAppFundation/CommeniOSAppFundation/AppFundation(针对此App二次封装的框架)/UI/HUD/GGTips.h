//
//  GGTips.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/12/22.
//

#import <QMUIKit/QMUIKit.h>
//#import <QMUITips.h>
#import <QMUIToastView.h>
#import <QMUIToastContentView.h>
#import <QMUIToastBackgroundView.h>

// 自动计算秒数的标志符，在 delay 里面赋值 GGTipsAutomaticallyHideToastSeconds 即可通过自动计算 tips 消失的秒数
extern const NSInteger GGTipsAutomaticallyHideToastSeconds;

/// 默认的 parentView
#define GGDefaultTipsParentView (UIApplication.sharedApplication.delegate.window)

NS_ASSUME_NONNULL_BEGIN

@interface GGTips : QMUIToastView

- (void)showLoading;
- (void)showLoading:(nullable NSString *)text;
- (void)showLoadingHideAfterDelay:(NSTimeInterval)delay;
- (void)showLoading:(nullable NSString *)text hideAfterDelay:(NSTimeInterval)delay;
- (void)showLoading:(nullable NSString *)text detailText:(nullable NSString *)detailText;
- (void)showLoading:(nullable NSString *)text detailText:(nullable NSString *)detailText hideAfterDelay:(NSTimeInterval)delay;

- (void)showWithText:(nullable NSString *)text;
- (void)showWithText:(nullable NSString *)text hideAfterDelay:(NSTimeInterval)delay;
- (void)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText;
- (void)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText hideAfterDelay:(NSTimeInterval)delay;

- (void)showSucceed:(nullable NSString *)text;
- (void)showSucceed:(nullable NSString *)text hideAfterDelay:(NSTimeInterval)delay;
- (void)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText;
- (void)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText hideAfterDelay:(NSTimeInterval)delay;

- (void)showError:(nullable NSString *)text;
- (void)showError:(nullable NSString *)text hideAfterDelay:(NSTimeInterval)delay;
- (void)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText;
- (void)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText hideAfterDelay:(NSTimeInterval)delay;

- (void)showInfo:(nullable NSString *)text;
- (void)showInfo:(nullable NSString *)text hideAfterDelay:(NSTimeInterval)delay;
- (void)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText;
- (void)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText hideAfterDelay:(NSTimeInterval)delay;

/// 类方法：主要用在局部一次性使用的场景，hide之后会自动removeFromSuperView

+ (GGTips *)createTipsToView:(UIView *)view;

+ (GGTips *)showLoadingInView:(UIView *)view;
+ (GGTips *)showLoading:(nullable NSString *)text inView:(UIView *)view;
+ (GGTips *)showLoadingInView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (GGTips *)showLoading:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (GGTips *)showLoading:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (GGTips *)showLoading:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (GGTips *)showWithText:(nullable NSString *)text;
+ (GGTips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (GGTips *)showWithText:(nullable NSString *)text inView:(UIView *)view;
+ (GGTips *)showWithText:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (GGTips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (GGTips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (GGTips *)showSucceed:(nullable NSString *)text;
+ (GGTips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (GGTips *)showSucceed:(nullable NSString *)text inView:(UIView *)view;
+ (GGTips *)showSucceed:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (GGTips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (GGTips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (GGTips *)showError:(nullable NSString *)text;
+ (GGTips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (GGTips *)showError:(nullable NSString *)text inView:(UIView *)view;
+ (GGTips *)showError:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (GGTips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (GGTips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (GGTips *)showInfo:(nullable NSString *)text;
+ (GGTips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (GGTips *)showInfo:(nullable NSString *)text inView:(UIView *)view;
+ (GGTips *)showInfo:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (GGTips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (GGTips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

/// 隐藏 tips
+ (void)hideAllTipsInView:(UIView *)view;
+ (void)hideAllTips;

/// 自动隐藏 toast 可以使用这个方法自动计算秒数
+ (NSTimeInterval)smartDelaySecondsForTipsText:(NSString *)text;

@end










NS_ASSUME_NONNULL_END
