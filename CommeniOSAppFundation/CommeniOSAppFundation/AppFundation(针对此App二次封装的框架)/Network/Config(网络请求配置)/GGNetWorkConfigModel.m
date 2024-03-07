//
//  GGNetWorkConfigModel.m
//  GGNetWorkManager
//
//  Created by GG on 2022/5/17.
//

#import "GGNetWorkConfigModel.h"
#import <QMUIKit.h>
#import <GGNetWorkHelper.h>
#import "GGNetApiDefine.h"
//#import "CXGUserInfoManager.h"
#import "FCUUID.h"
#import "GGTips.h"

/// 用户登录后重新配置网络请求成功回调
NSString *const Notify_GGNetWorkConfigModelReconfigNetworkForUserLogin = @"Notify_GGNetWorkConfigModelReconfigNetworkForUserLogin";

@implementation GGNetWorkConfigModel

static GGNetWorkConfigModel *instance;

#pragma mark ------------------------- Cycle -------------------------
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GGNetWorkConfigModel alloc] init];
    });
    return instance;
}

//+ (id)allocWithZone:(struct _NSZone *)zone {
//    return [self sharedInstance];
//}

- (instancetype)init {
    if (self = [super init]) {
        [self addNotify];
    }
    
    return self;
}

#pragma mark ------------------------- Config -------------------------
- (void)addNotify {
#warning -gg 完善
//    // 登录
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify_login) name:CXGUserManagerNotifiyLogin object:nil];
//    
//    // 退出登录
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify_logout) name:CXGUserManagerNotifiyLogout object:nil];
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
// 配置header
- (NSDictionary *)gg_configRequestHeaders {
    return [self _configRequestHeader];
}

// 返回公共参数
- (NSDictionary *_Nullable)gg_configcommonParameters {
    return [self _configCommenParameterWithParam:nil];
}

// 返回请求缓存 path
- (NSDictionary *_Nullable)gg_configFilterCacheDirPath {
    return nil;
}

// 超时时间
- (NSUInteger)gg_configTimeoutInterval {
    return 10;
}

// 配置 AFHTTPSessionManager
- (void)gg_configAFHTTPSessionManager:(AFHTTPSessionManager * _Nullable)manager {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPMaximumConnectionsPerHost = 20;
    sessionConfiguration.allowsCellularAccess = YES;
    
    manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    manager.requestSerializer.timeoutInterval = 30;
}

// 设置请求模式
- (GGNetManagerServerType)gg_configNetServerType {
    /// 因为使用宏控制接口，所以这个配置没用了
    return GGNetManagerServerType_Develop;
}

// 各个模式下的域名
- (NSString * _Nullable)gg_configURL_Develope_CDN {
    return BASE_URL;
}

- (NSString * _Nullable)gg_configURL_Develope_H5 {
    return BASE_URL;
}

- (NSString * _Nullable)gg_configURL_Develope_Sever {
    return BASE_URL;
}

- (NSString * _Nonnull)gg_configURL_Public_CDN {
    return BASE_URL;
}

- (NSString * _Nonnull)gg_configURL_Public_H5 {
    return BASE_URL;
}

- (NSString * _Nonnull)gg_configURL_Public_Sever {
    return BASE_URL;
}

- (NSString * _Nullable)gg_configURL_Test_CDN {
    return BASE_URL;
}

- (NSString * _Nullable)gg_configURL_Test_H5 {
    return BASE_URL;
}

- (NSString * _Nullable)gg_configURL_Test_Sever {
    return BASE_URL;
}

// 返回自定义菊花样式 model
- (id<GGNetWorkManagerLoadingProtocol> _Nonnull)gg_getLoadingModel {
    return [[GGNetWorkConfigLoadingModel alloc] init];
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 通知
#pragma mark --- 登录通知
- (void)notify_login {
    // 重新配置网络请求
    NSLog(@"登录，重新配置网络请求");
    [GGNetWorkManager setUpConfigModel:[GGNetWorkConfigModel sharedInstance]];
    
    if ([self _jugeUserLogin]) {
        // 用户如果是登录状态，发送 1.用户登录 + 2.重新配置网络 通知
        [[NSNotificationCenter defaultCenter] postNotificationName:Notify_GGNetWorkConfigModelReconfigNetworkForUserLogin object:nil];
    }
}

#pragma mark --- 退出登录通知
- (void)notify_logout {
    // 重新配置网络请求
    NSLog(@"退出登录，重新配置网络请求");
    [GGNetWorkManager setUpConfigModel:[GGNetWorkConfigModel sharedInstance]];
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 获取header
- (NSDictionary *)_configRequestHeader {
    return nil;
}

#pragma mark --- 判断用户是否登录
- (BOOL)_jugeUserLogin {
#warning -gg 完善
//    return [CXGUserInfoManager isUserLogin];
    
    return YES;
}

#pragma mark --- 获取公共参数
- (NSDictionary *)_configCommenParameterWithParam:(id)parameter {
#warning -gg 完善
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameter];
//    if (![dic.allKeys containsObject:@"user_id"]) {
//        [dic setObject:@([CXGUserInfoManager sharedManager].user_id) ? : @(0) forKey:@"user_id"];
//    }
//    
//    if (![dic.allKeys containsObject:@"school_id"]) {
//        [dic setObject:NSStringTransformEmpty([CXGUserInfoManager user_getCurrentUserSchoolId]) forKey:@"school_id"];
//    } else {
//        id school_id = [dic gg_safeObjectForKey:@"school_id"];
//        
//        BOOL containObj = NO;
//        if ([school_id isKindOfClass:[NSString class]]) {
//            NSString *ID = (NSString *)school_id;
//            containObj = NSStringTransformEmpty(ID).length;
//        } else if ([school_id isKindOfClass:[NSNumber class]]) {
//            NSNumber *ID = (NSNumber *)school_id;
//            containObj = ID.integerValue;
//        } else {
//            containObj = YES;
//            QMUILog(nil, @"自定义参数 student_id 无法判断类型");
//        }
//        
//        if (!containObj) {
//            [dic setObject:NSStringTransformEmpty([CXGUserInfoManager user_getCurrentUserSchoolId]) forKey:@"school_id"];
//        }
//    }
//    
//    if (![dic.allKeys containsObject:@"student_id"]) {
//        [dic setObject:@([CXGUserInfoManager sharedManager].studentInfo.student_id) forKey:@"student_id"];
//    } else {
//        id student_id = [dic gg_safeObjectForKey:@"student_id"];
//        
//        BOOL containObj = NO;
//        if ([student_id isKindOfClass:[NSString class]]) {
//            NSString *ID = (NSString *)student_id;
//            containObj = NSStringTransformEmpty(ID).length;
//        } else if ([student_id isKindOfClass:[NSNumber class]]) {
//            NSNumber *ID = (NSNumber *)student_id;
//            containObj = ID.integerValue;
//        } else {
//            containObj = YES;
//            QMUILog(nil, @"自定义参数 student_id 无法判断类型");
//        }
//        
//        if (!containObj) {
//            [dic setObject:@([CXGUserInfoManager sharedManager].studentInfo.student_id) forKey:@"student_id"];
//        }
//    }
//    
//    if (![dic.allKeys containsObject:@"role_type"]) {
//        [dic setObject:[CXGUserInfoManager isUserLogin] ? @(CXGUserInfoManagerRoleType_Student) : @(0) forKey:@"role_type"];
//    }
//    
//    if (![dic.allKeys containsObject:@"token"]) {
//        [dic setObject:@"4Tc2VAMgt1QY96vo3srZKeJCjziH970D" forKey:@"token"];
//    }
//    
//    if (![dic.allKeys containsObject:@"platform_type"]) {
//        [dic setObject:@1 forKey:@"platform_type"];
//    }
//    
//    if (![dic.allKeys containsObject:@"device_uid"]) {
//        [dic setObject:NSStringTransformEmpty([FCUUID uuidForDevice]) forKey:@"device_uid"];
//    }
//    
//    if (![dic.allKeys containsObject:@"ref_action_name"]) {
//        [dic setObject:NSStringTransformEmpty(NSStringFromClass([[QMUIHelper visibleViewController] class])) forKey:@"ref_action_name"];
//    }
//    
//    if (![dic.allKeys containsObject:@"mobile_type"]) {
//        [dic setObject:@(1) forKey:@"mobile_type"];
//    }
//    
//    if (![dic.allKeys containsObject:@"is_student_app"]) {
//        [dic setObject:@(1) forKey:@"is_student_app"];
//    }
//    
//    if (![dic.allKeys containsObject:@"from"]) {
//        [dic setObject:@(1) forKey:@"from"];
//    }
//    
//    if (![dic.allKeys containsObject:@"batch_id"]) {
//        [dic setObject:@([CXGUserInfoManager sharedManager].studentInfo.batch_id) forKey:@"batch_id"];
//    }
//    
//    if (![dic.allKeys containsObject:@"link_id"]) {
//        [dic setObject:@([CXGUserInfoManager sharedManager].studentInfo.link_id) forKey:@"link_id"];
//    }
//    
//    if (![dic.allKeys containsObject:@"app_grade"]) {
//        [dic setObject:NSStringTransformEmpty([GGAppManager appVersion]) forKey:@"app_grade"];
//    }
    
    return dic;
}

@end













@interface GGNetWorkConfigLoadingModel ()

@property (nonatomic, strong) GGTips *tips;

@end

@implementation GGNetWorkConfigLoadingModel

- (void)dealloc {
    NSLog(@"\n LoadingModel 释放了");
}

- (instancetype)init {
    if (self = [super init]) {
//        [self config];
    }
    
    return self;
}

//- (void)config {
//    _tips = [[QMUITips alloc] initWithView:[GGNetWorkHelper getKeyWindow]];
//    _tips.removeFromSuperViewWhenHide = YES;
//}

- (void)gg_configHideLoading {
//    [_tips hideAnimated:YES];
    [_tips hideAnimated:YES];
}

- (void)gg_configShowLoadingText:(NSString * _Nullable)text inView:(UIView * _Nonnull)view {
//    if (_tips.superview) {
//        [_tips removeFromSuperview];
//    }
    
//    [view addSubview:_tips];
//    [_tips showLoading:text];
    
    view = view ? : [UIWindow getKeyWindow];
    
    _tips = [GGTips showLoading:text inView:view];
}

@end
