//
//  GGBaseRequest.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/6.
//

#import "GGBaseRequest.h"
#import <QMUIKit.h>

@implementation GGBaseRequest

#pragma mark ------------------------- Cycle -------------------------
- (instancetype)init {
    if (self = [super init]) {
        [self configAnimatingView];
    }
    return self;
}

#pragma mark ------------------------- Config -------------------------
- (void)configAnimatingView {
    self.animatingView = [QMUIHelper visibleViewController].view ? : [GGNetWorkHelper getKeyWindow];
    self.animatingText = @"加载中..";
}

#pragma mark ------------------------- Override -------------------------
// 请求 path
- (NSString *)requestUrl {
    return nil;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

// 可以定制参数，不影响已经配置的公共参数
- (id)requestArgument {
    return nil;
}

// 可以指定域名，也可以不指定，按照配置的来
- (NSString *)baseUrl {
    return nil;
}

- (NSTimeInterval)requestTimeoutInterval {
    return [GGNetWorkManager share].timeoutInterval;
}

// 设置请求头，不影响公共请求头
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    // 设置请求头
    return nil;
}

- (BOOL)useCDN {
    return NO;
}

- (void)requestCompleteFilter {
    NSString *resStr = [NSString stringWithFormat:@"返回数据:\n%@", self.responseObject];
    
    NSString *logStr = [GGNetWorkHelper getStringToLogRequest:self forRequestFail:NO appendString:resStr];
    
//    NSLog(@"%@", logStr);
    
}

- (void)requestFailedFilter {
//    NSLog(@"%@", [GGNetWorkHelper getStringToLogRequest:self forRequestFail:YES appendString:nil]);
}

/// 如果缓存验证不通过，是否自动删除缓存文件
- (BOOL)autoClearCachesIfNotValidate {
    return YES;
}

/// 是否使用公共参数（默认YES）
- (BOOL)useCommenParameters {
    return YES;
}

/// 是否使用公共Header（默认YES）
- (BOOL)useCommenHeader {
    return YES;
}

@end
