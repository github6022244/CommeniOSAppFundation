//
//  CGAppNetWorkDefine.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/3.
//

#import <Foundation/Foundation.h>

@class GGBaseRequestReslutModel;

typedef NS_ENUM(NSUInteger, GGApiResponseStatus) {
    Failed_GGApiResponseStatus,
    Successed_GGApiResponseStatus,
    Timeout_GGApiResponseStatus,
    Others_GGApiResponseStatus,
};

typedef void(^GGBaseRequestSuccessResultBlock)(GGBaseRequestReslutModel *apiReslutModel);

typedef void(^GGBaseRequestFailureResultBlock)(NSError * _Nullable error);
