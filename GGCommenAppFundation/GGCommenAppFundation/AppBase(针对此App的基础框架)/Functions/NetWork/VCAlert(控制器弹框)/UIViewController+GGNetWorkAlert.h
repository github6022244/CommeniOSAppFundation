//
//  UIViewController+GGNetWorkAlert.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
/**
 *  本类用来实现网络状态提示相关功能
 */

#import <UIKit/UIKit.h>
#import <QMUIKit.h>
#import <AFNetworking.h>

@protocol UIViewConntrollerGGNetWorkAlertProtocol <NSObject>

@optional
// 是否自动展示/隐藏网络状态改变提示图(默认NO，子类可重写这个方法返回YES)
- (BOOL)autoShowNetStatusChangeAlertView;

// 在展示视图时机之前调用
- (void)configLostNetAlertView:(QMUIEmptyView * _Nonnull)lostNetAlertView;

@end




NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GGNetWorkAlert)<UIViewConntrollerGGNetWorkAlertProtocol>

/**
 *  空列表控件，支持显示提示文字、loading、操作按钮，该属性懒加载
 */
@property(nullable, nonatomic, strong) QMUIEmptyView *lostNetAlertView;

@property (nonatomic, assign, readonly, getter=isNetReachable) BOOL netReachable;

/// 网络环境改变
// 通知:失去网络连接
- (void)notify_lostNetWork:(NSNotification *)notify;// 通知回调
// 网络状态改变回调
- (void)gg_networkStatusChange:(AFNetworkReachabilityStatus)status;// 可直接拿到 status 使用

// 无网络视图相关
// 展示
- (void)showLostNetAlertView;
// 隐藏
- (void)hideLostNetAlertView;
// 获取显隐状态
- (BOOL)isLostNetAlertViewShowing;
//// 展示
//- (void)showLostNetAlertViewWithLoading:(BOOL)showLoading
//                                  Image:(UIImage *)image
//                                   text:(NSString *)text
//                             detailText:(NSString *)detailText
//                            buttonTitle:(NSString *)buttonTitle
//                           buttonAction:(SEL)action;

@end

NS_ASSUME_NONNULL_END
