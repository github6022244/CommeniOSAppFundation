//
//  GGTestRequest.m
//  GGNetWorkManager
//
//  Created by GG on 2022/5/17.
//

#import "GGTestRequest.h"
#import <QMUIKit.h>
#import <GGNetWork.h>

#define Dev_Path @"v4.activityIndex/appIndexActivityInfo"

@implementation GGTestRequest

#pragma mark ------------------------- Override -------------------------
// 请求 path
- (NSString *)requestUrl {
    return Dev_Path;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return nil;
}

@end
