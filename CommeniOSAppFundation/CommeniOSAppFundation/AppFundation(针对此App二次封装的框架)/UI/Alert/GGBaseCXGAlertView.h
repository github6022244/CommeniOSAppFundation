//
//  GGBaseCXGAlertView.h
//  CXGrainStudentApp
//
//  Created by GG on 2022/3/9.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "GGBaseAlertView.h"

/// 样式
typedef NS_ENUM(NSInteger, GGBaseCXGAlertViewShowType) {
    GGBaseCXGAlertViewShowType_TitleOnly,// 标题 + 底部按钮
    GGBaseCXGAlertViewShowType_SubTitleOnly,// 副标题+底部按钮
    GGBaseCXGAlertViewShowType_TextfieldOnly,// 输入框+底部按钮
    GGBaseCXGAlertViewShowType_TitleAndSubTitle,// 标题+副标题+底部按钮
    GGBaseCXGAlertViewShowType_TitleAndTextfield,// 标题+输入框+底部按钮
    GGBaseCXGAlertViewShowType_TitleAndSubTitleAndTextField,// 标题+副标题+输入框+底部按钮
};

/// 点击底部按钮回调 block
typedef void(^GGBaseCXGAlertViewBottomButtonClickBlock)(NSInteger tag, NSString *textFieldText, GGBaseAlertView *alertView);

/// 配置UI block
typedef void(^GGBaseCXGAlertViewConfigBlock)(GGBaseAlertView *alertView);

@interface GGBaseCXGAlertView : GGBaseAlertView

@property (nonatomic, strong, readonly) UILabel *titleLabel;

@property (nonatomic, strong, readonly) UIView *sepratorTitleView;

@property (nonatomic, strong, readonly) UIView *titleBottomLineView;

@property (nonatomic, strong, readonly) QMUITextView *subTitleTextView;

@property (nonatomic, strong, readonly) QMUITextField *textField;

@property (nonatomic, strong, readonly) QMUIButton *rightTopButton;

@property (nonatomic, strong, readonly) NSMutableArray *bottomButtonsArray;

/// 只有标题+副标题+底部两个按钮(点击左取消按钮自动隐藏 alertView / 点击右确认按钮不主动隐藏 alertView)
+ (instancetype)alertViewWithSubTitleOnlyTitle:(NSString *)title
                                      subTitle:(NSString *)subTitle
                         leftCancelButtonTitle:(NSString *)leftCancelButtonTitle
                          rightDownButtonTitle:(NSString *)rightDownButtonTitle
                                        inView:(UIView *)view
                                         block:(GGBaseCXGAlertViewBottomButtonClickBlock)block;

/// 只有标题+副标题+底部两个按钮+关闭按钮
+ (instancetype)alertViewWithSubTitleOnlyTitle:(NSString *)title
                                      subTitle:(NSString *)subTitle
                         leftCancelButtonTitle:(NSString *)leftCancelButtonTitle
                          rightDownButtonTitle:(NSString *)rightDownButtonTitle
                               needCloseButton:(BOOL)needCloseButton
                                        inView:(UIView *)view
                                 configUIBlock:(GGBaseCXGAlertViewConfigBlock)configUIBlock
                                         block:(GGBaseCXGAlertViewBottomButtonClickBlock)block;

/// 可以设置所有属性
/// ① dismissButtonTag(从0开始计算，值要小于底部按钮数量) 取消按钮在按钮数组里的下标  点击取消按钮自动隐藏 alertView； 如果设置 dismissButtonTag < 0 || dismissButtonTag >= 底部按钮数量， 则屏蔽自动隐藏功能
/// ② 如果只有两个按钮，指定了取消按钮，且有输入框的情况下，点击键盘的 return 会走 block，回调除取消按钮外的那个按钮
+ (instancetype)alertViewWithType:(GGBaseCXGAlertViewShowType)type
                            title:(NSString *)title
                         subTitle:(NSString *)subTitle
                    textFieldText:(NSString *)textFieldText
             textFieldPlaceholder:(NSString *)textFieldPlaceholder
        textFieldClearButtonImage:(UIImage *)image
           textFieldMaxTextLength:(NSInteger)textFieldMaxTextLength
           bottomButtonTitleArray:(NSArray *)titleArray
                  titleColorArray:(NSArray *)titleColorArray
                 dismissButtonTag:(NSInteger)dismissButtonTag
                  needCloseButton:(BOOL)needCloseButton
                           inView:(UIView *)view
                            block:(GGBaseCXGAlertViewBottomButtonClickBlock)block;

@end
