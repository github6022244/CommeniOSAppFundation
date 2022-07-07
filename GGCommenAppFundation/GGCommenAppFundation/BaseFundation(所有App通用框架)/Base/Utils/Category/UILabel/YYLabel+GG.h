//
//  YYLabel+GG.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/7.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <YYKit/YYKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYLabel (GG)

- (void)addTailWithText:(NSString *)oriText addPoint:(BOOL)addPoint color:(UIColor *)color font:(UIFont *)font clickBlock:(YYTextAction)clickBlock;

/**
 *  获取lb的size
 */
+ (CGSize)getMessageSizeWithMess:(NSString *)mess lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
