//
//  QMUIDropdownNotification+GG.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/28.
//

#import "QMUIDropdownNotification+GG.h"
#import "QDThemeManager.h"

@implementation QMUIDropdownNotification (GG)

#pragma mark --- 展示一个通知
+ (void)showNotificationWithTitle:(NSString *)title content:(NSString *)content {
    QMUIDropdownNotification *notification = [QMUIDropdownNotification notificationWithViewClass:QMUIDropdownNotificationView.class configuration:^(QMUIDropdownNotificationView * _Nonnull view) {
        view.imageView.image = [UIImage qmui_imageWithColor:UIColor.qd_tintColor size:CGSizeMake(16, 16) cornerRadius:1.5];
        view.titleLabel.text = title ? : @"标题";
        view.descriptionLabel.text = content ? : @"详细文本";
    }];
    notification.didTouchBlock = ^(__kindof QMUIDropdownNotification * _Nonnull notification) {
        [notification hide];
    };
    [notification show];
}

@end
