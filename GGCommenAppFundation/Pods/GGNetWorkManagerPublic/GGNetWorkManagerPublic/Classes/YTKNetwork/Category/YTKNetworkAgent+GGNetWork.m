//
//  YTKNetworkAgent+GGNetWork.m
//  GGNetWorkManager
//
//  Created by GG on 2022/5/20.
//

#import "YTKNetworkAgent+GGNetWork.h"
#import <objc/runtime.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "GGNetWorkManager.h"
#import "GGNetWorkHelper.h"
#import "GGNetworkManagerDefine.h"
#import "GGNetWorkManagerYTKRequestProtocol.h"

@implementation YTKNetworkAgent (GGNetWork)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        GGNetWorkExchangeImplementations([self class], @selector(init), @selector(gg_init));
        
GGNetWorkPushIgnoreUndeclaredSelectorWarning
        
#ifdef DEBUG
        GGNetWorkExchangeImplementations([self class], @selector(sessionTaskForRequest:error:), @selector(gg_sessionTaskForRequest:error:));
#endif

        GGNetWorkExchangeImplementations([self class], @selector(requestSerializerForRequest:), @selector(gg_requestSerializerForRequest:));
GGNetWorkPopClangDiagnosticWarnings
    });
}

#pragma mark --- 重写init，配置 AFHTTPSessionManager
-(instancetype)gg_init{
    [self gg_init];
    [self gg_class_copyIvarList:[self class]];
    return self;
}

#pragma mark --- 统一打印网络请求参数、url
- (NSURLSessionTask *)gg_sessionTaskForRequest:(YTKBaseRequest *)request error:(NSError * _Nullable __autoreleasing *)error {
    NSURLSessionTask *task = [self gg_sessionTaskForRequest:request error:error];

    if ([GGNetWorkManager share].debugLogEnable) {
        // 打印
        NSString *resStr = [NSString stringWithFormat:@"完整URL:\n%@", task.originalRequest.URL.absoluteString];
        
        NSString *logStr = [GGNetWorkHelper getStringToLogRequest:request forRequestFail:NO appendString:resStr];
        
        GGNetWorkLog(@"%@", logStr);
    }
    
    return task;
}

#pragma mark --- 统一设置一次 header
- (AFHTTPRequestSerializer *)gg_requestSerializerForRequest:(YTKBaseRequest *)request {
    AFHTTPRequestSerializer *requestSerializer = [self gg_requestSerializerForRequest:request];
    
    BOOL useCommenHeader = YES;
    if ([self respondsToSelector:@selector(useCommenHeader)]) {
        useCommenHeader = [self performSelector:@selector(useCommenHeader)];
    }
    
    if (useCommenHeader) {
        // 通过 GGNetWorkManager 的 requestHeaders 设置一次 header
        NSDictionary *managerRequestHeaders = [GGNetWorkManager share].requestHeaders;
        if (managerRequestHeaders) {
            for (NSString *httpHeaderField in managerRequestHeaders.allKeys) {
                NSString *value = managerRequestHeaders[httpHeaderField];
                [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
            }
        }
    }
    
    return requestSerializer;
}

#pragma mark ------------------------- Private -------------------------
- (void)gg_class_copyIvarList:(Class)class {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        // 获取成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //        NSString *value = object_getIvar(obj, ivar);
        if ([name isEqualToString:@"_manager"]) {
            AFHTTPSessionManager *dt_manager =  [AFHTTPSessionManager manager];
            dt_manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",@"text/css",nil];
            
            if (dt_manager) {
                // 自定义 AFHTTPSessionManager
                [[GGNetWorkManager share].configModel gg_configAFHTTPSessionManager:dt_manager];
            }
            
           //  修改成员变量的值
            object_setIvar(self, ivar,dt_manager);
        }
        
    }
    
    free(ivarList);
}

@end
