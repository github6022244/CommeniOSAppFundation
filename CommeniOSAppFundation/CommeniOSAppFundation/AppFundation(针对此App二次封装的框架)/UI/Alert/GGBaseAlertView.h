//
//  GGBaseAlertView.h
//  CXGrainStudentApp
//
//  Created by GG on 2022/3/9.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GGBaseAlertViewContentViewLayoutType) {
    GGBaseAlertViewContentViewLayoutType_Center,// 中心(默认)
    GGBaseAlertViewContentViewLayoutType_Bottom,// 底部
};

@protocol GGBaseAlertViewProtocol <NSObject>
@optional
// contentView布局方式
- (GGBaseAlertViewContentViewLayoutType)contentViewLayoutType;

/// 在即将展示出来时配置contentView
/// 用于子类重写
- (void)configContentViewBeforeShowing;

@end





@interface GGBaseAlertView : UIView<QMUIModalPresentationComponentProtocol, GGBaseAlertViewProtocol>

@property (nonatomic, strong, readonly) QMUIModalPresentationViewController *alertVC;

@property (nonatomic, assign, readonly, getter=isShowing) BOOL showing;

/// 在即将展示出来时配置contentView
/// 用于子类重写
- (void)configContentViewBeforeShowing;

- (void)showView;

- (void)showViewWithCompletion:(void (^)(BOOL))completion;

- (void)showInView:(UIView *)view completion:(void (^)(BOOL))completion;

- (void)dismissView;

- (void)dismissViewWithAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
