//
//  UIImage+GG.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/28.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GGUIImageGradientType) {
    GGUIImageGradientFromTopToBottom,
    GGUIImageGradientFromLeftToRight,
//    GGUIImageGradientFromLeftTopToRightBottom,
//    GGUIImageGradientFromLeftBottomToRightTop,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GG)

/// base64字符串转图片
/// @param base64String 图片base64字符串
+ (UIImage *)imageWithBase64String:(NSString *)base64String;

#pragma mark - 生成条形码以及二维码
+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

// 创建一张渐变色图片
//+ (UIImage *)createImageSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GGUIImageGradientType)gradientType;
+ (UIImage *)getGradientImageFromColors:(NSArray*)colors gradientType:(GGUIImageGradientType)gradientType imgSize:(CGSize)imgSize;

// 创建一张模糊效果图片
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size;

/// 压缩质量
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
