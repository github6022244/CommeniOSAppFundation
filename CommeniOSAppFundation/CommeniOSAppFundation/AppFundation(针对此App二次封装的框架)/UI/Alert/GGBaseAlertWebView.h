//
//  GGBaseAlertWebView.h
//  ChangXiangGrain
//
//  Created by GG on 2023/6/14.
//  Copyright © 2023 ChangXiangCloud. All rights reserved.
//

#import "GGBaseAlertView.h"

@class GGBaseAlertWebView;

NS_ASSUME_NONNULL_BEGIN

/// 点击底部按钮回调 block
typedef void(^GGBaseAlertWebViewBottomButtonClickBlock)(NSInteger tag, GGBaseAlertWebView *alertView);

@interface GGBaseAlertWebView : GGBaseAlertView

@property (nonatomic, strong, readonly) UIViewController *webController;

@property (nonatomic, strong, readonly) NSMutableArray<UIButton *> *bottomButtonsArray;

+ (instancetype)alertViewWithTitle:(NSString *)title
                              link:(NSString *)link
                   needCloseButton:(BOOL)needCloseButton
                        leftCancelButtonTitle:(NSString *)leftCancelButtonTitle
                          rightDownButtonTitle:(NSString *)rightDownButtonTitle
                                        inView:(UIView *)view
                             block:(GGBaseAlertWebViewBottomButtonClickBlock)block;

@end

NS_ASSUME_NONNULL_END
