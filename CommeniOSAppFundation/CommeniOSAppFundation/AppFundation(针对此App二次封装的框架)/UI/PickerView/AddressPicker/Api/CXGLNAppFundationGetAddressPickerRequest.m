//
//  CXGLNAppFundationGetAddressPickerRequest.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/1.
//

#import "CXGLNAppFundationGetAddressPickerRequest.h"

@implementation CXGLNAppFundationGetAddressPickerRequest

// 请求 path
- (NSString *)requestUrl {
    return @"v4.index/area.html";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

// 可以定制参数，不影响已经配置的公共参数
- (id)requestArgument {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    //    return [self combinCommonParamWithArguments:param];
    return param;
}

@end
