//
//  NSString+GGTextField.m
//  Seventeena
//
//  Created by WeiGuanghui on 2018/8/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "NSString+GGTextField.h"

@implementation NSString (GGTextField)

+ (BOOL)gg_checkIsPhoneNumber:(NSString *)mobile
{
    if (mobile.length != 11)
    {
        return NO;
    }
    else
    {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+ (BOOL)gg_checkIsIDCardNumber:(NSString *)identityString
{
    if (identityString.length != 18) return NO;
        identityString = [identityString stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
        
        // 正则表达式判断基本 身份证号是否满足格式
        NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
      //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
        NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        //如果通过该验证，说明身份证格式正确，但准确性还需计算
        if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
        
        //** 开始进行校验 *//
        
        //将前17位加权因子保存在数组里
        NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++) {
            NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        //得到最后一位身份证号码
        NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2) {
            if(![idCardLast isEqualToString:@"X"] && ![idCardLast isEqualToString:@"x"]) {
                return NO;
            }
        }
        else{
//            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
//            if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
//                return NO;
//            }
        }
        return YES;
}

#pragma mark 检验银行卡号
+ (BOOL)gg_IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

#pragma mark 密码是否正确
+ (BOOL)gg_checkIsRightPassword:(NSString *)password
{
    if (password.length < 8 || password.length > 16)//密码位数在8~16之间
    {
        NSLog(@"密码长度小于8位或大于16位");
        return NO;
    }
    else
    {
        NSArray *number = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
        NSArray *word = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"];
        NSArray *word_capital = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
        NSInteger numberCount = 0;
        NSInteger wordCount = 0;
        NSInteger wordCapitalCount = 0;
        for (NSString *numberString in number)
        {
            if ([password rangeOfString:numberString].location != NSNotFound)//密码中有数字
            {
                numberCount++;
            }
        }
        for (NSString *wordString in word)
        {
            if ([password rangeOfString:wordString].location != NSNotFound)//密码中有字母
            {
                wordCount++;
            }
        }
        for (NSString *wordString in word_capital)
        {
            if ([password rangeOfString:wordString].location != NSNotFound)//密码中有字母
            {
                wordCapitalCount++;
            }
        }
        if (numberCount == 0) {
            NSLog(@"密码必须包含数字");
            return NO;
        }
        else if (wordCount == 0)
        {
            NSLog(@"密码必须包含小写字母");
            return NO;
        } else if (wordCapitalCount == 0) {
            NSLog(@"密码必须包含大写字母");
            return NO;
        } else {
            return YES;
        }
    }
}

#pragma mark - 表情符号判断
//表情符号的判断
+ (BOOL)gg_checkStringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
//    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
//                               options:NSStringEnumerationByComposedCharacterSequences
//                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
//                                const unichar hs = [substring characterAtIndex:0];
//                                if (0xd800 <= hs && hs <= 0xdbff) {
//                                    if (substring.length > 1) {
//                                        const unichar ls = [substring characterAtIndex:1];
//                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
//                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
//                                            returnValue = YES;
//                                        }
//                                    }
//                                } else if (substring.length > 1) {
//                                    const unichar ls = [substring characterAtIndex:1];
//                                    if (ls == 0x20e3) {
//                                        returnValue = YES;
//                                    }
//                                } else {
//                                    if (0x2100 <= hs && hs <= 0x27ff) {
//                                        returnValue = YES;
//                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
//                                        returnValue = YES;
//                                    } else if (0x2934 <= hs && hs <= 0x2935) {
//                                        returnValue = YES;
//                                    } else if (0x3297 <= hs && hs <= 0x3299) {
//                                        returnValue = YES;
//                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
//                                        returnValue = YES;
//                                    }
//                                }
//                            }];
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
    const unichar hs = [substring characterAtIndex:0];

    // surrogate pair

    if (0xd800 <= hs && hs <= 0xdbff) {
    if (substring.length > 1) {
    const unichar ls = [substring characterAtIndex:1];

    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;

    if (0x1d000 <= uc && uc <= 0x1f77f) {
    returnValue = YES;

    }

    }

    } else if (substring.length > 1) {
    const unichar ls = [substring characterAtIndex:1];

    if (ls == 0x20e3) {
    returnValue = YES;

    }

    } else {
    // non surrogate

    if (0x2100 <= hs && hs <= 0x27ff) {
    returnValue = YES;

    } else if (0x2B05 <= hs && hs <= 0x2b07) {
    returnValue = YES;

    } else if (0x2934 <= hs && hs <= 0x2935) {
    returnValue = YES;

    } else if (0x3297 <= hs && hs <= 0x3299) {
    returnValue = YES;

    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
    returnValue = YES;

    }

    }

    }];
    
    return returnValue;
}

@end
