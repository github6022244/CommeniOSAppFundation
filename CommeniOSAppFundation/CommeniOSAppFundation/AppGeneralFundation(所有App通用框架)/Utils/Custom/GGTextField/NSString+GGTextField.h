//
//  NSString+GGTextField.h
//  Seventeena
//
//  Created by WeiGuanghui on 2018/8/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GGTextField)

/**
 *  检查手机号格式是否正确
 */
+ (BOOL)gg_checkIsPhoneNumber:(NSString *)mobile;

/**
 *  检查身份证格式是否正确
 */
+ (BOOL)gg_checkIsIDCardNumber:(NSString *)IDNumber;

/**
 *  校验银行卡
 */
+ (BOOL)gg_IsBankCard:(NSString *)cardNumber;

/**
 *  检查密码格式是否正确
 *  正确返回 ture
 *  错误返回 错误信息
 */
+ (BOOL)gg_checkIsRightPassword:(NSString *)password;

/**
 是否包含表情符号判断
 */
+ (BOOL)gg_checkStringContainsEmoji:(NSString *)string;

@end
