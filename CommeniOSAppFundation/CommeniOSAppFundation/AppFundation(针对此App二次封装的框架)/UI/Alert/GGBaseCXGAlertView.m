//
//  GGBaseCXGAlertView.m
//  CXGrainStudentApp
//
//  Created by GG on 2022/3/9.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "GGBaseCXGAlertView.h"
#import "NSString+GGTextField.h"
#import "GGBaseKit.h"

/// 整个背景view宽度
#define GGBaseCXGAlertViewContainerWidth 227.0

/// textView最小高度
#define GGBaseCXGAlertViewSubTitleTextViewMinHeight 20.0

/// textView最大高度
#define GGBaseCXGAlertViewSubTitleTextViewMaxHeight 200.0

@interface GGBaseCXGAlertView ()<QMUITextViewDelegate, QMUITextFieldDelegate>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *textFieldPlaceHolder;

@property (nonatomic, strong) UIImage *textFieldClearButtonImage;

@property (nonatomic, assign) NSInteger textFieldMaxTextLength;

@property (nonatomic, strong) NSArray *bottomButtonTitleArray;

@property (nonatomic, strong) NSArray *bottomButtonTitleColorArray;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *sepratorTitleView;

@property (nonatomic, strong) UIView *titleBottomLineView;

@property (nonatomic, strong) QMUITextView *subTitleTextView;

@property (nonatomic, strong) YYLabel *subTitleLabel;

@property (nonatomic, strong) QMUITextField *textField;

@property (nonatomic, copy) NSString *textFieldText;

@property (nonatomic, assign) GGBaseCXGAlertViewShowType showType;

@property (nonatomic, copy) GGBaseCXGAlertViewBottomButtonClickBlock bottomButtonClickBlock;

@property (nonatomic, assign) NSInteger dismissButtonTag;

@property (nonatomic, assign) BOOL needCloseButton;

@property (nonatomic, strong) NSMutableArray *bottomButtonsArray;
@property (nonatomic, strong) QMUIGridView *bottomButtonsGridView;

@property (nonatomic, weak) UIView *alertInView;

//@property (nonatomic, copy) NSString *rightTopButtonTitle;
//@property (nonatomic, copy) void(^rightTopButtonBlock)(void);
@property (nonatomic, strong) QMUIButton *rightTopButton;

@property (nonatomic, copy) GGBaseCXGAlertViewConfigBlock configBlock;

@end

@implementation GGBaseCXGAlertView

#pragma mark ------------------------- Cycle -------------------------
- (void)dealloc {
    QMUILog(nil, @"\n\n\n----------------%@释放了----------------\n\n\n", NSStringFromClass([self class]));
}

- (instancetype)initWithType:(GGBaseCXGAlertViewShowType)type
                       title:(NSString *)title
             needCloseButton:(BOOL)needCloseButton
                    subTitle:(NSString *)subTitle
               textFieldText:(NSString *)textFieldText
        textFieldPlaceholder:(NSString *)textFieldPlaceholder
   textFieldClearButtonImage:(UIImage *)image
      textFieldMaxTextLength:(NSInteger)textFieldMaxTextLength
      bottomButtonTitleArray:(NSArray *)titleArray
             titleColorArray:(NSArray *)titleColorArray
            dismissButtonTag:(NSInteger)dismissButtonTag
                 alertInView:(UIView *)alertInView
                       block:(GGBaseCXGAlertViewBottomButtonClickBlock)block
               configUIBlock:(GGBaseCXGAlertViewConfigBlock)configUIBlock {
    if (self = [super init]) {
        self.showType = type;
        self.title = title;
        self.subTitle = subTitle;
        self.textFieldText = textFieldText;
        self.textFieldPlaceHolder = textFieldPlaceholder;
        self.textFieldClearButtonImage = image;
        self.textFieldMaxTextLength = textFieldMaxTextLength;
        self.bottomButtonTitleArray = titleArray;
        self.bottomButtonTitleColorArray = titleColorArray;
        self.bottomButtonClickBlock = block;
        self.dismissButtonTag = dismissButtonTag;
        self.needCloseButton = needCloseButton;
        self.alertInView = alertInView;
        self.configBlock = configUIBlock;
        
        self.bottomButtonsArray = @[].mutableCopy;
        
        [self configContentView];
    }
    
    return self;
}

#pragma mark ------------------------- Interface -------------------------
/// 只有标题+副标题
+ (instancetype)alertViewWithSubTitleOnlyTitle:(NSString *)title
                                      subTitle:(NSString *)subTitle
                         leftCancelButtonTitle:(NSString *)leftCancelButtonTitle
                          rightDownButtonTitle:(NSString *)rightDownButtonTitle
                                        inView:(UIView *)view
                                         block:(GGBaseCXGAlertViewBottomButtonClickBlock)block {

    return [self alertViewWithSubTitleOnlyTitle:title subTitle:subTitle leftCancelButtonTitle:leftCancelButtonTitle rightDownButtonTitle:rightDownButtonTitle needCloseButton:NO inView:view configUIBlock:nil block:block];
}

/// 只有标题+副标题+底部两个按钮+关闭按钮
+ (instancetype)alertViewWithSubTitleOnlyTitle:(NSString *)title
                                      subTitle:(NSString *)subTitle
                         leftCancelButtonTitle:(NSString *)leftCancelButtonTitle
                          rightDownButtonTitle:(NSString *)rightDownButtonTitle
                               needCloseButton:(BOOL)needCloseButton
                                        inView:(UIView *)view
                                 configUIBlock:(GGBaseCXGAlertViewConfigBlock)configUIBlock
                                         block:(GGBaseCXGAlertViewBottomButtonClickBlock)block {
    NSMutableArray *marr_title = @[].mutableCopy;
    
    if (leftCancelButtonTitle) {
        [marr_title addObject:leftCancelButtonTitle];
    }
    
    if (rightDownButtonTitle) {
        [marr_title addObject:rightDownButtonTitle];
    }
    
    NSMutableArray *marr_color = @[].mutableCopy;
    
    if (leftCancelButtonTitle) {
        [marr_color addObject:[UIColorMakeWithHex(@"#000000") colorWithAlphaComponent:0.6]];
    }
    
    if (rightDownButtonTitle) {
        [marr_color addObject:UIColorMakeWithHex(@"#3E6AF7")];
    }
    
//    return [self alertViewWithType:GGBaseCXGAlertViewShowType_TitleAndSubTitle title:title subTitle:subTitle textFieldText:nil textFieldPlaceholder:nil textFieldClearButtonImage:nil textFieldMaxTextLength:0 bottomButtonTitleArray:marr_title titleColorArray:marr_color dismissButtonTag:0 needCloseButton:NO inView:view block:block];
    
    GGBaseCXGAlertView *aView = [[GGBaseCXGAlertView alloc] initWithType:GGBaseCXGAlertViewShowType_TitleAndSubTitle title:title needCloseButton:needCloseButton subTitle:subTitle textFieldText:nil textFieldPlaceholder:nil textFieldClearButtonImage:nil textFieldMaxTextLength:0 bottomButtonTitleArray:marr_title titleColorArray:marr_color dismissButtonTag:0 alertInView:view block:block configUIBlock:configUIBlock];
    
    @ggweakify(aView);
    [aView showInView:view completion:^(BOOL finished) {
        @ggstrongify(aView)
        if (finished && aView.textField.superview) {
            /// 有输入框
            [aView.textField becomeFirstResponder];
        }
    }];
    
    return aView;
}

/// 标题右侧带个 X 号
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
                            block:(GGBaseCXGAlertViewBottomButtonClickBlock)block {
    GGBaseCXGAlertView *aView = [[GGBaseCXGAlertView alloc] initWithType:type title:title needCloseButton:needCloseButton subTitle:subTitle textFieldText:textFieldText textFieldPlaceholder:textFieldPlaceholder textFieldClearButtonImage:image textFieldMaxTextLength:textFieldMaxTextLength bottomButtonTitleArray:titleArray titleColorArray:titleColorArray dismissButtonTag:dismissButtonTag alertInView:view block:block configUIBlock:nil];
    
    @ggweakify(aView);
    [aView showInView:view completion:^(BOOL finished) {
        @ggstrongify(aView)
        if (finished && aView.textField.superview) {
            /// 有输入框
            [aView.textField becomeFirstResponder];
        }
    }];
    
    return aView;
}

#pragma mark ------------------------- UI -------------------------
- (void)configContentView {
    UIView *view = self;
//    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(57,GGBaseCXGAlertViewContainerWidth,263,214);
    view.backgroundColor = UIColorWhite;
    view.layer.cornerRadius = 8;
    
    /// 标题
    if (_showType != GGBaseCXGAlertViewShowType_SubTitleOnly && _showType != GGBaseCXGAlertViewShowType_TextfieldOnly) {
        CGFloat spaceH_titleLabel = self.needCloseButton ? (50.f + 6.f) : 20.f;
        _titleLabel = [UILabel labelWithSuperView:view withContent:_title withBackgroundColor:nil withTextColor:[UIColorMakeWithHex(@"#000000") colorWithAlphaComponent:0.8] withFont:UIFontMediumMake(16)];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.right.equalTo(view);
            make.top.mas_equalTo(11.f);
            make.left.mas_equalTo(spaceH_titleLabel);
            make.right.mas_equalTo(- spaceH_titleLabel);
            make.height.mas_greaterThanOrEqualTo(28.f);
        }];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        
        /// title下分割线
        UIView *lineView = [self addBottomSepratorLineWithLeftSpace:0.f rightSpace:0.f];
        [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(11.f);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(0.5f);
        }];
        _sepratorTitleView = lineView;
    }
    
    if (_needCloseButton) {
        CGSize buttonSize = CGSizeZero;
        if (_showType == GGBaseCXGAlertViewShowType_TextfieldOnly) {
            // 只有输入框
            buttonSize = CGSizeMake(40.f + 12.f * 2, 40.f + 12.f * 2);
        } else {
            buttonSize = CGSizeMake(50, 50);
        }
        
        QMUIButton *button = [QMUIButton gg_buttonWithFrame:CGRectZero title:nil titleColor:nil titleFont:nil image:UIImageMake(@"icon_closeComment") backgroundColor:nil];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.titleLabel) {
                make.right.mas_equalTo(- 10.f);
                make.top.bottom.equalTo(self.titleLabel);
            } else {
                make.top.right.equalTo(self);
                make.size.mas_equalTo(buttonSize);
            }
//            make.size.mas_equalTo(buttonSize);
        }];
        button.titleLabel.font = UIFontMake(14.f);
        button.qmui_outsideEdge = UIEdgeInsetsMake(- 10.f, - 10.f, - 10.f, - 10.f);
        @ggweakify(self)
        button.qmui_tapBlock = ^(__kindof UIControl *sender) {
            @ggstrongify(self)
            [self closeButtonClick];
        };
        _rightTopButton = button;
    }
    
    /// 子标题 textView
    if (_showType == GGBaseCXGAlertViewShowType_SubTitleOnly || _showType == GGBaseCXGAlertViewShowType_TitleAndSubTitleAndTextField || _showType == GGBaseCXGAlertViewShowType_TitleAndSubTitle) {
        /// 有子标题
        CGFloat spaceH_subTitleTextView = _showType == GGBaseCXGAlertViewShowType_SubTitleOnly && self.needCloseButton ? (50.f + 6.f) : 20.f;
        
        if ([_subTitle isKindOfClass:[NSString class]]) {
            _subTitleTextView = [[QMUITextView alloc] initWithFrame:CGRectZero];
            [view addSubview:_subTitleTextView];
            [_subTitleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.sepratorTitleView) {
                    make.top.equalTo(self.sepratorTitleView.mas_bottom).mas_equalTo(12.f).priorityHigh();
                } else {
                    make.top.mas_equalTo(12.f);
                }
                make.left.mas_equalTo(spaceH_subTitleTextView);
                make.right.mas_equalTo(- spaceH_subTitleTextView);
                make.height.mas_lessThanOrEqualTo(GGBaseCXGAlertViewSubTitleTextViewMaxHeight);
            }];
            _subTitleTextView.delegate = self;
            _subTitleTextView.canPerformPasteActionBlock = ^BOOL(id sender, BOOL superReturnValue) {
                return NO;
            };
            
            /// QMUITextView 在自动计算高度时，需要准确的 bounds，所以先 layout 一下
            [view layoutIfNeeded];
            
            // 让文字居中
            if ([_subTitle isKindOfClass:[NSString class]]) {
                NSMutableAttributedString *attr_subtitle = [[NSMutableAttributedString alloc] initWithString:_subTitle attributes:@{NSForegroundColorAttributeName : [UIColorBlack colorWithAlphaComponent:0.6], NSFontAttributeName : UIFontMake(14)}];
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = NSTextAlignmentCenter;
                [attr_subtitle addAttribute:NSParagraphStyleAttributeName
                                                 value:paragraph
                                                 range:NSMakeRange(0, [attr_subtitle length])];
                _subTitleTextView.attributedText = attr_subtitle;
            } else if ([_subTitle isKindOfClass:[NSAttributedString class]]) {
                _subTitleTextView.attributedText = (NSAttributedString *)_subTitle;
            }
            /// 必须要在 _subTitleTextView setText 之后设置，不然不走 delegate 方法
            _subTitleTextView.editable = NO;
    //        _subTitleTextView.userInteractionEnabled = NO;
        } else if ([_subTitle isKindOfClass:[NSAttributedString class]]) {
            _subTitleLabel = [[YYLabel alloc] init];
            [view addSubview:_subTitleLabel];
            _subTitleLabel.textColor = [UIColorBlack colorWithAlphaComponent:0.6];
            _subTitleLabel.font = UIFontMake(14);
            _subTitleLabel.numberOfLines = 0;
            _subTitleLabel.attributedText = (NSAttributedString *)_subTitle;
            CGFloat height = [_subTitleLabel sizeThatFits:CGSizeMake(view.qmui_width - spaceH_subTitleTextView * 2, CGFLOAT_MAX)].height;
            [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.sepratorTitleView) {
                    make.top.equalTo(self.sepratorTitleView.mas_bottom).mas_equalTo(12.f).priorityHigh();
                } else {
                    make.top.mas_equalTo(12.f);
                }
                make.left.mas_equalTo(spaceH_subTitleTextView);
                make.right.mas_equalTo(- spaceH_subTitleTextView);
                make.height.mas_equalTo(height);
            }];
        }
    }
    
    /// 输入框
    if (_showType == GGBaseCXGAlertViewShowType_TextfieldOnly || _showType == GGBaseCXGAlertViewShowType_TitleAndSubTitleAndTextField) {
        UIView *topView = nil;
        if (_subTitleTextView) {
            topView = _subTitleTextView;
        } else if (_subTitleLabel) {
            topView = _subTitleLabel;
        } else if (_sepratorTitleView) {
            topView = _sepratorTitleView;
        } else {
            topView = view;
        }
        
        CGFloat spaceH_textField = _showType == GGBaseCXGAlertViewShowType_TextfieldOnly && self.needCloseButton ? (50.f + 6.f) : 24.f;
        
        _textField = [[QMUITextField alloc] init];
        [view addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([topView isEqual:view]) {
                make.top.mas_equalTo(12.f);
            } else {
                make.top.equalTo(topView.mas_bottom).mas_equalTo(12);
            }
            make.left.mas_equalTo(spaceH_textField);
            make.right.mas_equalTo(- spaceH_textField);
            make.height.mas_equalTo(40);
        }];
        _textField.font = UIFontMake(14);
        _textField.textInsets = UIEdgeInsetsMake(7, 16, 7, 6);
        _textField.clearButtonPositionAdjustment = UIOffsetMake(- 9, 0);
        _textField.placeholder = _textFieldPlaceHolder;
        _textField.textColor = [UIColorMakeWithHex(@"#000000") colorWithAlphaComponent:0.8];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.qmui_clearButtonImage = UIImageMake(@"icon_clear_black");
        _textField.layer.cornerRadius = 8.0;
        _textField.backgroundColor = [UIColorMakeWithHex(@"#000000") colorWithAlphaComponent:0.05];
        _textField.clipsToBounds = YES;
        _textField.delegate = self;
        _textField.maximumTextLength = _textFieldMaxTextLength ? : NSUIntegerMax;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.text = _textFieldText;
    }
    
    /// 底部按钮
    UIView *lastView = nil;
    CGFloat bottomButtonTopSpace = 12.f;
    if (_textField) {
        lastView = _textField;
    } else if (_subTitleTextView) {
        lastView = _subTitleTextView;
    } else if (_subTitleLabel) {
        lastView = _subTitleLabel;
    } else if (_sepratorTitleView) {
        lastView = _sepratorTitleView;
        bottomButtonTopSpace = 0.f;
    } else {
        lastView = view;
    }
    
    if (_bottomButtonTitleArray.count) {
        UIView *topView = lastView;
        
        CGFloat topSpace = bottomButtonTopSpace;
        
        _bottomButtonsGridView = [[QMUIGridView alloc] initWithColumn:_bottomButtonTitleArray.count rowHeight:48.f];
        [view addSubview:_bottomButtonsGridView];
        [_bottomButtonsGridView mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([lastView isEqual:view]) {
                make.top.mas_equalTo(topSpace);
            } else {
                make.top.equalTo(topView.mas_bottom).mas_equalTo(topSpace);
            }
            make.left.right.equalTo(view);
            make.height.mas_equalTo(48.f);
        }];
        
        lastView = _bottomButtonsGridView;
        
//        CGSize bottomButtonSize = CGSizeMake(view.width / _bottomButtonTitleArray.count, 48.0);
        
        NSString *btnTitle = nil;
        
        UIColor *btnTitleColor = nil;
        
        for (NSInteger i = 0; i < _bottomButtonTitleArray.count; i++) {
            btnTitle = [_bottomButtonTitleArray gg_safeObjectAtIndex:i];
            btnTitleColor = [_bottomButtonTitleColorArray gg_safeObjectAtIndex:i];
            
//            CGRectMake(bottomButtonSize.width * i, 0, bottomButtonSize.width, bottomButtonSize.height)
            
            QMUIButton *button = [QMUIButton gg_buttonWithFrame:CGRectZero title:btnTitle titleColor:btnTitleColor titleFont:UIFontMediumMake(18) image:nil backgroundColor:[UIColorMakeWithHex(@"#000000") colorWithAlphaComponent:0.02]];
            [_bottomButtonsGridView addSubview:button];
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(topView.mas_bottom).mas_equalTo(topSpace);
//                make.left.mas_equalTo(button.frame.origin.x);
//                make.size.mas_equalTo(button.size);
//            }];
            button.contentEdgeInsets = UIEdgeInsetsMake(0.f, 10.f, 0.5, 10.f);
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            
            [self.bottomButtonsArray addObject:button];
            
            button.tag = 1000 + i;
            
            @ggweakify(self)
            button.qmui_tapBlock = ^(__kindof UIButton *sender) {
                @ggstrongify(self)
                [self bottomButtonClick:sender];
            };
            
//            if (i == 0) {
//                lastView = button;
//            }
        }
    }
    
    [view layoutIfNeeded];
    
    /// 计算排版后总高度
    if (self.bottomButtonsArray.count) {
        /// 底部有按钮
        view.qmui_height = lastView.qmui_bottom;
    } else {
        /// 底部没有按钮
        if (_showType == GGBaseCXGAlertViewShowType_TitleOnly) {
            view.qmui_height = lastView.qmui_bottom;
        } else {
            view.qmui_height = lastView.qmui_bottom + 12;
        }
    }
    
    if (_configBlock) {
        _configBlock(self);
    }
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark --- SubTitleTextViewDelegate
/**
 *  输入框高度发生变化时的回调，当实现了这个方法后，文字输入过程中就会不断去计算输入框新内容的高度，并通过这个方法通知到 delegate
 *  @note 只有当内容高度与当前输入框的高度不一致时才会调用到这里，所以无需在内部做高度是否变化的判断。
 */
- (void)textView:(QMUITextView *)textView newHeightAfterTextChanged:(CGFloat)height {
    CGFloat realHeight = height;
    
    if (height < GGBaseCXGAlertViewSubTitleTextViewMinHeight) {
        realHeight = GGBaseCXGAlertViewSubTitleTextViewMinHeight;
    } else if (height > GGBaseCXGAlertViewSubTitleTextViewMaxHeight) {
        realHeight = GGBaseCXGAlertViewSubTitleTextViewMaxHeight;
    }
    
    [textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(realHeight);
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL containEmoji = [NSString gg_checkStringContainsEmoji:string];
    
    return !containEmoji;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_dismissButtonTag < 0 || _dismissButtonTag >= _bottomButtonsArray.count) {
        /// _dismissButtonTag 合法性过滤
        return YES;
    } else {
        /// _dismissButtonTag 合法
        if (_bottomButtonsArray.count == 2) {
            /// 只有两个按钮，则除 dismissButton 之外就是 确认按钮，响应点击回调
            NSInteger targetButtonTag = _dismissButtonTag == 0 ? _bottomButtonsArray.count - 1 : 0;
            UIButton *button = [_bottomButtonsArray gg_safeObjectAtIndex:targetButtonTag];
            
            [self bottomButtonClick:button];
        }
    }
    
    return YES;
}

#pragma mark -- contentView布局方式
- (GGBaseAlertViewContentViewLayoutType)contentViewLayoutType {
    return GGBaseAlertViewContentViewLayoutType_Center;
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 底部按钮点击回调
- (void)bottomButtonClick:(UIButton *)button {
    BOOL autoHideAlertView = (button.tag - 1000 == _dismissButtonTag) && (_dismissButtonTag >= 0) && (_dismissButtonTag < _bottomButtonsArray.count);
    
    if (autoHideAlertView) {
        [self dismissView];
    }
    
    if (_bottomButtonClickBlock) {
        __weak typeof(self) weakSelf = self;
        _bottomButtonClickBlock(button.tag - 1000, _textField.text, weakSelf);
    }
}

#pragma mark --- 点击关闭按钮回调
- (void)closeButtonClick {
    [self dismissView];
}

@end
