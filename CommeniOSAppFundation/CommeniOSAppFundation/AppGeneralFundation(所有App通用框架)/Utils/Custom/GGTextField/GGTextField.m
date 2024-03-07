//
//  GGTextField.m
//  Seventeena
//
//  Created by WeiGuanghui on 2018/8/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "GGTextField.h"

@interface GGTextField ()<UITextFieldDelegate>
@property(nonatomic, weak) id <UITextFieldDelegate> delegateProxy;
@property (nonatomic, strong) NSArray *priceJugeArray;/**< 价格输入框可输入的文字数组 */
@property (nonatomic, strong) NSArray *idCardJugeArray;/**< 身份证号合法输入文字数组 */
@property (nonatomic, strong) NSArray *phoneJugeArray;/**< 手机号可输入文字数组 */
@property (nonatomic, strong) NSArray *bankCardJugeArray;/**< 银行卡号可输入文字数组 */
@property (nonatomic, strong) NSArray *volatileStringArray;/**< 非法字符数组 */
@end

@implementation GGTextField

#pragma mark ---------------------------- Cycle ----------------------------
- (instancetype)init
{
    if (self = [super init]) {
        if (!self.delegate) {
            self.delegate = self;
            self.maxCountLimit = NSUIntegerMax;
            _placeholderTextColor = UIColorPlaceholder;
            _enablePaste = YES;
            _enableSelect = YES;
            _enableSelectAll = YES;
            _enableEdit = YES;
        }
        
        [self addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
}

#pragma mark ------------------------- UI -------------------------
- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds = CGRectInsetEdges(bounds, self.textInsets);
    CGRect resultRect = [super textRectForBounds:bounds];
    return resultRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds = CGRectInsetEdges(bounds, self.textInsets);
    return [super editingRectForBounds:bounds];
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect result = [super clearButtonRectForBounds:bounds];
    result = CGRectOffset(result, self.clearButtonPositionAdjustment.horizontal, self.clearButtonPositionAdjustment.vertical);
    return result;
}

#pragma mark ---------------------------- Delegate ----------------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /**< 输入的delete */
    if (!string.length) {
        return YES;
    }
    
    /**< 最大字符长度判断 */
    if ([NSString stringWithFormat:@"%@%@", textField.text, string].length > self.maxCountLimit) {
        return NO;
    }
    
    /**< 输入空格、非法字符、emoji */
    if (_ggType != GGTextFieldType_None) {
        if ([string isEqualToString:@" "] || [self.volatileStringArray containsObject:string] || [NSString gg_checkStringContainsEmoji:string]) {
            return NO;
        }
    }
    
    switch (_ggType) {
        case GGTextFieldType_Money:
        {
            /**< 价格 */
            if ([self.priceJugeArray containsObject:string]) {
                if ([string isEqualToString:@"0"]) {
                    return [self juge_0];
                }else if ([string isEqualToString:@"."])
                {
                    return [self juge_Point];
                }
            }
            
            return NO;
        }
            break;
        case GGTextFieldType_Phone:
        {
            /**< 手机号 */
            return [self juge_phoneWithNewString:string];
        }
            break;
        case GGTextFieldType_IDCard:
        {
            /**< 身份证号 */
            return [self juge_IDCardWithNewString:string];
        }
            break;
        case GGTextFieldType_Password:
            /**< 密码 */
            break;
        case GGTextFieldType_None:
            /**< 无 */
            return YES;
        case GGTextFieldType_BankCard:
        {
            /**< 银行卡 */
            return [self juge_BankCardWithNewString:string];
        }
            break;
    }
    
    return YES;
}

#pragma mark - 文字改变
- (void)textFieldChanged
{
    if (self.textChangeBlock) {
        self.textChangeBlock(self.text);
    }
    
    if ([self.delegateProxy respondsToSelector:@selector(textFieldDidChangeText:)]) {
        [self.delegateProxy performSelector:@selector(textFieldDidChangeText:) withObject:self.text];
    }
    
    NSString *text = self.text;
    switch (_ggType) {
        case GGTextFieldType_None:
            /**< 无 */
        case GGTextFieldType_Money:
            /**< 价格 */
            _jugeReslut = YES;
            break;
        case GGTextFieldType_Phone:
            /**< 手机号 */
            _jugeReslut = [NSString gg_checkIsPhoneNumber:text];
            break;
        case GGTextFieldType_IDCard:
            /**< 身份证号 */
            _jugeReslut = [NSString gg_checkIsIDCardNumber:text];
            break;
        case GGTextFieldType_Password:
            /**< 密码 */
            _jugeReslut = [NSString gg_checkIsRightPassword:text];
            break;
        case GGTextFieldType_BankCard:
            /**< 银行卡号 */
            _jugeReslut = [NSString gg_IsBankCard:text];
            break;
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))//禁止粘贴
        return _enablePaste;
    if (action == @selector(select:))// 禁止选择
        return _enableSelect;
    if (action == @selector(selectAll:))// 禁止全选
        return _enableSelectAll;
    return [super canPerformAction:action withSender:sender];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return _enableEdit;
}

#pragma mark ---------------------------- PrivateMethod ----------------------------
#pragma mark - 输入"0"
- (BOOL)juge_0
{
    if ([self.text isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}

#pragma mark - 输入"."
- (BOOL)juge_Point
{
    if (self.text.length == 0) {
        self.text = @"0.";
        return NO;
    }
    return ![self.text containsString:@"."];
}

#pragma mark - 判断手机号
- (BOOL)juge_phoneWithNewString:(NSString *)string
{
    NSString *currentText = self.text;
    NSString *totalText = [NSString stringWithFormat:@"%@%@", currentText, string];
    
    BOOL countJuge = totalText.length <= 11;
    
    BOOL contentJuge = [self.phoneJugeArray containsObject:string];
    
    return countJuge && contentJuge;
}

#pragma mark - 判断身份证号
- (BOOL)juge_IDCardWithNewString:(NSString *)string
{
    NSString *currentText = self.text;
    NSString *totalText = [NSString stringWithFormat:@"%@%@", currentText, string];
    
//    BOOL countJuge = totalText.length <= 18;
    BOOL countJuge = YES;
    
    BOOL contentJuge = [self.idCardJugeArray containsObject:string];
    
    return countJuge && contentJuge;
}

#pragma mark - 判断银行卡号
- (BOOL)juge_BankCardWithNewString:(NSString *)string
{
    return [self.bankCardJugeArray containsObject:string];
}

#pragma mark ---------------------------- set / get ----------------------------
#pragma mark - delegate
- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    self.delegateProxy = delegate != self ? delegate : nil;
    [super setDelegate:delegate ? self : nil];
}

#pragma mark - text
- (void)setText:(NSString *)text
{
//    if ([self textField:self shouldChangeCharactersInRange:NSMakeRange(0, text.length) replacementString:text]) {
        [super setText:text];
        [self textFieldChanged];
//    }
    
    if (_placeholderTextColor) {
        self.placeholderTextColor = _placeholderTextColor;
    }
}

#pragma mark - priceJugeArray
- (NSArray *)priceJugeArray
{
    if (!_priceJugeArray) {
        _priceJugeArray = @[@"1", @"2", @"3", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"."];
    }
    return _priceJugeArray;
}

#pragma mark - ggType
- (void)setGgType:(GGTextFieldType)ggType
{
    _ggType = ggType;
    
    switch (_ggType) {
        case GGTextFieldType_Money: {
            /**< 价格 */
            self.keyboardType = UIKeyboardTypeDecimalPad;
            self.secureTextEntry = NO;
        }
            break;
        case GGTextFieldType_BankCard: {}
            /**< 银行卡 */
        case GGTextFieldType_Phone: {
            /**< 手机号 */
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.secureTextEntry = NO;
        }
            break;
        case GGTextFieldType_Password: {
            /**< 密码 */
            self.secureTextEntry = YES;
            self.keyboardType = UIKeyboardTypeDefault;
        }
            break;
        case GGTextFieldType_IDCard: {}
            /**< 身份证号 */
        case GGTextFieldType_None: {
            /**< 无 */
            self.secureTextEntry = NO;
            self.keyboardType = UIKeyboardTypeDefault;
        }
            break;
    }
}

#pragma mark - idCardJugeArray
- (NSArray *)idCardJugeArray
{
    if (!_idCardJugeArray) {
        _idCardJugeArray = [NSArray arrayWithObjects:@"1", @"0", @"x", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    }
    return _idCardJugeArray;
}

#pragma mark - phoneJugeArray
- (NSArray *)phoneJugeArray
{
    if (!_phoneJugeArray) {
        _phoneJugeArray = @[@"1", @"2", @"3", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0"];
    }
    return _phoneJugeArray;
}

#pragma mark - bankCardJugeArray
- (NSArray *)bankCardJugeArray
{
    if (!_bankCardJugeArray) {
        _bankCardJugeArray = @[@"1", @"2", @"3", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0"];
    }
    return _bankCardJugeArray;
}

#pragma mark - volatileStringArray
- (NSArray *)volatileStringArray
{
    if (!_volatileStringArray) {
        NSString * string = @"~,￥,#,&,*,<,>,《,》,(,),[,],{,},【,】,^,@,/,￡,¤,,|,§,¨,「,」,『,』,￠,￢,￣,（,）,——,+,|,$,_,€,¥";
        _volatileStringArray = [string componentsSeparatedByString:@","];
    }
    return _volatileStringArray;
}

#pragma mark - placeholdercolor
- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placeholderTextColor = placeholderTextColor;
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: self.placeholderTextColor}];
}

@end
