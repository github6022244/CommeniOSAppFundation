//
//  YTKBaseRequest+GGNetWork.m
//  GGNetWorkManager
//
//  Created by GG on 2022/5/20.
//

#import "YTKBaseRequest+GGNetWork.h"
#import <objc/runtime.h>
#import "GGNetWorkManager.h"
#import "GGNetWorkHelper.h"
#import "GGNetWorkManagerDefine.h"
#import "GGNetWorkManagerYTKRequestProtocol.h"

@implementation YTKBaseRequest (GGNetWork)

+ (void)load {
#ifdef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        GGNetWorkExchangeImplementations([self class], @selector(requestFailedFilter), @selector(gg_requestFailedFilter));
    });
#endif
    
}

#pragma mark --- 统一处理失败回调
///  Called on the main thread when request failed.
- (void)gg_requestFailedFilter {
    GGNetWorkLog(@"%@", [GGNetWorkHelper getStringToLogRequest:self forRequestFail:YES appendString:nil]);
    
    [self gg_requestFailedFilter];
}

@end
