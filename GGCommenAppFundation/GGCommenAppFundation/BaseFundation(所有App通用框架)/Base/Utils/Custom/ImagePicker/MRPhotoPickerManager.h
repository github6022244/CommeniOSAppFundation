//
//  MRPhotoPickerManager.h
//  RKMedicineReach
//
//  Created by GG on 2020/10/27.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRPhotoPickerManagerShowType) {
    MRPhotoPickerManagerShowType_Clip,// 带裁剪框（一般可用做头像）
    MRPhotoPickerManagerShowType_Other, // 没有裁剪框
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^MRPhotoPickerManagerBlock)(id data, NSString *dataName);

@interface MRPhotoPickerManager : NSObject

+ (instancetype)share;

- (void)configController:(UIViewController *)controller;

/// 只选取图片
- (void)showWithPickerType:(MRPhotoPickerManagerShowType)type finishBlock:(MRPhotoPickerManagerBlock)block;

@end

NS_ASSUME_NONNULL_END
