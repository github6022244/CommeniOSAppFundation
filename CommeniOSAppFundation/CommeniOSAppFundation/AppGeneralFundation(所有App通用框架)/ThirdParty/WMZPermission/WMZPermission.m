//
//  WMZPermission.m
//  WMZPermission
//
//  Created by wmz on 2018/12/10.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WMZPermission.h"
#import "UIWindow+GG.h"
#import <Photos/Photos.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>
//#import <Photos/Photos.h>
//#import <EventKit/EventKit.h>
//#import <AddressBook/AddressBook.h>
//#import <Contacts/Contacts.h>
#import <CoreLocation/CoreLocation.h>
//#import <CoreBluetooth/CoreBluetooth.h>
//#import <HealthKit/HealthKit.h>
//#import <MediaPlayer/MediaPlayer.h>


#define IOS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

@interface WMZPermission()<CLLocationManagerDelegate>

@property(nonatomic,copy)callBack block;

@property (nonatomic, strong) CLLocationManager *manager;// 定位 manager

@end

@implementation WMZPermission
static WMZPermission *_instance;

/*
 * 单例
 */
+(instancetype)shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    }) ;
    return _instance;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [WMZPermission shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [WMZPermission shareInstance] ;
}

/*
 * 获取权限
 * @param  type       类型
 * @param  block      回调
 */
- (void)permissonType:(PermissionType)type withHandle:(callBack)block{
    self.block = block;
    
    switch (type) {
        case PermissionTypePhoto:
        {
            [self permissionTypePhotoAction];
        }
            break;
        case PermissionTypeCamera:
        {
            [self permissionTypeCameraAction];
        }
            break;
//        case PermissionTypeMic:
//        {
//            [self permissionTypeMicAction];
//        }
//            break;
        case PermissionTypeLocationWhen:
        {
            [self permissionTypeLocation:type];
        }
            break;
        case PermissionTypeLocationAlways:
        {
            [self permissionTypeLocation:type];
        }
            break;
//        case PermissionTypeContacts:
//        {
//            [self permissionTypeContactsAction];
//        }
//            break;
//        case PermissionTypeBlue:
//        {
//            [self permissionTypeBlueAction];
//        }
//            break;
//        case PermissionTypeRemaine:
//        {
//            [self permissionTypeRemainerAction];
//        }
//            break;
//        case PermissionTypeHealth:
//        {
//            [self permissionTypeHealthAction];
//        }
//            break;
//        case PermissionTypeMediaLibrary:
//        {
//            [self permissionTypeMediaLibraryAction];
//        }
//         break;
        default:
            break;
    }
}

/*
 *相册权限
 */
- (void)permissionTypePhotoAction{
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    __block WMZPermission *weakSelf = self;
    if (photoStatus == PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                if (weakSelf.block) {
                    weakSelf.block(YES, @(photoStatus));
                }
            } else {
                if (weakSelf.block) {
                    weakSelf.block(NO, @(photoStatus));
                }
            }
        }];
    } else if (photoStatus == PHAuthorizationStatusAuthorized) {
        if (weakSelf.block) {
            self.block(YES, @(photoStatus));
        }
    } else if(photoStatus == PHAuthorizationStatusRestricted||photoStatus == PHAuthorizationStatusDenied){
        if (weakSelf.block) {
            self.block(NO, @(photoStatus));
        }
        [self pushSetting:@"相册权限"];
        
    }else{
        if (weakSelf.block) {
            self.block(NO, @(photoStatus));
        }
    }
}

/*
 *相机权限
 */
- (void)permissionTypeCameraAction{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    __block WMZPermission *weakSelf = self;
    if(authStatus == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (weakSelf.block) {
                weakSelf.block(granted, @(authStatus));
            }
        }];
    }  else if (authStatus == AVAuthorizationStatusAuthorized) {
        if (weakSelf.block) {
            self.block(YES, @(authStatus));
        }
    } else if(authStatus == AVAuthorizationStatusRestricted||authStatus == AVAuthorizationStatusDenied){
        if (weakSelf.block) {
            self.block(NO, @(authStatus));
        }
        [self pushSetting:@"相机权限"];
        
    }else{
        if (weakSelf.block) {
            self.block(NO, @(authStatus));
        }
    }
}

/// 定位权限
- (void)permissionTypeLocation:(PermissionType)permissionType {
    if (![CLLocationManager locationServicesEnabled]) {
        [self pushSetting:@"定位服务"];
        return;
    }
    
    CLAuthorizationStatus status = 0;
    
    if (@available(iOS 14, *)) {
        status = self.manager.authorizationStatus;
    } else {
        status = [CLLocationManager authorizationStatus];
    }
    
    if (status == permissionType) {
        if (self.block) {
            self.block(YES, @(status));
        }
    } else if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        if (self.block) {
            self.block(NO, @(status));
        }
        
        [self pushSetting:@"定位权限"];
    } else {
        switch (permissionType) {
            case PermissionTypeLocationWhen:
                [self.manager requestWhenInUseAuthorization];
                break;
            case PermissionTypeLocationAlways:
                [self.manager requestAlwaysAuthorization];
                break;
            default:
                break;
        }
    }
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark --- 定位权限回调
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 140000
// iOS 14及以上
- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    if (@available(iOS 14.0, *)) {
        CLAuthorizationStatus status = manager.authorizationStatus;
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:
            {
//                NSLog(@"用户还未决定授权");
                if (self.block) {
                    self.block(NO, @(status));
                }
                break;
            }
            case kCLAuthorizationStatusRestricted:
            {
//                NSLog(@"访问受限");
                if (self.block) {
                    self.block(NO, @(status));
                }
                
                [self pushSetting:@"定位权限"];
                break;
            }
            case kCLAuthorizationStatusDenied:
            {
                // 类方法，判断是否开启定位服务
//                if ([CLLocationManager locationServicesEnabled]) {
//                    NSLog(@"定位服务开启，被拒绝");
//                } else {
//                    NSLog(@"定位服务关闭，不可用");
//                }
                if (self.block) {
                    self.block(NO, @(status));
                }
                
                [self pushSetting:@"定位权限"];
                break;
            }
            case kCLAuthorizationStatusAuthorizedAlways:
            {
//                NSLog(@"获得前后台授权");
                if (self.block) {
                    self.block(YES, @(status));
                }
                break;
            }
            case kCLAuthorizationStatusAuthorizedWhenInUse:
            {
//                NSLog(@"获得前台授权");
                if (self.block) {
                    self.block(YES, @(status));
                }
                break;
            }
            default:
                break;
        }
    } else {
        // Fallback on earlier versions
    }
}
#else
// iOS 14以下
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
//                NSLog(@"用户还未决定授权");
            if (self.block) {
                self.block(NO, @(status));
            }
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
//                NSLog(@"访问受限");
            if (self.block) {
                self.block(NO, @(status));
            }
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
//                if ([CLLocationManager locationServicesEnabled]) {
//                    NSLog(@"定位服务开启，被拒绝");
//                } else {
//                    NSLog(@"定位服务关闭，不可用");
//                }
            if (self.block) {
                self.block(NO, @(status));
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
//                NSLog(@"获得前后台授权");
            if (self.block) {
                self.block(YES, @(status));
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
//                NSLog(@"获得前台授权");
            if (self.block) {
                self.block(YES, @(status));
            }
            break;
        }
        default:
            break;
    }
}
#endif

#pragma mark ------------------------- Private -------------------------
/*
 *跳转设置
 */
- (void)pushSetting:(NSString*)urlStr{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@%@",urlStr,self.tip] preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url= [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (IOS_10_OR_LATER) {
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
                }];
            }
        }else{
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication]openURL:url];
            }
        }
    }];
    [alert addAction:okAction];
    [[WMZPermission getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

- (void)pushString:(NSString *)string {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    [[WMZPermission getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

//获取当前VC
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIWindow getKeyWindow].rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

#pragma mark ------------------------- set / get -------------------------
- (NSString *)tip{
    if (!_tip) {
        _tip = @"尚未开启,是否前往设置";
    }
    return _tip;
}

- (CLLocationManager *)manager {
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
    }
    
    return _manager;
}

@end
