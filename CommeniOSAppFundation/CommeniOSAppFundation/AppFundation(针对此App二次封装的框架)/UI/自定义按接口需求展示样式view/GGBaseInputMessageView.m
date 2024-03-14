//
//  GGBaseInputMessageView.m
//  CXGrainStudentApp
//
//  Created by GG on 2022/5/17.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "GGBaseInputMessageView.h"
#import <ReactiveObjC.h>
#import "InfoPicker.h"
#import "BRDatePickerView.h"
#import <TZImagePickerController.h>
#if __has_include(<YYKit/YYKit.h>)
#import <YYKit/YYKitMacro.h>
#else
#import "YYKitMacro.h"
#endif

#import <objc/runtime.h>

// 默认view高度
#define GGBaseInputMessageViewDefaultHeight 200.f

// 内容第一个与最后一个控件 与父视图纵向间距
#define GGBaseInputMessageViewDefaultSpaceV (16.f * kScaleFit)

// 每行纵向间距
#define GGBaseInputMessageViewItemSpaceV (4.f * kScaleFit)

// 默认内容控件高度
#define GGBaseInputMessageViewContentViewDefaultHeight (28.f * kScaleFit)

// 默认文本框高度
#define GGBaseInputMessageViewTextViewDefaultHeight (80.f * kScaleFit)

// 默认subview 横向间距
#define GGBaseInputMessageViewSpace_H (16.f * kScaleFit)

@interface GGBaseInputMessageView ()<TZImagePickerControllerDelegate, QMUITextViewDelegate>

@property (nonatomic, strong) QMUILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation GGBaseInputMessageView

#pragma mark ------------------------- Cycle -------------------------
+ (instancetype)viewWithModel:(GGBaseInputMessage *)messageModel {
    GGBaseInputMessageView *view = [[[self class] alloc] init];
//    view.frame = messageModel ? CGRectZero : CGRectSetSize(CGRectZero, CGSizeMake(SCREEN_WIDTH, GGBaseInputMessageViewDefaultHeight));
    view.messageModel = messageModel;
    [view setUpUI];
    
    return view;
}

//- (instancetype)init {
//    if (self = [super init]) {
//        self.userInteractionEnabled = YES;
//        [self setUpUI];
//    }
//
//    return self;
//}

#pragma mark ------------------------- UI -------------------------
- (void)setUpUI {
    self.backgroundColor = UIColorForBackground;

    _titleLabel = [QMUILabel labelWithSuperView:self withContent:nil withBackgroundColor:nil withTextColor:UIColor.qd_titleTextColor withFont:UIFontBoldMake(20)];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(GGBaseInputMessageViewDefaultSpaceV);
        make.left.mas_equalTo(GGBaseInputMessageViewDefaultSpaceV);
        make.width.mas_greaterThanOrEqualTo(1.f);
        make.height.mas_equalTo(28.f * kScaleFit);
    }];
    
    _lineView = [self addTopSepratorLineWithLeftSpace:GGBaseInputMessageViewDefaultSpaceV rightSpace:GGBaseInputMessageViewDefaultSpaceV topSpace:51.f * kScaleFit];
    
    if (_messageModel) {
        UIView *lastView = _lineView;
//        __block QMUILabel *titleLabel = nil;
        
        for (NSUInteger i = 0; i < _messageModel.data.count; i++) {
            GGBaseInputMessageBaseModel *model = _messageModel.data[i];
            BOOL stop = i == _messageModel.data.count - 1;
            
            QMUILabel *titleLabel = (QMUILabel *)[self _layoutTitleLabelUIWithSameTopView:lastView isLastSubView:stop model:model];
            lastView = titleLabel;
            
            switch (model.funcType) {
                case GGBaseInputMessageBaseModelFuncType_Input:
                case GGBaseInputMessageBaseModelFuncType_InputNumber: {
                    UIView *rView = [self _layoutTextFieldUIWithSameTopView:titleLabel isLastSubView:stop model:model];
                    lastView = rView;
                }
                    break;
                case GGBaseInputMessageBaseModelFuncType_TextArea: {
                    lastView = [self _layoutTextViewUIWithSameTopView:titleLabel isLastSubView:stop model:model];
                }
                    break;
                case GGBaseInputMessageBaseModelFuncType_Select:
                case GGBaseInputMessageBaseModelFuncType_TimePicker:
                case GGBaseInputMessageBaseModelFuncType_DatePicker:
                case GGBaseInputMessageBaseModelFuncType_TreeSelect: {
                    lastView = [self _layoutSingleSelectViewUIWithSameTopView:titleLabel isLastSubView:stop model:model];
                }
                    break;
                case GGBaseInputMessageBaseModelFuncType_Image: {
                    QMUILog(nil, @"没有设计图，没做");
                }
                    break;
                default:
                    break;
            }
        }
        
//        [_messageModel.data enumerateObjectsUsingBlock:^(GGBaseInputMessageBaseModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
//
//            titleLabel = (QMUILabel *)[self _layoutTitleLabelUIWithSameTopView:lastView isLastSubView:stop model:model];
//            lastView = titleLabel;
//
//            switch (model.funcType) {
//                case GGBaseInputMessageBaseModelFuncType_Input:
//                case GGBaseInputMessageBaseModelFuncType_InputNumber: {
//                    UIView *rView = [self _layoutTextFieldUIWithSameTopView:titleLabel isLastSubView:stop model:model];
//                    lastView = rView;
//                }
//                    break;
//                case GGBaseInputMessageBaseModelFuncType_TextArea: {
//                    lastView = [self _layoutTextViewUIWithSameTopView:titleLabel isLastSubView:stop model:model];
//                }
//                    break;
//                case GGBaseInputMessageBaseModelFuncType_Select:
//                case GGBaseInputMessageBaseModelFuncType_TimePicker:
//                case GGBaseInputMessageBaseModelFuncType_DatePicker:
//                case GGBaseInputMessageBaseModelFuncType_TreeSelect: {
//                    lastView = [self _layoutSingleSelectViewUIWithSameTopView:titleLabel isLastSubView:stop model:model];
//                }
//                    break;
//                case GGBaseInputMessageBaseModelFuncType_Image: {
//                    QMUILog(nil, @"没有设计图，没做");
//                }
//                    break;
//                default:
//                    break;
//            }
//
//        }];
    }
}

//// 内容第一个与最后一个控件 与父视图纵向间距
//#define GGBaseInputMessageViewItemSpaceV (4.f * kScaleFit)
//
//// 默认内容控件高度
//#define GGBaseInputMessageViewContentViewDefaultHeight (28.f * kScaleFit)
//
//// 默认文本框高度
//#define GGBaseInputMessageViewTextViewDefaultHeight (60.f * kScaleFit)
//
//// 默认subview 横向间距
//#define GGBaseInputMessageViewSpace_H (16.f * kScaleFit)

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 点击单选选择按钮
- (void)actions_ClickSingleSelectWithShowData:(GGBaseInputMessageBaseModel *)model button:(QMUIButton *)button {
    switch (model.funcType) {
        case GGBaseInputMessageBaseModelFuncType_Select: {
            // 单选
            NSMutableArray *dataArr = [NSMutableArray array];

            [model.singleSelectData enumerateObjectsUsingBlock:^(GGBaseInputMessageSingleSelectData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *subStr = obj.title;
                BRResultModel *model = [[BRResultModel alloc] init];
                model.value = subStr;
                model.index = idx;
                [dataArr addObject:model];
            }];
            
            [[UIWindow getKeyWindow] endEditing:YES];
            
            @ggweakify(model)
            @ggweakify(button)
            [InfoPicker showPickerViewWithTitle:model.title
                                        dataArr:dataArr
                                    selectIndex:model.currentSelectSingleOptionIndex resultBlock:^(BRResultModel * _Nullable resultModel) {
                @ggstrongify(model)
                @ggstrongify(button)
                model.currentSelectSingleOptionIndex = resultModel.index;
                
                GGBaseInputMessageSingleSelectData *subModel = [model.singleSelectData gg_safeObjectAtIndex:resultModel.index];
                model.singleSelectedID = subModel.ID;
                
                [button setTitle:subModel.title forState:UIControlStateNormal];
            }];
        }
            break;
        case GGBaseInputMessageBaseModelFuncType_DatePicker: {
            // 日期选择
            [self actions_ClickShowDatePickerWithModel:model button:button];
        }
            break;
        case GGBaseInputMessageBaseModelFuncType_TimePicker: {
            // 时间选择
            [self actions_ClickShowTimeDatePickerWithModel:model button:button];
        }
            break;
        case GGBaseInputMessageBaseModelFuncType_Image: {
            // 图片
            [self actions_ClickImageSelectWithModel:model button:button];
        }
            break;
        case GGBaseInputMessageBaseModelFuncType_TreeSelect: {
            // 地址选择
            [self actions_ClickTreeSelectPickerWithModel:model button:button];
        }
            break;
        default:
            break;
    }
}

#pragma mark --- 点击日期选择
- (void)actions_ClickShowDatePickerWithModel:(GGBaseInputMessageBaseModel *)model button:(QMUIButton *)button {
    @ggweakify(model)
    @ggweakify(button)
    [BRDatePickerView showDatePickerWithMode:BRDatePickerModeYMD title:model.title selectValue:model.selectDateValue minDate:nil maxDate:nil isAutoSelect:NO resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        @ggstrongify(model)
        @ggstrongify(button)
        model.selectDate = selectDate;
        model.selectDateValue = selectValue;
        
        [button setTitle:selectValue forState:UIControlStateNormal];
    }];
}

#pragma mark --- 点击时间选择
- (void)actions_ClickShowTimeDatePickerWithModel:(GGBaseInputMessageBaseModel *)model button:(QMUIButton *)button {
    @ggweakify(model)
    @ggweakify(button)
    [BRDatePickerView showDatePickerWithMode:BRDatePickerModeHMS title:model.title selectValue:model.selectDateValue minDate:nil maxDate:nil isAutoSelect:NO resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        @ggstrongify(model)
        @ggstrongify(button)
        model.selectDate = selectDate;
        model.selectDateValue = selectValue;
        
        [button setTitle:selectValue forState:UIControlStateNormal];
    }];
}

#pragma mark --- 点击地址选择
- (void)actions_ClickTreeSelectPickerWithModel:(GGBaseInputMessageBaseModel *)model button:(QMUIButton *)button {
    @ggweakify(model)
    @ggweakify(button)
    [InfoPicker showAddressPickerViewWithTitle:model.title customAddressData:model.areaData selectIndexs:@[
        @(model.currentSelectProvinceIndex),
        @(model.currentSelectCityIndex),
        @(model.currentSelectAreaIndex),
    ] resultBlock:^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
        @ggstrongify(model)
        @ggstrongify(button)
        model.currentSelectProvinceIndex = province.index;
        model.currentSelectCityIndex = city.index;
        model.currentSelectAreaIndex = area.index;
        
        model.selectProvinceID = province.code;
        model.selectCityID = city.code;
        model.selectAreaID = area.code;
        
        [button setTitle:[NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name] forState:UIControlStateNormal];
    }];
}

#pragma mark --- 点击图片选择
- (void)actions_ClickImageSelectWithModel:(GGBaseInputMessageBaseModel *)model button:(QMUIButton *)button {
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePicker.sortAscendingByModificationDate = NO;
    imagePicker.allowTakeVideo = NO;
    imagePicker.allowPickingVideo = NO;
    imagePicker.allowPickingGif = NO;
    imagePicker.autoDismiss = YES;
    
    UIViewController *topVC = [QMUIHelper visibleViewController];
    
    if (topVC) {
        [topVC fullScreenPresentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (photos.count > 0) {
        //FIXME: 图片选择完成后未处理
    }
}

#pragma mark --- QMUITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    textView.model.inputString = textView.text;
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 单选框布局
- (UIView *)_layoutSingleSelectViewUIWithSameTopView:(UIView *)sameTopView isLastSubView:(BOOL)isLastSubView model:(GGBaseInputMessageBaseModel *)model {
    QMUIButton *selectButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:selectButton];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sameTopView);
        if (isLastSubView) {
            // 最后一个
            make.height.mas_equalTo(GGBaseInputMessageViewContentViewDefaultHeight);
            make.bottom.equalTo(self).mas_equalTo(- GGBaseInputMessageViewDefaultSpaceV);
        } else {
            make.bottom.equalTo(sameTopView);
        }
        make.right.mas_equalTo(- GGBaseInputMessageViewSpace_H);
        make.width.mas_greaterThanOrEqualTo(1.f);
    }];
    selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    selectButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [selectButton setTitleColor:UIColor.qd_titleTextColor forState:UIControlStateNormal];
    [selectButton setTitle:@"请选择" forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"icon_homepage_leftarrow"] forState:UIControlStateNormal];
    selectButton.contentMode = UIViewContentModeRight;
    selectButton.imagePosition = QMUIButtonImagePositionRight;
    selectButton.spacingBetweenImageAndTitle = 6.f;
    @ggweakify(self)
    selectButton.qmui_tapBlock = ^(__kindof QMUIButton *sender) {
        @ggstrongify(self)
        [self actions_ClickSingleSelectWithShowData:model button:sender];
    };
    
    return selectButton;
}

#pragma mark --- 文本框布局
- (UIView *)_layoutTextViewUIWithSameTopView:(UIView *)sameTopView isLastSubView:(BOOL)isLastSubView model:(GGBaseInputMessageBaseModel *)model {
    QMUITextView *textView = [[QMUITextView alloc] initWithFrame:CGRectZero];
    [self addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sameTopView);
        if (isLastSubView) {
            // 最后一个
            make.bottom.equalTo(self).mas_equalTo(- GGBaseInputMessageViewDefaultSpaceV);
        }
        make.right.mas_equalTo(- GGBaseInputMessageViewSpace_H);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.6);
        make.height.mas_equalTo(GGBaseInputMessageViewTextViewDefaultHeight);
    }];
    textView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    textView.textColor = UIColor.qd_titleTextColor;
    textView.placeholder = [NSString stringWithFormat:@"请输入%@", model.title];
//    textView.placeholderTextColor = UIColorPlaceholder;
//    textView.placeholderFont = textView.font;
//    textView.textAlignment = NSTextAlignmentRight;
    textView.layer.cornerRadius = 4.0;
    textView.backgroundColor = TableViewBackgroundColor;
    textView.clipsToBounds = YES;
    textView.model = model;
    textView.delegate = self;
    
//    @ggweakify(model)
//    [[RACObserve(textView, text) ignore:nil] subscribeNext:^(id  _Nullable x) {
//        @ggstrongify(model)
//        model.inputString = x;
//    }];
    
    return textView;
}

#pragma mark --- 输入框布局
- (UIView *)_layoutTextFieldUIWithSameTopView:(UIView *)sameTopView isLastSubView:(BOOL)isLastSubView model:(GGBaseInputMessageBaseModel *)model {
    QMUITextField *textField = [[QMUITextField alloc] init];
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sameTopView);
        if (isLastSubView) {
            // 最后一个
            make.height.mas_equalTo(GGBaseInputMessageViewContentViewDefaultHeight);
            make.bottom.equalTo(self).mas_equalTo(- GGBaseInputMessageViewDefaultSpaceV);
        } else {
            make.bottom.equalTo(sameTopView);
        }
        make.right.mas_equalTo(- GGBaseInputMessageViewSpace_H);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.6);
    }];
    textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    textField.textColor = UIColor.qd_titleTextColor;
    textField.placeholder = [NSString stringWithFormat:@"请输入%@", model.title];
    textField.textAlignment = NSTextAlignmentRight;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        [textField addBottomSepratorLineWithLeftSpace:0 rightSpace:0];
    textField.layer.cornerRadius = 4.0;
    textField.backgroundColor = TableViewBackgroundColor;
    textField.clipsToBounds = YES;
    @ggweakify(model)
    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @ggstrongify(model)
        model.inputString = x;
    }];
    
    switch (model.funcType) {
        case GGBaseInputMessageBaseModelFuncType_Input: {
            textField.maximumTextLength = 120;
        }
            break;
        case GGBaseInputMessageBaseModelFuncType_InputNumber: {
            textField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
        }
            break;
        default:
            break;
    }
    
    return textField;
}

#pragma mark --- 创建标题label
- (UIView *)_layoutTitleLabelUIWithSameTopView:(UIView *)sameTopView isLastSubView:(BOOL)isLastSubView model:(GGBaseInputMessageBaseModel *)model {
    CGFloat height = GGBaseInputMessageViewContentViewDefaultHeight;
    CGFloat space_V_default = GGBaseInputMessageViewDefaultSpaceV;
    CGFloat space_H = GGBaseInputMessageViewSpace_H;
    
    QMUILabel *titleLabel = [QMUILabel labelWithSuperView:self withContent:model.title withBackgroundColor:nil withTextColor:UIColor.qd_descriptionTextColor withFont:UIFontMake(14.f)];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (sameTopView != _lineView) {
            make.top.equalTo(sameTopView.mas_bottom).mas_equalTo(GGBaseInputMessageViewItemSpaceV);
        } else {
            make.top.equalTo(sameTopView.mas_bottom).mas_equalTo(space_V_default);
        }
        make.left.mas_equalTo(space_H);
        make.right.mas_equalTo(- space_H);
        make.height.mas_equalTo(height);
    }];
    
    return titleLabel;
}

@end

















@implementation UITextView (GGBaseInputMessageView)

- (void)setModel:(GGBaseInputMessageBaseModel *)model {
    objc_setAssociatedObject(self, @selector(model), model, OBJC_ASSOCIATION_RETAIN);
}

- (GGBaseInputMessageBaseModel *)model {
    return objc_getAssociatedObject(self, _cmd);
}

@end
