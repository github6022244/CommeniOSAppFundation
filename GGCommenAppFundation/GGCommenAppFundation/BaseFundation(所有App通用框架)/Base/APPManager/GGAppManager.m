//
//  GGAppManager.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/2.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "GGAppManager.h"
#import <objc/runtime.h>
#import <SDWebImage.h>
#import <YTKNetwork.h>
#import <QMUIKit.h>
#import <GGNetWorkManager.h>

static BOOL kGGAppManagerLogAble = NO;

@implementation GGAppManager

#pragma mark ------------------------- Cycle -------------------------
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static GGAppManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

#pragma mark ------------------------- set / get -------------------------
+ (void)setLogAble:(BOOL)logAble {
    kGGAppManagerLogAble = logAble;
}

+ (BOOL)logAble {
    return kGGAppManagerLogAble;
}

@end















@implementation GGAppManager (Helper)

+ (UIImage *)getAppIcon {
    
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];

    return [UIImage imageNamed:icon];
}

+ (BOOL)isFirstLaunch {
    NSString *is = [[NSUserDefaults standardUserDefaults] valueForKey:@"isFirstLaunch"];
    
    return !is.length;
}

+ (void)updateFirstLaunch {
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)appName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}
+ (NSString *)appVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
+ (NSString *)appBuild {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_build;
}
//手机别名： 用户定义的名称
+ (NSString *)phoneName {
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    return userPhoneName;
}
+ (NSString *)deviceName {
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}
+ (NSString *)systemVersion {
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}
+ (NSString *)deviceModel {
    NSString* phoneModel = [[UIDevice currentDevice] model];
    return phoneModel;
}
+ (NSString *)localPhoneModel {
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    return localPhoneModel;
}


+ (void)jumpToAppStoreWithLink:(NSString *)link {
    NSURL *url = [NSURL URLWithString:link];
    if (@available(iOS 10.0, *)){
         [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:^(BOOL success) {
             if (success) {
                 NSLog(@"10以后可以跳转url");
             }else{
                 NSLog(@"10以后不可以跳转url");
             }
         }];
     } else {
         BOOL success = [[UIApplication sharedApplication] openURL:url];
         if (success) {
              NSLog(@"10以前可以跳转url");
         }else{
              NSLog(@"10以前不可以跳转url");
         }
     }
 }

+ (void)jumpAppStoreInAppWithITunesItemIdentifier:(NSString *)iTunesItemIdentifier controller:(UIViewController *)controller {
    //2:实现代理SKStoreProductViewControllerDelegate
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    storeProductViewContorller.delegate = [GGAppManager sharedInstance];
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters: @{SKStoreProductParameterITunesItemIdentifier : iTunesItemIdentifier} completionBlock:^(BOOL result, NSError *error) {
        //回调
        if(error){
             NSLog(@"错误%@",error);
        }else{
            //应用界面
            [GGAppManager sharedInstance].presentAppStoreInAppController = controller;
            [controller presentViewController:storeProductViewContorller animated:YES completion:nil];
        }
    }];
}

+ (void)call:(NSString *)phoneNumber {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNumber];
    NSURL *url = [NSURL URLWithString:str];

    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------------------------- set / get -------------------------
- (void)setPresentAppStoreInAppController:(UIViewController *)presentAppStoreInAppController {
    objc_setAssociatedObject(self, @selector(presentAppStoreInAppController), presentAppStoreInAppController, OBJC_ASSOCIATION_RETAIN);
}

- (UIViewController *)presentAppStoreInAppController {
    return objc_getAssociatedObject(self, _cmd);
}

@end

















@implementation GGAppManager (CachesFunctions)

#pragma mark ------------------------- Interface -------------------------
+ (void)clearMemoryWithType:(GGAppManagerClearMemoryType)type complateBlock:(void(^)(void))block {
    switch (type) {
        case GGAppManagerClearMemoryTypeAll: {
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self pv_clearNetRequestCaches];
                
                [self pv_clearAppCaches];
                
                [self pv_clearImageCachesCompletion:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (block) {
                            block();
                        }
                    });
                }];
            });
        }
            break;
        case GGAppManagerClearMemoryTypeImage: {
            [self pv_clearImageCachesCompletion:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (block) {
                        block();
                    }
                });
            }];
        }
            break;
        case GGAppManagerClearMemoryTypeYTKNetWork: {
            [self pv_clearNetRequestCaches];
            
            if (block) {
                block();
            }
        }
            break;
        default:
            break;
    }
}

+ (NSString *)getCacheSizeWithType:(GGAppManagerClearMemoryType)type {
    NSInteger cacheSize = 0;
    switch (type) {
        case GGAppManagerClearMemoryTypeAll: {
            cacheSize = [self pv_getAppCachesSize];
            
            cacheSize += [self pv_getImageCachesSize];
            
            cacheSize += [self pv_getNetRequestCachesSize];
        }
            break;
        case GGAppManagerClearMemoryTypeImage: {
            cacheSize = [self pv_getImageCachesSize];
        }
            break;
        case GGAppManagerClearMemoryTypeYTKNetWork: {
            cacheSize = [self pv_getNetRequestCachesSize];
        }
            break;
        default:
            break;
    }
    
    return [self pv_fileSizeWithInterge:cacheSize];
}

#pragma mark ------------------------- Private Method -------------------------
+ (NSInteger)pv_getCacheSizeWithFilePath:(NSString *)path {
    // 获取“path”文件夹下的所有文件
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    NSString *filePath = nil;
    NSInteger totleSize = 0;
    for (NSString *subPath in subPathArr) {
        
        filePath = [path stringByAppendingPathComponent:subPath];
        
        BOOL isDirectory = NO;
        
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        //忽略不需要计算的文件:文件夹不存在/ 过滤文件夹/隐藏文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) {
            
            continue;
        }
        
        /** attributesOfItemAtPath: 文件夹路径 该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因 */
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        // 计算总大小
        totleSize += size;
    }
    
    return totleSize;
}

//清除path文件夹下缓存
+ (BOOL)pv_clearCacheWithFilePath:(NSString *)path {
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString *filePath = nil;
    NSError *error = nil;
    for (NSString *subPath in subPathArr) {
        filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }
        
    }
    
    return YES;
}

// 将文件大小转换
+ (NSString *)pv_fileSizeWithInterge:(NSInteger)size {
      // 1k = 1024, 1m = 1024k
      if (size < 1024) { //小于1k
          return [NSString stringWithFormat:@"%ldB",(long)size];

      } else if (size < 1024 * 1024) { //小于1M
          CGFloat cFloat = size / 1024;
          return [NSString stringWithFormat:@"%.1fK",cFloat];

      } else if (size < 1024 * 1024 * 1024) { //小于1G
          CGFloat cFloat = size / (1024 * 1024);
          return [NSString stringWithFormat:@"%.1fM",cFloat];
      } else { //大于1G
          CGFloat cFloat = size / (1024 * 1024 * 1024);
          return [NSString stringWithFormat:@"%.1fG",cFloat];
      }
}

#pragma mark --- 获取图片缓存大小
+ (NSUInteger)pv_getImageCachesSize {
    return [[SDImageCache sharedImageCache] totalDiskSize];
}

#pragma mark --- 获取网络缓存大小
+ (NSUInteger)pv_getNetRequestCachesSize {
    NSUInteger cacheSize = 0;
    
    cacheSize = [GGNetWorkManager getNetRequestCachesSize];
    
    return cacheSize;
}

#pragma mark --- 获取App Caches文件夹大小
+ (NSUInteger)pv_getAppCachesSize {
    NSString *libraryCachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    NSUInteger cacheSize = [self pv_getCacheSizeWithFilePath:libraryCachePath];
    
    return cacheSize;
}

#pragma mark --- 清除图片缓存
+ (void)pv_clearImageCachesCompletion:(nullable SDWebImageNoParamsBlock)completionBlock {
    [[SDImageCache sharedImageCache] clearWithCacheType:SDImageCacheTypeAll completion:completionBlock];
}

#pragma mark --- 清除网络请求缓存
+ (void)pv_clearNetRequestCaches {
    [GGNetWorkManager clearNetRequestCaches];
}

#pragma mark --- 清除 App Caches 文件夹缓存
+ (void)pv_clearAppCaches {
    NSString *libraryCachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    [self pv_clearCacheWithFilePath:libraryCachePath];
}

@end
