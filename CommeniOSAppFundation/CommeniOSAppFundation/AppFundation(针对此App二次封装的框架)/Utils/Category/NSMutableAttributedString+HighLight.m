//
//  NSMutableAttributedString+HighLight.m
//  CXGrainStudentApp
//
//  Created by User on 2020/7/28.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import "NSMutableAttributedString+HighLight.h"

@implementation NSMutableAttributedString (HighLight)

+ (NSMutableAttributedString *)stringWithHighLightSubstring:(NSString *)totalString substring:(NSString *)substring {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSString *copyTotalString = totalString;
    NSMutableString *replaceString = [NSMutableString stringWithString:@""];
    for (int i = 0; i < substring.length; i++) {
        [replaceString appendString:@" "];
    }
    while ([copyTotalString rangeOfString:substring].location != NSNotFound) {
        NSRange range = [copyTotalString rangeOfString:substring options:NSLiteralSearch range:NSMakeRange(0, copyTotalString.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
        copyTotalString = [copyTotalString stringByReplacingCharactersInRange:range withString:replaceString];
    }
    return attributedString;
}

+ (NSMutableAttributedString *)stringWithHighLightSubstring:(NSString *)totalString substring:(NSString *)substring hightColor:(UIColor *)hightColor {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSString *copyTotalString = totalString;
    NSMutableString *replaceString = [NSMutableString stringWithString:@""];
    for (int i = 0; i < substring.length; i++) {
        [replaceString appendString:@" "];
    }
    while ([copyTotalString rangeOfString:substring].location != NSNotFound) {
        NSRange range = [copyTotalString rangeOfString:substring options:NSLiteralSearch range:NSMakeRange(0, copyTotalString.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:hightColor range:range];
        copyTotalString = [copyTotalString stringByReplacingCharactersInRange:range withString:replaceString];
    }
    return attributedString;
}

@end
