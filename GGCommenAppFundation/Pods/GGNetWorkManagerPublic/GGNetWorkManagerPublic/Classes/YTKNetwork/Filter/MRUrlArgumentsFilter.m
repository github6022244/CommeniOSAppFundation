//
//  MRUrlArgumentsFilter.m
//  RKZhiChengYun
//
//  Created by GG on 2020/11/14.
//
 
#import "MRUrlArgumentsFilter.h"
#import <AFNetworking/AFNetworking.h>

@implementation MRUrlArgumentsFilter {
    NSDictionary *_arguments;
}

+ (MRUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    return [self urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}

- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *paraUrlString = AFQueryStringFromParameters(parameters);

    if (!(paraUrlString.length > 0)) {
        return originUrlString;
    }

//    BOOL useDummyUrl = NO;
//    static NSString *dummyUrl = nil;
    NSURLComponents *components = [NSURLComponents componentsWithString:originUrlString];
//    if (!components) {
//        useDummyUrl = YES;
//        if (!dummyUrl) {
//            dummyUrl = @"http://www.dummy.com";
//        }
//        components = [NSURLComponents componentsWithString:dummyUrl];
//    }

    NSString *queryString = components.query ?: @"";
    NSString *newQueryString = [queryString stringByAppendingFormat:queryString.length > 0 ? @"&%@" : @"%@", paraUrlString];

    components.query = newQueryString;

//    if (useDummyUrl) {
//        return [components.URL.absoluteString substringFromIndex:dummyUrl.length - 1];
//    } else {
        return components.URL.absoluteString;
//    }
}

@end
