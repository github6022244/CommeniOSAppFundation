//
//  GGTextField.h
//  Seventeena
//
//  Created by WeiGuanghui on 2018/8/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+GGTextField.h"

typedef NS_ENUM(NSInteger, GGTextFieldType) {
    GGTextFieldType_None, /**< 默认 */
    GGTextFieldType_Money, /**< 价格 */
    GGTextFieldType_Phone, /**< 手机号 */
    GGTextFieldType_IDCard, /**< 身份证号 */
    GGTextFieldType_Password, /**< 密码 */
    GGTextFieldType_BankCard, /**< 银行卡 */
};

@protocol GGTextFieldDelegate <UITextFieldDelegate>
/**
 输入框文字改变时回调
 */
- (void)textFieldDidChangeText:(NSString *)text;
@end

@interface GGTextField : UITextField

@property (nonatomic, copy) void(^textChangeBlock)(NSString *text);

@property (nonatomic, assign) GGTextFieldType ggType;/**< 类型 */

@property (nonatomic, assign) BOOL jugeReslut;/**< 格式判断，可在文字改变回调里拿 */

@property (nonatomic, assign) NSInteger maxCountLimit;/**< 最大数量 */

@property (nonatomic, strong) UIColor *placeholderTextColor;

/// 是否允许复制
@property (nonatomic, assign) BOOL enablePaste;

/// 是否允许选择
@property (nonatomic, assign) BOOL enableSelect;

/// 是否允许全选
@property (nonatomic, assign) BOOL enableSelectAll;

/// 禁止编辑
@property (nonatomic, assign) BOOL enableEdit;

/**
 *  文字在输入框内的 padding。如果出现 clearButton，则 textInsets.right 会控制 clearButton 的右边距
 *
 *  默认为 TextFieldTextInsets
 */
@property(nonatomic, assign) UIEdgeInsets textInsets;

/**
 clearButton 在默认位置上的偏移
 */
@property(nonatomic, assign) UIOffset clearButtonPositionAdjustment UI_APPEARANCE_SELECTOR;

@end
