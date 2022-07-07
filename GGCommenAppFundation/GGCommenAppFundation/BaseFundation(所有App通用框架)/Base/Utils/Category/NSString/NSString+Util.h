//
//  NSString+Util.h
//  ZhongChou
//
//  Created by Jason on 14-1-2.
//  Copyright (c) 2014年 ZhongChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Util)
- (bool)isEmpty;
- (BOOL)isPureInt;
- (NSString *)trim;
- (CGSize)suggestedSizeWithFont:(UIFont *)font;
- (CGSize)suggestedSizeWithFont:(UIFont *)font width:(CGFloat)width;
- (CGSize)suggestedSizeWithFont:(UIFont *)font size:(CGSize)size;
- (CGSize)getSizeWithLimitSize:(CGSize)size font:(UIFont *)font;

- (CGFloat)getStringHeightWithFont:(UIFont *)font limitWidth:(CGFloat)width;
- (CGFloat)getStringWidthWithFont:(UIFont *)font limitHeight:(CGFloat)height;

- (NSString *)qmui_substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range lessValue:(BOOL)lessValue;

/**
 分转元
 */
- (NSString *)fenFormatToYuan;

#pragma mark - 元转分
- (NSString *)yuanFormantToFen;

#pragma mark - 转换空字符串
+ (instancetype)transformEmptyString:(NSString *)string;

#pragma mark - 转换Int
+ (instancetype)stringWithIntegerValue:(NSInteger)intValue;

#pragma mark - 将手机号转换为密文
+ (instancetype)encryptionStringWithPhoneNum:(NSString *)phoneNum;

+ (NSString *)dateStringFormDateInterval:(NSTimeInterval)interval format:(NSString *)format;

+ (NSString *)seperateNumberByComma:(NSNumber *)number;

+ (NSString *)format_yyyyMMddHHmmss:(id)value;

- (NSString *)format_yyyyMMddHHmmss;

- (NSString *)format_yyyyMMdd;

+ (NSString *)convertIDCardIntoCiphertext:(NSString *)idCard;

@end
