//
//  GGNetWorkConfigModel.m
//  GGNetWorkManager
//
//  Created by GG on 2022/5/17.
//

#import "GGNetWorkConfigModel.h"
#import <QMUIKit.h>
#import <GGNetWorkHelper.h>

#define BASE_URL @"http://cxgl.changxianggu.com/app/"

@implementation GGNetWorkConfigModel

// 配置header
- (NSDictionary *)gg_configRequestHeaders {
    return [self _configRequestHeader];
}

// 返回公共参数
- (NSDictionary *_Nullable)gg_configCommenParameters {
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
    
}

// 设置请求模式
- (GGNetManagerServerType)gg_configNetServerType {
    return GGNetManagerServerType_Develop;
}

// 各个模式下的域名
- (NSString * _Nullable)gg_configURL_Develope_CDN {
    return nil;
}

- (NSString * _Nullable)gg_configURL_Develope_H5 {
    return nil;
}

- (NSString * _Nullable)gg_configURL_Develope_Sever {
    return BASE_URL;
}

- (NSString * _Nonnull)gg_configURL_Public_CDN {
    return nil;
}

- (NSString * _Nonnull)gg_configURL_Public_H5 {
    return nil;
}

- (NSString * _Nonnull)gg_configURL_Public_Sever {
    return nil;
}

- (NSString * _Nullable)gg_configURL_Test_CDN {
    return nil;
}

- (NSString * _Nullable)gg_configURL_Test_H5 {
    return nil;
}

- (NSString * _Nullable)gg_configURL_Test_Sever {
    return nil;
}

// 返回自定义菊花样式 model
- (id<GGNetWorkManagerLoadingProtocol> _Nonnull)gg_getLoadingModel {
    return [[GGNetWorkConfigLoadingModel alloc] init];
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 获取header
- (NSDictionary *)_configRequestHeader {
    return nil;
}

#pragma mark --- 获取公共参数
- (NSDictionary *)_configCommenParameterWithParam:(id)parameter {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameter];
//    if (![dic.allKeys containsObject:@"user_id"]) {
//        [dic setObject:@([UserInfoManager sharedManager].user_id) ?: @(0) forKey:@"user_id"];
//    }
    
    if (![dic.allKeys containsObject:@"role_type"]) {
        [dic setObject:@(0) forKey:@"role_type"];
    }
    
    if (![dic.allKeys containsObject:@"token"]) {
        [dic setObject:@"4Tc2VAMgt1QY96vo3srZKeJCjziH970D" forKey:@"token"];
    }
    
    if (![dic.allKeys containsObject:@"platform_type"]) {
        [dic setObject:@1 forKey:@"platform_type"];
    }
    
    if (![dic.allKeys containsObject:@"device_uid"]) {
        [dic setObject:@"" forKey:@"device_uid"];
    }
    
    if (![dic.allKeys containsObject:@"ref_action_name"]) {
        [dic setObject:@"" forKey:@"ref_action_name"];
    }
    
    if (![dic.allKeys containsObject:@"mobile_type"]) {
        [dic setObject:@(1) forKey:@"mobile_type"];
    }
    
    if (![dic.allKeys containsObject:@"school_id"]) {
        [dic setObject:@"" forKey:@"school_id"];
    }
    
    return dic;
}

@end













@interface GGNetWorkConfigLoadingModel ()

@property (nonatomic, strong) QMUITips *tips;

@end

@implementation GGNetWorkConfigLoadingModel

- (void)dealloc {
    NSLog(@"\n LoadingModel 释放了");
}

- (instancetype)init {
    if (self = [super init]) {
        [self config];
    }
    
    return self;
}

- (void)config {
    _tips = [[QMUITips alloc] initWithView:[GGNetWorkHelper getKeyWindow]];
    _tips.removeFromSuperViewWhenHide = YES;
}

- (void)gg_configHideLoading {
    [_tips hideAnimated:YES];
}

- (void)gg_configShowLoadingText:(NSString * _Nullable)text inView:(UIView * _Nonnull)view {
    if (_tips.superview) {
        [_tips removeFromSuperview];
    }
    
    [view addSubview:_tips];
    [_tips showLoading:text];
}

@end
