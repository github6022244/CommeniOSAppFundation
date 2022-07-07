//
//  GGBaseAlertView.m
//  ChangXiangGrain
//
//  Created by GG on 2022/3/9.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "GGBaseAlertView.h"
#import "GGCommenDefine.h"
#import "UIWindow+GG.h"

@interface GGBaseAlertView ()

@property (nonatomic, strong) QMUIModalPresentationViewController *alertVC;

@property (nonatomic, assign) CGRect contentViewOriginalFrame;

@end

@implementation GGBaseAlertView

#pragma mark ------------------------- Cycle -------------------------
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

#pragma mark ------------------------- Cofnig -------------------------
- (void)config {

}

#pragma mark ------------------------- UI -------------------------
- (void)setupUI {
    
}

#pragma mark ------------------------- Interface -------------------------
#pragma mark-- show and dismiss view
- (void)showView {
    [self showViewWithCompletion:nil];
}

- (void)showViewWithCompletion:(void (^)(BOOL))completion {
    UIWindow *keyWindow = [UIWindow getKeyWindow];
    
    [self showInView:keyWindow completion:completion];
}

- (void)showInView:(UIView *)view completion:(void (^)(BOOL))completion {
    view = view ? : [UIWindow getKeyWindow];
    
    [self pv_configSetContentView];
    
    /// 不能使用 showWithAnimated:(BOOL) completion:^(BOOL finished) {}
    /// 因为显示弹框后如果有 toast 可能会不显示，👆🏻这个方法会新建 window 然后将弹框显示到新 window ，而toast会显示到原 window 上
    [self.alertVC showInView:view animated:YES completion:completion];
    
    @ggweakify(self)
    self.alertVC.didHideByDimmingViewTappedBlock = ^{
        @ggstrongify(self)
        /// 处理强 self 与 _alertVC 的强引用循环
        self.alertVC = nil;
    };
}

- (void)dismissView {
//    UIWindow *keyWindow = [UIWindow getKeyWindow];
//
//    @weakify(self)
//    [self.alertVC hideInView:keyWindow animated:YES completion:^(BOOL finished) {
//        @strongify(self)
//        if (finished) {
//            /// 处理强 self 与 _alertVC 的强引用循环
//            self.alertVC = nil;
//        }
//    }];
    
    @ggweakify(self)
    [self.alertVC hideInView:self.alertVC.view.superview animated:YES completion:^(BOOL finished) {
        @ggstrongify(self)
        if (finished) {
            /// 处理强 self 与 _alertVC 的强引用循环
            self.alertVC = nil;
        }
    }];
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 配置alertVC的contentView
- (void)pv_configSetContentView {
    /// 这一句会导致强引用循环
    /// self -> _alertVC  && _alertVC -> self
    /// 解决方式：在 _alertVC hide 之后将 _alertVC = nil
    /// ① 👁 👁看 - (void)dismissView 中的 [self.alertVC hideInView:...completion:] 里的代码
    /// ② 看在 - (void)showView 中的 self.alertVC.didHideByDimmingViewTappedBlock 里的代码
    @ggweakify(self)
    self.alertVC.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        // alertVC 内部会在键盘弹起时更改 contentview 的 frame，所以设置一个空的 layoutBlock 避免 contentView 改变大小
        @ggstrongify(self)
        CGFloat x = (SCREEN_WIDTH - contentViewDefaultFrame.size.width) / 2.0;
        CGFloat y = CGRectGetMinY(contentViewDefaultFrame);
        if (!keyboardHeight) {
            // 没有键盘
            y = (SCREEN_HEIGHT - self.contentViewOriginalFrame.size.height) / 2.0;
        }
        
        self.alertVC.contentView.qmui_frameApplyTransform = CGRectSetXY(self.alertVC.contentView.frame, x, y);
    };
    self.contentViewOriginalFrame = self.frame;
    self.alertVC.contentView = self;
    
    [_alertVC updateLayout];
}

#pragma mark ------------------------- set / get -------------------------
- (QMUIModalPresentationViewController *)alertVC {
    if (!_alertVC) {
        _alertVC = [[QMUIModalPresentationViewController alloc] init];
        _alertVC.modal = YES;
        _alertVC.animationStyle = QMUIModalPresentationAnimationStylePopup;
    }
    return _alertVC;
}

@end
