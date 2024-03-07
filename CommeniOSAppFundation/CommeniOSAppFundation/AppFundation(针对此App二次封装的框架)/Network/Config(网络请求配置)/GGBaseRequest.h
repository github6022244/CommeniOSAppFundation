//
//  GGBaseRequest.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/6.
//  如果请求失败按照 

#import <YTKNetwork/YTKNetwork.h>
#import <GGNetWork.h>
#import "CGAppNetWorkDefine.h"

@class GGBaseRequestReslutModel;

NS_ASSUME_NONNULL_BEGIN

@interface GGBaseRequest : YTKRequest<GGNetWorkManagerYTKRequestProtocol>

@property (nonatomic, strong, readonly) GGBaseRequestReslutModel *apiReslutModel;

/// 根据自己后台自定义的请求成功block
/// 不用再使用 YTKRequest 的 successCompletionBlock
@property (nonatomic, copy) GGBaseRequestSuccessResultBlock api_requestSuccessResultBlock;

/// 根据自己后台自定义的请求失败 block
/// 不用再使用 YTKRequest 的 failureCompletionBlock
@property (nonatomic, copy) GGBaseRequestFailureResultBlock api_requestFailureResultBlock;

/// 不要自动Toast展示后台返回的失败 message (默认NO)
/// 包括请求失败+请求成功但是接口返回失败信息
@property (nonatomic, assign) BOOL doNotAutoShowRequestFailMessage;

///// 拼接公共参数(后期需要修改网络请求库)
//- (id)combinCommonParamWithArguments:(NSDictionary *)aruguments;

@end







@interface GGBaseRequestReslutModel : NSObject

@property (nonatomic, assign) GGApiResponseStatus responseStatus;
/// _responseStatus == Successed_GGApiResponseStatus
@property (nonatomic, assign, getter=isRequestSuccessed, readonly) BOOL requestSuccessed;

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) id responseObject;

/// 是否已经加载到分页的最后一页
@property (nonatomic, assign, readonly, getter=isLoadToLastPage) BOOL loadToLastPage;

/// 判断是否成功并且 自动toast提示(不管失败还是成功都会提示，但过滤掉了 "success" 这种普通的 message)
- (BOOL)jugeSussessAndToastMessageIfNeed;
/// 判断是否成功，只会在失败时提示
- (BOOL)jugeSussessAndToastOnlyForFail;

@end

NS_ASSUME_NONNULL_END
