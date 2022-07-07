//
//  UILabel+GG.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/2.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (GG)

//快速添加label
+ (instancetype)labelWithSuperView:(UIView *__nullable)view withContent:(NSString *__nullable)content withBackgroundColor:(UIColor *__nullable)bgcolor withTextColor:(UIColor *__nullable)textColor withFont:(UIFont *__nullable)font;

+ (instancetype)labelWithSuperView:(UIView *__nullable)view withContent:(NSString *__nullable)content withBackgroundColor:(UIColor *__nullable)bgcolor withTextColor:(UIColor *__nullable)textColor fontWithName:(NSString *__nullable)fontName withFontsize:(CGFloat)fontSize;

+ (instancetype)labelWithSuperView:(UIView *__nullable)view withContent:(NSString *__nullable)content withBackgroundColor:(UIColor *__nullable)bgcolor withTextColor:(UIColor *__nullable)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numOfLines:(NSUInteger)numOfLines;

@end

NS_ASSUME_NONNULL_END
