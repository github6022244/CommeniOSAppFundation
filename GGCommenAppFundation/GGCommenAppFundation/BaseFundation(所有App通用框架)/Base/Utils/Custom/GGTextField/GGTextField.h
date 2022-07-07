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

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame primaryAction:(UIAction *)primaryAction NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

@end
