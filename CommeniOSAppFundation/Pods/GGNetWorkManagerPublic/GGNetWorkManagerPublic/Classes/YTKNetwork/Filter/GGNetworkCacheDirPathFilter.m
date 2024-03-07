//
//  MRCacheDirPathFilter.m
//  RKZhiChengYun
//
//  Created by GG on 2020/11/14.
//

#import "GGNetworkCacheDirPathFilter.h"
#import "GGNetWorkManager.h"

@implementation GGNetworkCacheDirPathFilter

- (NSString *)filterCacheDirPath:(NSString *)originPath withRequest:(YTKBaseRequest *)request {
    // 在这里可以设置网络请求的缓存path
    NSString *finalUrl = originPath.copy;
    
    NSDictionary *urlFilterCache = [GGNetWorkManager share].filterCacheDirPath;
    
    if (!urlFilterCache || !urlFilterCache.allKeys.count) {
        finalUrl = originPath;
    } else {
        NSArray *urlArray = urlFilterCache.allKeys;
        
        NSString *key = request.useCDN ? [request cdnUrl] : [request requestUrl];
        
        if ([urlArray containsObject:key]) {
            finalUrl = [urlFilterCache objectForKey:key];
        }
    }
    
    return finalUrl;
}

@end
