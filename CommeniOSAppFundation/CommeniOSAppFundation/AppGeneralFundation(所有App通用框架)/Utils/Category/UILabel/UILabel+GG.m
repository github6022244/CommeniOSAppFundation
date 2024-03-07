//
//  UILabel+GG.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/2.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UILabel+GG.h"

@implementation UILabel (GG)

+ (instancetype)labelWithSuperView:(UIView *)view withContent:(NSString *)content withBackgroundColor:(UIColor *)bgcolor withTextColor:(UIColor *)textColor fontWithName:(NSString *)fontName withFontsize:(CGFloat)fontSize {
    UIFont *font = nil;
    if (fontName) {
        font = [UIFont fontWithName:fontName size:fontSize];
    } else if (fontSize) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    return [self labelWithSuperView:view withContent:content withBackgroundColor:bgcolor withTextColor:textColor font:font textAlignment:NSTextAlignmentLeft numOfLines:1];
}

+ (instancetype)labelWithSuperView:(UIView *)view withContent:(NSString *)content withBackgroundColor:(UIColor *)bgcolor withTextColor:(UIColor *)textColor withFont:(UIFont *)font {
    return [self labelWithSuperView:view withContent:content withBackgroundColor:bgcolor withTextColor:textColor font:font textAlignment:NSTextAlignmentLeft numOfLines:1];
}

+ (instancetype)labelWithSuperView:(UIView *__nullable)view withContent:(NSString *__nullable)content withBackgroundColor:(UIColor *__nullable)bgcolor withTextColor:(UIColor *__nullable)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numOfLines:(NSUInteger)numOfLines {
    if (content == nil || (NSNull *)content == [NSNull null]) {
        content = @"";
    }
    
    UILabel *lb = [[[self class] alloc] init];
    
    lb.text = content;
    
    if (bgcolor != nil) {
        lb.backgroundColor = bgcolor;
    }
    
    if (font) {
        lb.font = font;
    }
    
    lb.textColor = textColor == nil ? [UIColor blackColor] : textColor;
    
    lb.textAlignment = textAlignment;
    
    lb.numberOfLines = numOfLines;
    
    if (view) {
        [view addSubview:lb];
    }
    
    return lb;
}

@end
