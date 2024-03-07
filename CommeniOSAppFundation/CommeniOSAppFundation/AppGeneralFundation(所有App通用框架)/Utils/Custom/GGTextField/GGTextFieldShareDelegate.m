//
//  GGTextFieldShareDelegate.m
//  RKZhiChengYun
//
//  Created by GG on 2021/3/9.
//

#import "GGTextFieldShareDelegate.h"

@interface GGTextFieldShareDelegate ()

@property (nonatomic, strong) NSArray *priceJugeArray;/**< 价格输入框可输入的文字数组 */
@property (nonatomic, strong) NSArray *idCardJugeArray;/**< 身份证号合法输入文字数组 */
@property (nonatomic, strong) NSArray *phoneJugeArray;/**< 手机号可输入文字数组 */
@property (nonatomic, strong) NSArray *bankCardJugeArray;/**< 银行卡号可输入文字数组 */
@property (nonatomic, strong) NSArray *volatileStringArray;/**< 非法字符数组 */

@property (nonatomic, weak) UITextField *textField;

@end

@implementation GGTextFieldShareDelegate

//+ (instancetype)share {
//    static GGTextFieldShareDelegate *sd = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sd = [[GGTextFieldShareDelegate alloc] init];
//    });
//    
//    return sd;
//}

- (void)handleDelegateForTextField:(UITextField *)textField {
    self.textField = textField;
}

#pragma mark ---------------------------- Delegate ----------------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /**< 输入的delete */
    if (!string.length) {
        return YES;
    }
    
    /**< 最大字符长度判断 */
    if (([NSString stringWithFormat:@"%@%@", textField.text, string].length > self.maxCountLimit) && self.maxCountLimit) {
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
#pragma mark - priceJugeArray
- (NSArray *)priceJugeArray
{
    if (!_priceJugeArray) {
        _priceJugeArray = @[@"1", @"2", @"3", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"."];
    }
    return _priceJugeArray;
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

@end
