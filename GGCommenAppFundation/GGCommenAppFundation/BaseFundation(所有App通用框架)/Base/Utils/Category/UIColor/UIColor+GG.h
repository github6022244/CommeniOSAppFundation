//
//  UIColor+GG.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/2.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GG)

+ (UIColor *)colorWithHexString: (NSString *)color;

+ (NSInteger)colorToHex:(UIColor*)color;

+ (UIColor*)hexToColor:(NSInteger)hex;

@end

NS_ASSUME_NONNULL_END
