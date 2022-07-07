//
//  GGCachesRequest.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/8.
//

#import "GGCachesRequest.h"
#import <QMUIKit.h>

#define GGCachesRequestDev_Path @"v4.activityIndex/appIndexActivityInfo"

@implementation GGCachesRequest

#pragma mark ------------------------- Override -------------------------
// 请求 path
- (NSString *)requestUrl {
    return GGCachesRequestDev_Path;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return nil;
}

- (NSInteger)cacheTimeInSeconds {
    return 6;
}

/// 如果缓存未通过验证，是否自动删除缓存
- (BOOL)autoClearCachesIfNotValidate {
    return YES;
}

@end
