//
//  GGBaseRequest.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/6.
//

#import "GGBaseRequest.h"
#import <QMUIKit.h>

@implementation GGBaseRequest

#pragma mark ------------------------- Cycle -------------------------
- (instancetype)init {
    if (self = [super init]) {
        [self configAnimatingView];
    }
    return self;
}

#pragma mark ------------------------- Config -------------------------
- (void)configAnimatingView {
    self.animatingView = [QMUIHelper visibleViewController].view ? : [GGNetWorkHelper getKeyWindow];
//    self.animatingText = @"加载中..";
}

#pragma mark ------------------------- Override -------------------------
- (void)start {
    // 根据URL自定义证书
    AFHTTPSessionManager *dt_manager =  [AFHTTPSessionManager manager];
    
    AFSecurityPolicy *policy = nil;
    NSString *url = self.requestUrl;
    
    NSURL *URL = [NSURL URLWithString:url];
    if ([URL.scheme isEqualToString:@"https"] && [URL.host isEqualToString:@"cxgl.changxianggu.com"]) {
        policy = [self customSecurityPolicy];
    } else {
        policy = [AFSecurityPolicy defaultPolicy];
        policy.validatesDomainName = NO;
    }
    
    [dt_manager setSecurityPolicy:policy];
    
    // 开始网络请求
    [super start];
}

// 请求 path
- (NSString *)requestUrl {
    return nil;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

// 可以定制参数，不影响已经配置的公共参数
- (id)requestArgument {
    return nil;
}

// 可以指定域名，也可以不指定，按照配置的来
- (NSString *)baseUrl {
    return nil;
}

- (NSTimeInterval)requestTimeoutInterval {
    return [GGNetWorkManager share].timeoutInterval;
}

// 设置请求头，不影响公共请求头
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    // 设置请求头
    return nil;
}

- (BOOL)useCDN {
    return NO;
}

- (void)requestCompleteFilter {
//    NSString *resStr = [NSString stringWithFormat:@"返回数据:\n%@", self.responseObject];
    
//    NSString *logStr = [GGNetWorkHelper getStringToLogRequest:self forRequestFail:NO appendString:resStr];
    
//    NSLog(@"%@", logStr);
    
//    if (self.api_requestSuccessResultBlock) {
        [self _handleSuccessRequestResponse:self.responseObject callBack:self.api_requestSuccessResultBlock];
//    }
    
}

- (void)requestFailedFilter {
//    NSLog(@"%@", [GGNetWorkHelper getStringToLogRequest:self forRequestFail:YES appendString:nil]);
    
//    if (self.api_requestFailureResultBlock) {
        [self _handleFailRequestURLTask:self.requestTask responseError:self.error failCallBack:self.api_requestFailureResultBlock];
//    }
}

- (BOOL)statusCodeValidator {
    return YES;
}

/// 如果缓存验证不通过，是否自动删除缓存文件
- (BOOL)autoClearCachesIfNotValidate {
    return YES;
}

/// 是否使用公共参数（默认YES）
- (BOOL)usecommonParameters {
    return YES;
}

/// 是否使用公共Header（默认YES）
- (BOOL)usecommonHeader {
    return NO;
}

///// 拼接公共参数(后期需要修改网络请求库)
//- (id)combinCommonParamWithArguments:(NSDictionary *)aruguments {
//    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:aruguments];
//
//    NSDictionary *commonParam = [GGNetWorkManager share].commonParameters;
//
//    [commonParam enumerateKeysAndObjectsUsingBlock:^(NSString  *_Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        if (![param.allKeys containsObject:key]) {
//            [param setObject:obj forKey:key];
//        }
//    }];
//
//    return param;
//}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 自定义证书
- (AFSecurityPolicy *)customSecurityPolicy {
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"cxgl" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式  AFSSLPinningModeNone
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData, nil];
    
    return securityPolicy;
}

#pragma mark --- 统一处理成功回调
- (void)_handleSuccessRequestResponse:(id)responseObject callBack:(GGBaseRequestSuccessResultBlock)success {
    NSInteger code = -1;
    NSString *message = @"response data error";
    NSDictionary *response = nil;

    if ([NSDictionary gg_checkClass:responseObject objectForKey:@"data"]) {
        response = [responseObject objectForKey:@"data"];
    } else if ([NSDictionary gg_checkClass:responseObject objectForKey:@"result"]) {
        response = [responseObject objectForKey:@"result"];
    }

    BOOL successRequest = NO;

    if ([responseObject isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic containsObjectForKey:@"error"]) {
            code = [(NSNumber *)[dic objectForKey:@"error"] integerValue];
            successRequest = code == 200;
        } else if ([dic containsObjectForKey:@"status"]) {
            code = [(NSNumber *)[dic objectForKey:@"status"] integerValue];
        }
        
        if ([[dic allKeys] containsObject:@"msg"]) {
            message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"msg"]];
        } else if ([[dic allKeys] containsObject:@"message"]) {
            message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
            if (!successRequest) {
                successRequest = [[message uppercaseString] isEqualToString:@"SUCCESS"] && code == 0;
            }
        }
    }

    if (successRequest) {
        GGBaseRequestReslutModel *reslutModel = [GGBaseRequestReslutModel new];
        reslutModel.responseStatus = Successed_GGApiResponseStatus;
        reslutModel.code = code;
        reslutModel.message = message;
        reslutModel.responseObject = response;
        
        _apiReslutModel = reslutModel;
        
        if (success) {
            success(reslutModel);
        }
    } else {
        GGBaseRequestReslutModel *reslutModel = [GGBaseRequestReslutModel new];
        reslutModel.responseStatus = Others_GGApiResponseStatus;
        reslutModel.code = code;
        reslutModel.message = message;
        reslutModel.responseObject = response;
        
        _apiReslutModel = reslutModel;
        
        if (!self.doNotAutoShowRequestFailMessage) {
            [reslutModel jugeSussessAndToastOnlyForFail];
        }
        
        if (success) {
            success(reslutModel);
        }
    }
}

#pragma mark --- 统一处理失败回调
- (void)_handleFailRequestURLTask:(NSURLSessionTask *)task responseError:(NSError *)error failCallBack:(GGBaseRequestFailureResultBlock)failure {
//    NSString *mStr = [NSString stringWithFormat:@"\n\n\n----------------网络请求失败----------------\n域名:\n%@\n路径:\n%@\n公共参数:\n%@\n独立参数:\n%@\n错误:%@\n\n\n", [self baseUrl], [self requestUrl], [GGNetWorkManager share].commenParameters, [self requestArgument], error.localizedDescription];
    NSString *mStr = [NSString stringWithFormat:@"\n\n\n----------------网络请求失败----------------\n域名:\n%@\n路径:\n%@\n参数:\n%@\n错误:%@\n\n\n", [self baseUrl], [self requestUrl], [self requestArgument], error.localizedDescription];
    
    QMUILog(nil, @"%@", mStr);
//    QMUILog(nil, @"\n\n\n----------------网络请求失败----------------\nurl:%@\nparam:%@\nerror:%@\n----------------网络请求失败----------------\n\n\n", [self requestUrl], , error.localizedDescription);
    
    if (!self.doNotAutoShowRequestFailMessage) {
        [QMUITips showError:@"请检查网络设置"];
    }
    
    if (failure) {
        failure(error);
    }
}

@end
















@implementation GGBaseRequestReslutModel

- (BOOL)isRequestSuccessed {
    return _responseStatus == Successed_GGApiResponseStatus;
}

- (BOOL)isLoadToLastPage {
    if ([_responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)_responseObject;
        
        if ([dict containsObjectForKey:@"current_page"] && [dict containsObjectForKey:@"last_page"]) {
            NSNumber *current_page = dict[@"current_page"];
            NSNumber *last_page = dict[@"last_page"];
            
            if (current_page && last_page) {
                BOOL isLast = current_page.integerValue >= last_page.integerValue;
                
                return isLast;
            } else {
                QMUILog(nil, @"判断是否最后一页失败，接口没返回对应的key");
                return NO;
            }
        } else if ([dict containsObjectForKey:@"current"] && [dict containsObjectForKey:@"total"] && ([dict containsObjectForKey:@"limit"] || [dict containsObjectForKey:@"size"])) {
            NSNumber *current_page = dict[@"current"];
            NSNumber *total = dict[@"total"];
            NSNumber *limit = dict[@"limit"] ? : dict[@"size"];
            
            if (current_page && total && limit) {
                BOOL isLast = current_page.integerValue * limit.integerValue >= total.integerValue;
                
                return isLast;
            } else {
                QMUILog(nil, @"判断是否最后一页失败，responseObject 不是字典类型");
                return NO;
            }
        } else if ([dict containsObjectForKey:@"load"]) {
            // 这里的load是指能否加载下一页
            NSNumber *load = dict[@"load"];
            
            BOOL isLasPage = !load.boolValue;
            
            return isLasPage;
        } else {
            QMUILog(nil, @"判断是否最后一页失败，接口没返回对应的key");
        }
    } else {
        QMUILog(nil, @"判断是否最后一页失败，responseObject 不是字典类型");
    }
    
    return NO;
}

- (BOOL)jugeSussessAndToastMessageIfNeed {
    return [self _jugeSussessAndToastForSuccess:YES failToast:YES];
}

- (BOOL)jugeSussessAndToastOnlyForFail {
    return [self _jugeSussessAndToastForSuccess:NO failToast:YES];
}

- (BOOL)_jugeSussessAndToastForSuccess:(BOOL)successToast failToast:(BOOL)failToast {
    if (self.isRequestSuccessed && successToast) {
        if (_message.length) {
            if ([[_message lowercaseString] containsString:@"success"]) {
                [QMUITips showSucceed:@"操作成功"];
            } else {
                [QMUITips showSucceed:_message];
            }
        } else {
            [QMUITips showSucceed:@"操作成功"];
        }
    }
    
    if (!self.isRequestSuccessed && failToast) {
        if (_message.length) {
            if ([[_message lowercaseString] containsString:@"failed"]) {
                [QMUITips showError:@"操作失败"];
            } else {
                [QMUITips showError:_message];
            }
        } else {
            [ProgressHUD showError:@"操作失败"];
        }
    }
    
    return self.isRequestSuccessed;
}

@end
