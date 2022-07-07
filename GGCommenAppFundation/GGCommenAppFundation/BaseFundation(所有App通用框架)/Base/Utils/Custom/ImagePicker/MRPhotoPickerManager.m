//
//  MRPhotoPickerManager.m
//  RKMedicineReach
//
//  Created by GG on 2020/10/27.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "MRPhotoPickerManager.h"
#import "GGImagePickerManager.h"
#import "LDImagePicker.h"
#import "WMZPermission.h"
#import "WCLImagePicker.h"
#import <SDWebImage/UIImage+Metadata.h>
#import <YYKit.h>
#import <QMUITips.h>

typedef NS_ENUM(NSInteger, MRPhotoPickerManagerUploadWay) {
    MRPhotoPickerManagerUploadWay_AppServer, /// 向自己服务器上传
    MRPhotoPickerManagerUploadWay_OSS, /// 阿里OSS上传
};

@interface MRPhotoPickerManager ()<WCLImagePickerDelegate, LDImagePickerDelegate>

@property (nonatomic, weak) UIViewController *controller;

@property (nonatomic, copy) MRPhotoPickerManagerBlock block;

@property (nonatomic, strong) GGImagePickerManager *imagePickerManager;

@property (nonatomic, strong) WCLImagePicker *imagePicker;

@property (nonatomic, assign) MRPhotoPickerManagerShowType showType;

@property (nonatomic, assign) MRPhotoPickerManagerUploadWay uploadWay;

@end

@implementation MRPhotoPickerManager

#pragma mark ------------------------- Cycle -------------------------
+ (instancetype)share {
    static MRPhotoPickerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MRPhotoPickerManager alloc] init];
    });
    return manager;
}

#pragma mark ------------------------- Interface -------------------------
- (void)configController:(UIViewController *)controller {
    _controller = controller;
}

- (void)showWithPickerType:(MRPhotoPickerManagerShowType)type finishBlock:(MRPhotoPickerManagerBlock)block {
    _showType = type;
    _block = block;
    
    [self showChooseImageWay];
}

#pragma mark ------------------------- Private -------------------------
- (void)showChooseImageWay {
    dispatch_async(dispatch_get_main_queue(), ^{
        __weak typeof(self) weakSelf = self;
        [self showChooseSourcePickerWithBlock:^(NSInteger index) {
            switch (index) {
                case 0: {
                    // 相机
                    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        [QMUITips showError:@"相机不可用"];
                        return;
                    }
                    
                    [[WMZPermission shareInstance] permissonType:PermissionTypeCamera withHandle:^(BOOL granted, id data) {
                        if (granted) {
                            [weakSelf original_showCamara];
                        }
                    }];
                }
                    break;
                case 1: {
                    // 相册
                    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                        [QMUITips showError:@"相册不可用"];
                        return;
                    }
                    
                    [[WMZPermission shareInstance] permissonType:PermissionTypePhoto withHandle:^(BOOL granted, id data) {
                        if (granted) {
                            [weakSelf original_presentAlbumViewController];
                        }
                    }];
                }
                    break;
                default:
                    break;
            }
        }];
    });
}

- (void)original_showCamara {
    switch (_showType) {
        case MRPhotoPickerManagerShowType_Clip: {
            [self.imagePicker showImagePickerWithType:ImagePickerCamera InViewController:_controller heightCompareWidthScale:1.0 isCropImage:YES];
        }
            break;
        case MRPhotoPickerManagerShowType_Other: {
            LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
            imagePicker.delegate = self;
            [imagePicker showOriginalImagePickerWithType:LDImagePickerCamera InViewController:_controller];
        }
        default:
            break;
    }
}

- (void)original_presentAlbumViewController {
    switch (_showType) {
        case MRPhotoPickerManagerShowType_Clip: {
            [self.imagePicker showImagePickerWithType:ImagePickerPhoto InViewController:_controller heightCompareWidthScale:1.0 isCropImage:YES];
        }
            break;
        case MRPhotoPickerManagerShowType_Other: {
            __weak typeof(self) weakSelf = self;

            GGImagePickerManager *manager = [[GGImagePickerManager alloc] init];
        
            _imagePickerManager = manager;
        
            [manager showalbumViewConrtollerWithBlock:^(NSArray *selectedArray) {
        
                [weakSelf pv_callResponseBlockWithData:selectedArray];
        
            }];
        }
        default:
            break;
    }
}

- (void)showChooseSourcePickerWithBlock:(void(^)(NSInteger index))block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相机"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
        if (block) {
            block(0);
        }
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
        if (block) {
            block(1);
        }
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                      }]];

    [self.controller presentViewController:alertController
                       animated:YES
                     completion:^{
                     }];
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark --- LDImagePickerDelegate
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
//    if (_ossType == AliyunOSSManagerUploadType_AVATAR_DIR) {
//        // 头像裁剪
//        CGFloat width = editedImage.size.width > editedImage.size.height ? editedImage.size.width : editedImage.size.height;
//        editedImage = [editedImage qmui_imageResizedInLimitedSize:CGSizeMake(width, width) resizingMode:QMUIImageResizingModeScaleAspectFill];
//        editedImage = [editedImage qmui_imageWithClippedCornerRadius:width];
//    }

    [self pv_callResponseBlockWithData:editedImage];
}

- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker {
    
}

#pragma mark --- WCLImagePickerDelegate
- (void)wcl_imagePicker:(WCLImagePicker *)imagePicker didFinished:(UIImage *)editedImage {
    [self pv_callResponseBlockWithData:editedImage];
}

- (void)wcl_imagePickerDidCancel:(WCLImagePicker *)imagePicker {
    
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 响应回调block
- (void)pv_callResponseBlockWithData:(id)data {
    if (_block) {
        _block(data, nil);
    }
}

#pragma mark --- 判断选取的图片是否符合标准
- (BOOL)jugeImageType:(UIImage *)image {
////    格式要求JPG、JPEG、PNG格式
//    NSData *data = UIImageJPEGRepresentation(image, 0.7);
//    if (data == nil){
//       data = UIImagePNGRepresentation(image);
//    }
//
//    YYImage *yyImage = [YYImage imageWithData:data];
//    return yyImage.animatedImageType == YYImageTypePNG || yyImage.animatedImageType == YYImageTypeJPEG || yyImage.animatedImageType == YYImageTypeJPEG2000;
    return image.sd_imageFormat == SDImageFormatPNG || image.sd_imageFormat == SDImageFormatJPEG || image.sd_imageFormat == SDImageFormatUndefined;
}

#pragma mark ------------------------- set / get -------------------------
- (WCLImagePicker *)imagePicker {
    if (!_imagePicker) {
        WCLImagePicker *imagePicker = [WCLImagePicker sharedInstance];
        imagePicker.delegate = self;
        _imagePicker = imagePicker;
    }
    return _imagePicker;
}

@end
