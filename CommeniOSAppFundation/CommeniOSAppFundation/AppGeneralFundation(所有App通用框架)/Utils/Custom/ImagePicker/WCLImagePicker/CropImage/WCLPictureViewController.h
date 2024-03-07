//
//  WCLPictureViewController.h
//  WCLPictureClippingRotation
//
//  Created by wcl on 2016/12/28.
//  Copyright © 2016年 QianTangTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCLPictureViewController;

@protocol WCLCutPictureDelegate <NSObject>

- (void)imageCropper:(WCLPictureViewController *)cropperViewController didFinished:(UIImage *)editedImage;
- (void)imageCropperDidCancel:(WCLPictureViewController *)cropperViewController;

@end

@interface WCLPictureViewController : UIViewController

@property (nonatomic, assign) id<WCLCutPictureDelegate> delegate;

@property (nonatomic, assign) BOOL enableRotation;// 是否允许旋转

/**
 *  图片裁剪界面初始化
 *
 *  @param originalImage 需要裁剪的图片
 *  @param cropFrame  裁剪框的size 目前裁剪框的宽度为屏幕宽度
 *
 *  @return <#return value description#>
 */

- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame;


@end
