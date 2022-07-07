//
//  WCLImagePicker.h
//  WCLPictureClippingRotation
//
//  Created by wcl on 2016/12/28.
//  Copyright © 2016年 QianTangTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum ImagePickerType
{
    ImagePickerCamera = 0,
    ImagePickerPhoto = 1
}ImagePickerType;

@class WCLImagePicker;
@protocol WCLImagePickerDelegate <NSObject>

- (void)wcl_imagePicker:(WCLImagePicker *)imagePicker didFinished:(UIImage *)editedImage;

@optional
//取消选择图片
- (void)wcl_imagePickerDidCancel:(WCLImagePicker *)imagePicker;

@end

@interface WCLImagePicker : NSObject

+ (instancetype) sharedInstance;

//scale 裁剪框的高宽比 0~1.5 默认为1  isCropImage 是否对图片进行裁剪
- (void)showImagePickerWithType:(NSInteger)type InViewController:(UIViewController *)viewController heightCompareWidthScale:(double)scale isCropImage:(BOOL)isCrop;

//代理
@property (nonatomic, assign) id<WCLImagePickerDelegate> delegate;


@end
