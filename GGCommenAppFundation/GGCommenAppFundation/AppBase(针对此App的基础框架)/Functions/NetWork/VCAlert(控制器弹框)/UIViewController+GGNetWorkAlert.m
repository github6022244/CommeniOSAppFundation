//
//  UIViewController+GGNetWorkAlert.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
//

#import "UIViewController+GGNetWorkAlert.h"
#import "AppDefine.h"
#import "NSDictionary+GG.h"
#import <QMUIKit.h>

@implementation UIViewController (GGNetWorkAlert)

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /// 不使用 viewDidLoad 的原因是: 如果想要进入页面就做一次无网络显示提示图
        /// 而在此时页面的布局通常在 viewDidLoad 里执行，是在展示提示图之后，所以会覆盖掉网络提示图
//        ExchangeImplementations([self class], @selector(viewDidLoad), @selector(ggNetWorkAlert_viewDidLoad));
        ExchangeImplementations([self class], @selector(viewDidAppear:), @selector(ggNetWorkAlert_viewDidAppear:));
    });
}

- (void)ggNetWorkAlert_viewDidAppear:(BOOL)animated {
    [self ggNetWorkAlert_viewDidAppear:animated];
    
    if ([self respondsToSelector:@selector(autoShowNetStatusChangeAlertView)]) {
        // 自动显示、隐藏无网络视图
        BOOL autoShow = [self autoShowNetStatusChangeAlertView];
        
        if (autoShow) {
            /// 为了防止在进入此控制器时就是无网络状态，而不会响应网络监听回调
            /// 手动走一次回调
            NSNotification *notify = [[NSNotification alloc] initWithName:kNotify_AppNetStatusChange object:nil userInfo:@{
                @"status": @([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus),
            }];
            [self kNotify_lostNetWork:notify];
        }
    }
    
    // 添加网络状态监听
    [self ggNetWorkAlert_setUpNotification];
}

#pragma mark ------------------------- 初始化 -------------------------
- (void)ggNetWorkAlert_setUpNotification {
    // 网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kNotify_lostNetWork:) name:kNotify_AppNetStatusChange object:nil];
}

#pragma mark ------------------------- Notify -------------------------
#pragma mark --- 网络环境改变
// 内部使用
- (void)kNotify_lostNetWork:(NSNotification *)notify {
    // 回调外部接口
    [self notify_lostNetWork:notify];// 通知
    
    NSNumber *num_status = [NSDictionary gg_checkClass:notify.userInfo objectForKey:@"status"];
    
    AFNetworkReachabilityStatus status = num_status.integerValue;
    
    [self gg_networkStatusChange:status];// 状态
    
    // 处理内部逻辑
    if ([self respondsToSelector:@selector(autoShowNetStatusChangeAlertView)]) {
        BOOL autoShow = [self autoShowNetStatusChangeAlertView];
        
        if (!autoShow) {
            return;
        }
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [self showLostNetAlertView];
        } else {
            [self hideLostNetAlertView];
        }
    }
}

// 暴露给外部使用
- (void)notify_lostNetWork:(NSNotification *)notify {
    
}

- (void)gg_networkStatusChange:(AFNetworkReachabilityStatus)status {
    
}

#pragma mark ------------------------- Interface -------------------------
#pragma mark --- 无网络视图
- (void)showLostNetAlertView {
    if ([self respondsToSelector:@selector(configLostNetAlertView:)]) {
        [self configLostNetAlertView:self.lostNetAlertView];
    }
    
    if (![self isLostNetAlertViewShowing]) {
        // loading
        BOOL showLoading = !self.lostNetAlertView.loadingView.isHidden;
        
        // image
        UIImage *image = self.lostNetAlertView.imageView.image ? : UIImageMake(@"placeholder_lostnet");
        
        // text
        NSString *text = self.lostNetAlertView.textLabel.text ? : @"网络不可用，请检查网络设置";
        
        // detailText
        NSString *detailText = self.lostNetAlertView.detailTextLabel.text ? : @"";
        
        // buttonTitle
        NSString *buttonTitle = self.lostNetAlertView.actionButton.currentTitle ? : @"重新加载";
        
        // 按钮 SEL
        // 获取内部的按钮事件 _action_clickLostNetButton:
        NSString *insideSelStr = @"_action_clickLostNetButton:";
        SEL insideSelector = NSSelectorFromString(insideSelStr);
        
        // 判断是否在外部调用 - (void)configLostNetAlertView: 时指定了按钮 SEL
        NSArray *actionsArray = [self.lostNetAlertView.actionButton actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
        NSString *buttonSelectorStr = actionsArray.firstObject;
        SEL buttonSel = buttonSelectorStr ? NSSelectorFromString(buttonSelectorStr) : nil;
        
        // 外部指定优先，否则使用内部默认实现
        SEL selector = buttonSel ? : insideSelector;
        
        /**
         * @warning 因为在 - (void)showLostNetAlertViewWithLoading：... 中已经先移除按钮原有的 SEL 再 addTarget:...
         * 所以不用判断这么麻烦
        /// 判断是否外部指定了按钮 SEL，如果指定则删除默认内部事件
        /// @warning 这里只判断了 UIControlEventTouchUpInside，如果外部使用其他的 Event 则不能过滤
        NSArray *actionsArray = [self.lostNetAlertView.actionButton actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
        if (actionsArray.count > 1 && [actionsArray containsObject:insideSelStr]) {
            // 此时按钮的回调包含内部默认指定、外部指定，则需要删除内部指定
            [self.lostNetAlertView.actionButton removeTarget:self action:insideSelector forControlEvents:UIControlEventTouchUpInside];
        } else if (actionsArray.count) {
            // 只有外部指定的方法
            NSString *firstOutSelStr = actionsArray.firstObject;
            selector = NSSelectorFromString(firstOutSelStr);
        } else {
            // 未指定方法
            selector = insideSelector;
        }
         */
        
        [self showLostNetAlertViewWithLoading:showLoading Image:image text:text detailText:detailText buttonTitle:buttonTitle buttonAction:selector];
    }
}

- (void)addLostNetAlertViewToSuperView {
    if (!self.lostNetAlertView.superview) {
        [self.view addSubview:self.lostNetAlertView];
        [self.view bringSubviewToFront:self.lostNetAlertView];
    }
}

- (void)hideLostNetAlertView {
    [self.lostNetAlertView removeFromSuperview];
}

- (BOOL)isLostNetAlertViewShowing {
    return self.lostNetAlertView && self.lostNetAlertView.superview;
}

- (void)showLostNetAlertViewWithLoading:(BOOL)showLoading
                                  Image:(UIImage *)image
                                   text:(NSString *)text
                             detailText:(NSString *)detailText
                            buttonTitle:(NSString *)buttonTitle
                           buttonAction:(SEL)action {
    [self addLostNetAlertViewToSuperView];
    [self.lostNetAlertView setLoadingViewHidden:showLoading];
    [self.lostNetAlertView setImage:image];
    [self.lostNetAlertView setTextLabelText:text];
    [self.lostNetAlertView setDetailTextLabelText:detailText];
    [self.lostNetAlertView setActionButtonTitle:buttonTitle];
    [self.lostNetAlertView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.lostNetAlertView.actionButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 无网络回调
- (void)_action_clickLostNetButton:(UIButton *)sender {
    [self.lostNetAlertView setLoadingViewHidden:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SpringAnimationDefaultDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.lostNetAlertView setLoadingViewHidden:YES];
    });
    
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        [self hideLostNetAlertView];
    }
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
// 默认不自动显示无网络提示图
//- (BOOL)autoShowNetStatusChangeAlertView {
//    return NO;
//}

#pragma mark ------------------------- set / get -------------------------
- (void)setLostNetAlertView:(QMUIEmptyView *)lostNetAlertView {
    objc_setAssociatedObject(self, @selector(lostNetAlertView), lostNetAlertView, OBJC_ASSOCIATION_RETAIN);
}

- (QMUIEmptyView *)lostNetAlertView {
    QMUIEmptyView *epView = objc_getAssociatedObject(self, _cmd);
    
    if (!epView && self.isViewLoaded) {
        
        epView = [[QMUIEmptyView alloc] initWithFrame:self.view.bounds];
        
        epView.backgroundColor = UIColorForBackground;
        
        self.lostNetAlertView = epView;
    }
    
    return epView;
}

- (BOOL)isNetReachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
