//
//  NSString+Util.m
//  ZhongChou
//
//  Created by Jason on 14-1-2.
//  Copyright (c) 2014年 ZhongChou. All rights reserved.
//

#import "NSString+Util.h"
#import "NSString+GGTextField.h"

@implementation NSString (Util)


- (bool)isEmpty
{
    return self.length == 0;
}

- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)trim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (CGSize)suggestedSizeWithFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]) {
        size = [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,  nil]];
    } else {
#endif
        size = [self sizeWithFont:font];
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    }
#endif
    return size;
}

- (CGSize)suggestedSizeWithFont:(UIFont *)font size:(CGSize)size
{
    return [self suggestedSizeWithFont:font
                                 width:size.width];
}

- (CGSize)suggestedSizeWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = CGSizeZero;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        CGRect bounds = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesDeviceMetrics
                                        attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,  nil]
                                           context:nil];
        size = bounds.size;
    } else {
#endif
        size = [self sizeWithFont:font
                constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    }
#endif
    return size;
}

- (CGSize)getSizeWithLimitSize:(CGSize)size font:(UIFont *)font
{
    CGSize size_Return = CGSizeZero;
    if (self.length > 0) {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        size_Return = [self
                      boundingRectWithSize:size
                      options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{NSFontAttributeName:font}
                      context:nil].size;
#else
        
        size_Return = [stateString sizeWithFont:font
                              constrainedToSize:size
                                  lineBreakMode:NSLineBreakByCharWrapping];
#endif
    }
    return size_Return;
}

- (CGFloat)getStringHeightWithFont:(UIFont *)font limitWidth:(CGFloat)width {
    NSString *text = self.mutableCopy;
//    // 设置文字属性 要和label的一致
//    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
//
//    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
////    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
//
//    // 计算文字占据的宽高
//    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
//
//   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
//    return  ceilf(size.height);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
       paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
       paragraphStyle.alignment = NSTextAlignmentLeft;
       paragraphStyle.lineSpacing = 2;

   NSDictionary* attributes = @{NSFontAttributeName:font,
                                    NSParagraphStyleAttributeName: paragraphStyle,
                                    NSForegroundColorAttributeName: [UIColor blackColor]};
       
   CGRect rect = [text boundingRectWithSize:maxSize
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attributes
                                        context:nil];
    return ceilf(rect.size.height);
}

- (CGFloat)getStringWidthWithFont:(UIFont *)font limitHeight:(CGFloat)height {
    NSString *text = self;
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.width);
}

#pragma mark ---------------------------- 根据长度截取字符串 ----------------------------
- (NSString *)qmui_substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range lessValue:(BOOL)lessValue
{   
    return [self qmui_substringAvoidBreakingUpCharacterSequencesWithRange:range lessValue:lessValue countingNonASCIICharacterAsTwo:NO];
}

- (NSString *)qmui_substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range lessValue:(BOOL)lessValue countingNonASCIICharacterAsTwo:(BOOL)countingNonASCIICharacterAsTwo {
    range = countingNonASCIICharacterAsTwo ? [self transformRangeToDefaultModeWithRange:range] : range;
    NSRange characterSequencesRange = lessValue ? [self downRoundRangeOfComposedCharacterSequencesForRange:range] : [self rangeOfComposedCharacterSequencesForRange:range];
    NSString *resultString = [self substringWithRange:characterSequencesRange];
    return resultString;
}

- (NSRange)transformRangeToDefaultModeWithRange:(NSRange)range {
    CGFloat strlength = 0.f;
    NSRange resultRange = NSMakeRange(NSNotFound, 0);
    NSInteger i = 0;
    for (i = 0; i < self.length; i++) {
        unichar character = [self characterAtIndex:i];
        if (isascii(character)) {
            strlength += 1;
        } else {
            strlength += 2;
        }
        if (strlength >= range.location + 1) {
            if (resultRange.location == NSNotFound) {
                resultRange.location = i;
            }
            
            if (range.length > 0 && strlength >= NSMaxRange(range)) {
                resultRange.length = i - resultRange.location + (strlength == NSMaxRange(range) ? 1 : 0);
                return resultRange;
            }
        }
    }
    return resultRange;
}

- (NSRange)downRoundRangeOfComposedCharacterSequencesForRange:(NSRange)range {
    if (range.length == 0) {
        return range;
    }
    
    NSRange resultRange = [self rangeOfComposedCharacterSequencesForRange:range];
    if (NSMaxRange(resultRange) > NSMaxRange(range)) {
        return [self downRoundRangeOfComposedCharacterSequencesForRange:NSMakeRange(range.location, range.length - 1)];
    }
    return resultRange;
}

#pragma mark - 分转元
- (NSString *)fenFormatToYuan
{
    NSNumber *num = [NSNumber numberWithFloat:self.floatValue / 100];
    return num.stringValue;
}

#pragma mark - 元转分
- (NSString *)yuanFormantToFen
{
    NSNumber *num = [NSNumber numberWithFloat:self.floatValue * 100];
    return num.stringValue;
}

+ (instancetype)transformEmptyString:(NSString *)string
{
    if ([string isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)string;
        return number.stringValue;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if (!string.length) {
        return @"";
    }

    return string;
}

#pragma mark - 转换Int
+ (instancetype)stringWithIntegerValue:(NSInteger)intValue
{
    return [self stringWithFormat:@"%ld", (long)intValue];
}

#pragma mark - 将手机号转换为密文
+ (instancetype)encryptionStringWithPhoneNum:(NSString *)phoneNum
{
    if ([NSString gg_checkIsPhoneNumber:phoneNum]) {
        NSString *sub = [phoneNum substringWithRange:NSMakeRange(3, 4)];
        return [phoneNum stringByReplacingOccurrencesOfString:sub withString:@"*"];
    }
    return @"";
}

+ (NSString *)dateStringFormDateInterval:(NSTimeInterval)interval format:(NSString *)format {
    if (!interval) {
        return @"";
    }
    
    NSString *intervalStr = [NSString stringWithFormat:@"%ld", (long)interval];
    if (intervalStr.length == 13) {
        interval = interval / 1000;
    }
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:interval];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

    [formatter setDateFormat:format];

    NSString*timeString=[formatter stringFromDate:date];
    return timeString;
}

+ (NSString *)seperateNumberByComma:(NSNumber *)number {
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    moneyFormatter.positiveFormat = @"###,##0.00";
    NSString *formatString = [moneyFormatter stringFromNumber:number];
    
    return formatString;
}

+ (NSString *)format_yyyyMMddHHmmss:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *num = value;
        return [NSString dateStringFormDateInterval:num.integerValue format:@"yyyy-MM-dd HH:mm:ss"];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *str = value;
        return [NSString dateStringFormDateInterval:str.integerValue format:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return @"";
}

- (NSString *)format_yyyyMMddHHmmss {
    return [NSString dateStringFormDateInterval:self.integerValue format:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)format_yyyyMMdd {
    return [NSString dateStringFormDateInterval:self.integerValue format:@"yyyy-MM-dd"];
}

+ (NSString *)convertIDCardIntoCiphertext:(NSString *)idCard {
//    showIDCard.length > 15 ? [showIDCard stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"] : NSStringTransformEmpty(showIDCard),
    NSString *showIDCard = [NSString stringWithFormat:@"%@", idCard];
    
    if (showIDCard.length > 15) {
        return [showIDCard stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
    } else {
        return showIDCard;
    }
}

@end
