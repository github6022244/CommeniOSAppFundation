//
//  MRCacheDirPathFilter.h
//  RKZhiChengYun
//
//  Created by GG on 2020/11/14.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetworkConfig.h>
#import <YTKNetwork/YTKBaseRequest.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRCacheDirPathFilter : NSObject<YTKCacheDirPathFilterProtocol>

- (NSString *)filterCacheDirPath:(NSString *)originPath withRequest:(YTKBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
