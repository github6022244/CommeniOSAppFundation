//
//  MRUrlArgumentsFilter.h
//  RKZhiChengYun
//
//  Created by GG on 2020/11/14.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetworkConfig.h>
#import <YTKNetwork/YTKBaseRequest.h>
@class MRUrlArgumentsFilter;

NS_ASSUME_NONNULL_BEGIN

@interface MRUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>

+ (MRUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
