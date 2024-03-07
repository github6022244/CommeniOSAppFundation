//
//  GGBaseAlertTableViewController.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/6.
//

#import <QMUIKit/QMUIKit.h>
#import "UIViewController+UIBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GGBaseAlertTableViewController : QMUIModalPresentationViewController<QMUITableViewDelegate, QMUITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
//GGBaseTableViewController<QMUIModalPresentationContentViewControllerProtocol>

//@property (nonatomic, strong, readonly) QMUIModalPresentationViewController *alertVC;

/// 弹出视图的总背景
/// 最后赋值给 contentView
@property (nonatomic, strong) UIView *alertContentView;

/// 标题
@property (nonatomic, strong) QMUILabel *alertTitleLabel;

/// 关闭按钮
@property (nonatomic, strong) QMUIButton *closeButton;

/// 底部按钮
@property (nonatomic, strong) QMUIFillButton *bottomButton;

/// 列表
@property (nonatomic, strong) QMUITableView *tableView;

/// 代码调用 dismiss 的 block
@property (nonatomic, copy) void(^hideByCodeDismissBlock)(BOOL finished);

///// 布局
///// 供子类重写，初始化 alertContentView
///// @warning 不要直接使用 contentView
//- (void)self_setUpSubViews NS_REQUIRES_SUPER;

/// 不使用底部按钮
- (void)removeBottomButton;

/// 点击底部按钮
/// 供子类重写
- (void)actions_clickBottomButton;

- (void)show;

- (void)dismiss;

- (void)dismissWithCompletion:(void (^)(BOOL))completion;

@end

NS_ASSUME_NONNULL_END
