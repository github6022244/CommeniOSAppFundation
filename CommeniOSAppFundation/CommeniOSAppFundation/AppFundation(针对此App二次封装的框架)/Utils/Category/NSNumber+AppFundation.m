//
//  NSNumber+AppFundation.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/1.
//

#import "NSNumber+AppFundation.h"

@implementation NSNumber (AppFundation)

+ (NSString *)formatPriceString:(NSNumber *)number {
    return number ? [number formatPriceString] : @"0.00";
}

- (NSString *)formatPriceString {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setMaximumFractionDigits:4];
    [numberFormatter setMinimumIntegerDigits:1];
    NSString *string = [numberFormatter stringFromNumber:self];
    return string;
}

/// 数字转汉字
- (NSString *)transformHanString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    /// 拼写输出中文
    formatter.numberStyle = kCFNumberFormatterSpellOutStyle;
    /// 如果不设置locle 跟随系统语言
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *spellOutStr = [formatter stringFromNumber:self];
    
    return spellOutStr;
}

@end
