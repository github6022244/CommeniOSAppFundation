//
//  GGBaseAlertView.h
//  ChangXiangGrain
//
//  Created by GG on 2022/3/9.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGBaseAlertView : UIView

@property (nonatomic, strong, readonly) QMUIModalPresentationViewController *alertVC;

- (void)showView;

- (void)showViewWithCompletion:(void (^ _Nullable)(BOOL))completion;

- (void)showInView:(UIView * _Nullable)view completion:(void (^ _Nullable)(BOOL))completion;

- (void)dismissView;

@end

NS_ASSUME_NONNULL_END
