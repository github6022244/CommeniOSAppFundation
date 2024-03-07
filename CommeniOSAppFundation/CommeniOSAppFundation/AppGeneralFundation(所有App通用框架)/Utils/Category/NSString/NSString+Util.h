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

#pragma mark --- 是否包含中文
- (BOOL)containCH;

#pragma mark --- 获取域名
- (NSString *)getRootDomain;

#pragma mark --- url是否包含参数
- (BOOL)checkUrlContainParams;

#pragma mark --- UTF8编码
- (NSString *)encodeByUTF8;

#pragma mark --- 密码校验
/// 可以包含数字、字母、下划线，并且要同时含有数字和字母，且长度要在6-15之间
- (BOOL)passwordVerification;

#pragma mark --- 只去掉字符串前后的空格
+ (NSString *)trimWhitespace:(NSString *)val;

//宽

+ (CGFloat)calculateWidthWithStr:(NSString *)string andFont:(UIFont *)font andHeight:(CGFloat)height;

//高

+ (CGFloat)calculateHeightWithStr:(NSString *)string andFont:(UIFont *)font andWidth:(CGFloat)width;

//富文本 高度
+ (CGFloat)calculateHeightWithStr:(NSAttributedString *)attrString andWidth:(CGFloat)width;

/// 转化为html 字符串
- (NSString *)adaptHtmlStringWithFontPX:(NSInteger)fontPX;

@end
