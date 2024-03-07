//
//  NSMutableAttributedString+HighLight.h
//  CXGrainStudentApp
//
//  Created by User on 2020/7/28.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (HighLight)

+ (NSMutableAttributedString *)stringWithHighLightSubstring:(NSString *)totalString substring:(NSString *)substring;

+ (NSMutableAttributedString *)stringWithHighLightSubstring:(NSString *)totalString substring:(NSString *)substring hightColor:(UIColor *)hightColor;
@end

NS_ASSUME_NONNULL_END
