//
//  GGBaseAlertTableViewController.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/6.
//

#import "GGBaseAlertTableViewController.h"

#define AlertContentViewHeight (SCREEN_HEIGHT * 490.f / 812.f)

#define AlertContentViewMaxHeight (SCREEN_HEIGHT)

@interface GGBaseAlertTableViewController ()

//@property (nonatomic, strong) QMUIModalPresentationViewController *alertVC;

@end

@implementation GGBaseAlertTableViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)dealloc {
    QMUILog(nil, @"\nGGBaseAlertTableViewController 释放了\n");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _config];
}

#pragma mark ------------------------- Config -------------------------
- (void)_config {
    self.modal = NO;
    self.animationStyle = QMUIModalPresentationAnimationStyleSlide;
//    self.contentViewMargins = UIEdgeInsetsMake(SCREEN_HEIGHT - AlertContentViewHeight, 0, 0, 0.f);
    self.contentViewMargins = UIEdgeInsetsZero;
    self.maximumContentViewWidth = SCREEN_WIDTH;
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    
}

- (void)uibase_setUpSubViews {
//    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
////    contentView.alwaysBounceVertical = NO;
////    contentView.alwaysBounceHorizontal = NO;
//    contentView.bounces = NO;
//    contentView.backgroundColor = UIColorTestRed;
////    contentView.layer.cornerRadius = 6;
    
    _alertContentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - AlertContentViewHeight, SCREEN_WIDTH, AlertContentViewHeight)];
//    [contentView addSubview:_alertContentView];
    _alertContentView.backgroundColor = UIColorForBackground;
    [_alertContentView ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeTopLeftAndTopRight viewCornerRadius:18.f];
    
    _closeButton = [QMUIButton gg_buttonWithFrame:CGRectZero title:nil backgroundImage:nil];
    [_alertContentView addSubview:_closeButton];
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3.f);
        make.right.equalTo(self.alertContentView);
        make.size.mas_equalTo(CGSizeMake(60.f, 60.f));
    }];
    [_closeButton setImage:UIImageMake(@"icon_closeComment") forState:UIControlStateNormal];
    @ggweakify(self)
    _closeButton.qmui_tapBlock = ^(__kindof UIControl *sender) {
        @ggstrongify(self)
        [self actions_clickCloseButton];
    };
    
    _alertTitleLabel = [QMUILabel labelWithSuperView:_alertContentView withContent:nil withBackgroundColor:nil withTextColor:TabBarItemTitleColorSelected withFont:UIFontBoldMake(18.f)];
    [_alertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.alertContentView);
        make.height.mas_equalTo(64.f);
    }];
    _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _bottomButton = [[QMUIFillButton alloc] initWithFillColor:UIColor.qd_tintColor titleTextColor:UIColorForBackground];
    [_alertContentView addSubview:_bottomButton];
    [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(- 16.f);
        make.bottom.mas_equalTo(- SafeAreaInsetsConstantForDeviceWithNotch.bottom - 16.f);
        make.height.mas_equalTo(40.f);
    }];
    _bottomButton.cornerRadius = 8.f;
    _bottomButton.titleLabel.font = UIFontMediumMake(16.f);
    [_bottomButton addTarget:self action:@selector(actions_clickBottomButton) forControlEvents:UIControlEventTouchUpInside];
//    _bottomButton.qmui_tapBlock = ^(__kindof UIControl *sender) {
//        @ggstrongify(self)
//
//    };
    
    [self uibase_initTableView];
    [self uibase_configTableView];
    [_alertContentView addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertTitleLabel.mas_bottom);
        make.left.right.equalTo(self.alertContentView);
        make.bottom.equalTo(self.bottomButton.mas_top).mas_equalTo(- 16.f);
    }];
    
//    self.contentView = _alertContentView;
    
//    [self updateLayout];
    
    __weak __typeof(self) weakModal = self;
    self.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
//        CGSize contentViewContainerSize = CGSizeMake(CGRectGetWidth(containerBounds) - UIEdgeInsetsGetHorizontalValue(weakModal.contentViewMargins), CGRectGetHeight(containerBounds) - keyboardHeight - UIEdgeInsetsGetVerticalValue(weakModal.contentViewMargins));
//        CGSize contentViewLimitSize = CGSizeMake(MIN(weakModal.maximumContentViewWidth, contentViewContainerSize.width), contentViewContainerSize.height);
//        CGSize contentViewSize = contentView.contentSize;
//        contentViewSize.width = MIN(contentViewLimitSize.width, contentViewSize.width);
//        contentViewSize.height = MIN(contentViewLimitSize.height, contentViewSize.height);
//        CGRect contentViewFrame = CGRectMake(CGFloatGetCenter(contentViewContainerSize.width, contentViewSize.width) + weakModal.contentViewMargins.left, CGFloatGetCenter(contentViewContainerSize.height, contentViewSize.height) + weakModal.contentViewMargins.top, contentViewSize.width, contentViewSize.height);
//        contentView.qmui_frameApplyTransform = contentViewFrame;
        CGFloat defalut_y = SCREEN_HEIGHT - AlertContentViewHeight;
        CGFloat y = MAX(defalut_y - keyboardHeight, StatusBarHeight);
        CGFloat height = SCREEN_HEIGHT - y;
        weakModal.alertContentView.qmui_frameApplyTransform = CGRectMake(0, y, weakModal.alertContentView.qmui_width, height);
    };
    
    self.contentView = _alertContentView;
}

- (void)uibase_initTableView {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (void)uibase_configTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 44.0;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.backgroundColor = nil;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
}

- (BOOL)uibase_useTableViewControllerStyle {
    return NO;
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark --- Tableview Delegate 、DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - empty dataSource and delegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"icon_bg_kongyemian"];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 15.f;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -80;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return NO;
}

///**
// *  当浮层以 UIViewController 的形式展示（而非 UIView），并且使用 modalController 提供的默认布局时，则可通过这个方法告诉 modalController 当前浮层期望的大小。如果 modalController 实现了自己的 layoutBlock，则可不实现这个方法，实现了也不一定按照这个方法的返回值来布局，完全取决于 layoutBlock。
// *  @param  controller  当前的modalController
// *  @param  keyboardHeight 当前的键盘高度，如果键盘降下，则为0
// *  @param  limitSize   浮层最大的宽高，由当前 modalController 的大小及 `contentViewMargins`、`maximumContentViewWidth` 和键盘高度决定
// *  @return 返回浮层在 `limitSize` 限定内的大小，如果业务自身不需要限制宽度/高度，则为 width/height 返回 `CGFLOAT_MAX` 即可
// */
//- (CGSize)preferredContentSizeInModalPresentationViewController:(QMUIModalPresentationViewController *)controller keyboardHeight:(CGFloat)keyboardHeight limitSize:(CGSize)limitSize {
//    return CGSizeMake(SCREEN_WIDTH, AlertContentViewHeight);
//}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 点击关闭按钮
- (void)actions_clickCloseButton {
    [self dismiss];
}

#pragma mark --- 点击底部按钮
- (void)actions_clickBottomButton {
    
}

#pragma mark ------------------------- Interface -------------------------
/// 不使用底部按钮
- (void)removeBottomButton {
    [self.bottomButton removeFromSuperview];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertTitleLabel.mas_bottom);
        make.left.right.equalTo(self.alertContentView);
        make.bottom.mas_equalTo(- SafeAreaInsetsConstantForDeviceWithNotch.bottom - 16.f);
    }];
}

- (void)show {
    [self showInView:[UIWindow getKeyWindow] animated:YES completion:nil];
}

- (void)dismiss {
    [self dismissWithCompletion:_hideByCodeDismissBlock];
}

- (void)dismissWithCompletion:(void (^)(BOOL))completion {
    [self hideInView:self.view.superview animated:YES completion:completion];
}

- (void)hideInView:(UIView *)view animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    @ggweakify(self)
    [super hideInView:view animated:animated completion:^(BOOL finished) {
        @ggstrongify(self)
        if (completion) {
            completion(finished);
        }
        
        if (self.hideByCodeDismissBlock) {
            self.hideByCodeDismissBlock(finished);
        }
    }];
}

- (void)hideWithAnimated:(BOOL)animated completion:(void (^)(BOOL))completion {
    @ggweakify(self)
    [super hideWithAnimated:animated completion:^(BOOL finished) {
        @ggstrongify(self)
        if (completion) {
            completion(finished);
        }
        
        if (self.hideByCodeDismissBlock) {
            self.hideByCodeDismissBlock(finished);
        }
    }];
}

#pragma mark ------------------------- set / get -------------------------
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    _alertTitleLabel.text = title;
}

//- (QMUIModalPresentationViewController *)alertVC {
//    if (!_alertVC) {
//        _alertVC = [[QMUIModalPresentationViewController alloc] init];
//
//        _alertVC.modal = NO;
//        _alertVC.animationStyle = QMUIModalPresentationAnimationStyleSlide;
//        _alertVC.contentViewMargins = UIEdgeInsetsMake(SCREEN_HEIGHT - AlertContentViewHeight, 0, 0, 0.f);
//        _alertVC.maximumContentViewWidth = SCREEN_WIDTH;
//    }
//
//    return _alertVC;
//}

@end










