//
//  UIImage+GG.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/28.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "UIImage+GG.h"

@implementation UIImage (GG)

/// base64字符串转图片
/// @param base64String 图片base64字符串
+ (UIImage *)imageWithBase64String:(NSString *)base64String {
     NSURL *URL = [NSURL URLWithString:base64String];
     NSData *imageData = [NSData dataWithContentsOfURL:URL];
     UIImage *image = [UIImage imageWithData:imageData];
     return image;
}

#pragma mark - 生成条形码以及二维码
+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

//// 创建一张渐变色图片
//+ (UIImage *)createImageSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GGUIImageGradientType)gradientType {
//
//    NSAssert(percents.count <= 5, @"输入颜色数量过多，如果需求数量过大，请修改locations[]数组的个数");
//
//    NSMutableArray *ar = [NSMutableArray array];
//    for(UIColor *c in colors) {
//        [ar addObject:(id)c.CGColor];
//    }
//
//    //    NSUInteger capacity = percents.count;
//    //    CGFloat locations[capacity];
//    CGFloat locations[5];
//    for (int i = 0; i < percents.count; i++) {
//        locations[i] = [percents[i] floatValue];
//    }
//
//    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, locations);
//    CGPoint start;
//    CGPoint end;
////    GGUIImageGradientFromTopToBottom,
////    GGUIImageGradientFromLeftToRight,
////    GGUIImageGradientFromLeftTopToRightBottom,
////    GGUIImageGradientFromLeftBottomToRightTop,
//    switch (gradientType) {
//        case GGUIImageGradientFromTopToBottom:
//            start = CGPointMake(imageSize.width/2, 0.0);
//            end = CGPointMake(imageSize.width/2, imageSize.height);
//            break;
//        case GGUIImageGradientFromLeftToRight:
//            start = CGPointMake(0.0, imageSize.height/2);
//            end = CGPointMake(imageSize.width, imageSize.height/2);
//            break;
//        case GGUIImageGradientFromLeftTopToRightBottom:
//            start = CGPointMake(0.0, 0.0);
//            end = CGPointMake(imageSize.width, imageSize.height);
//            break;
//        case GGUIImageGradientFromLeftBottomToRightTop:
//            start = CGPointMake(0.0, imageSize.height);
//            end = CGPointMake(imageSize.width, 0.0);
//            break;
//        default:
//            break;
//    }
//    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    CGGradientRelease(gradient);
//    CGContextRestoreGState(context);
//    CGColorSpaceRelease(colorSpace);
//    UIGraphicsEndImageContext();
//    return image;
//}

+ (UIImage *)getGradientImageFromColors:(NSArray*)colors gradientType:(GGUIImageGradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
//    topToBottom = 0,//从上到下
//    leftToRight = 1,//从左到右
//    upleftTolowRight = 2,//左上到右下
//    uprightTolowLeft = 3,//右上到左下
    switch (gradientType) {
        case GGUIImageGradientFromTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GGUIImageGradientFromLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

// 创建一张模糊效果图片
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 压缩质量
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

@end
