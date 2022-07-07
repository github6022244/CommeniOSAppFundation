//
//  GGAppManager.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/2.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGAppManager : NSObject

@property (class, nonatomic, assign) BOOL logAble;// 调试模式下是否允许打印

+ (instancetype)sharedInstance;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end










typedef NS_ENUM(NSInteger, GGAppManagerClearMemoryType) {
    GGAppManagerClearMemoryTypeAll,
    GGAppManagerClearMemoryTypeImage,
    GGAppManagerClearMemoryTypeYTKNetWork,
};

@interface GGAppManager (Helper)<SKStoreProductViewControllerDelegate>

@property (nonatomic, weak) UIViewController *presentAppStoreInAppController;

+ (UIImage *)getAppIcon;

+ (BOOL)isFirstLaunch;
+ (void)updateFirstLaunch;

+ (NSString *)appName;
+ (NSString *)appVersion;
+ (NSString *)appBuild;
+ (NSString *)phoneName;//手机别名： 用户定义的名称
+ (NSString *)deviceName;
+ (NSString *)systemVersion;
+ (NSString *)deviceModel;
+ (NSString *)localPhoneModel;

+ (void)jumpToAppStoreWithLink:(NSString *)link;

+ (void)jumpAppStoreInAppWithITunesItemIdentifier:(NSString *)iTunesItemIdentifier controller:(UIViewController *)controller;

+ (void)call:(NSString *)phoneNumber;

@end












@interface GGAppManager (CachesFunctions)

+ (void)clearMemoryWithType:(GGAppManagerClearMemoryType)type complateBlock:(void(^)(void))block;

+ (NSString *)getCacheSizeWithType:(GGAppManagerClearMemoryType)type;

@end

NS_ASSUME_NONNULL_END
