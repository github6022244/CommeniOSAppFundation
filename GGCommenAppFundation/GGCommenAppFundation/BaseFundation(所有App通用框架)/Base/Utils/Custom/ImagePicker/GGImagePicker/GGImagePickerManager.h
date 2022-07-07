//
//  GGImagePickerManager.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/25.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#import <QMUIKit.h>

typedef void(^GGImagePickerManagerDownBlock)(NSArray *selectedArray);

NS_ASSUME_NONNULL_BEGIN

@interface GGImagePickerManager : NSObject

@property (nonatomic, strong, readonly) QMUIAlbumViewController *albumViewController;
@property (nonatomic, assign) BOOL isMutiSelect;

- (void)showalbumViewConrtollerWithBlock:(GGImagePickerManagerDownBlock)block;

@end

NS_ASSUME_NONNULL_END
