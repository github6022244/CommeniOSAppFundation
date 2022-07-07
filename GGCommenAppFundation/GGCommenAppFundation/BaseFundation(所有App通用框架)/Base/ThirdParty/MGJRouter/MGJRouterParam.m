//
//  MGJRouterParam.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/24.
//

#import "MGJRouterParam.h"
#import <MJExtension.h>
#import "MGJRouter.h"

@implementation MGJRouterParam

MJLogAllIvars

- (NSMutableDictionary *)keyValues {
    NSMutableDictionary *mDict = self.mj_keyValues;
    
    mDict[@"senderData"] = [_senderData keyValues];
    
    return mDict;
}

+ (MGJRouterParam *)objectWithKeyValues:(NSDictionary *)keyValues {
    NSMutableDictionary *mDict_param = keyValues[MGJRouterParameterUserInfo];
    
    MGJRouterParam *param = [MGJRouterParam mj_objectWithKeyValues:mDict_param];
    param.parameterURL = keyValues[MGJRouterParameterURL];
    param.senderData.completion = keyValues[MGJRouterParameterCompletion];
    
    return param;
}

+ (MGJRouterParam *)objectWithData:(NSDictionary * _Nullable)data {
    return [MGJRouterParam objectWithFunctionType:MGJRouterParamFunction_PastParamOrGetObject preController:nil theWayToShowController:-1 data:data url:nil];
}

+ (MGJRouterParam *)objectWithPreController:(UIViewController *)preController theWayToShowController:(MGJRouterParamShowNewControllerWay)theWayToShowController data:(NSDictionary * _Nullable)data {
    return [MGJRouterParam objectWithFunctionType:MGJRouterParamFunction_ShowController preController:preController theWayToShowController:theWayToShowController data:data url:nil];
}

+ (MGJRouterParam *)objectWithFunctionType:(MGJRouterParamFunction)functionType preController:(UIViewController * _Nullable)preController theWayToShowController:(MGJRouterParamShowNewControllerWay)theWayToShowController data:(NSDictionary * _Nullable)data url:(NSString * _Nullable)url {
    MGJRouterParam *param = [MGJRouterParam new];
    
    param.functionType = functionType;
    param.senderData.theWayToShowController = theWayToShowController;
    param.senderData.preController = preController;
    param.senderData.data = data;
    param.parameterURL = url;
    
    return param;
}

- (MGJRouterParamSenderData *)senderData {
    if (!_senderData) {
        _senderData = [MGJRouterParamSenderData new];
    }
    
    return _senderData;
}

- (MGJRouterParamReciverData *)reciverData {
    if (!_reciverData) {
        _reciverData = [MGJRouterParamReciverData new];
    }
    
    return _reciverData;
}

@end













@implementation MGJRouterParamSenderData

MJLogAllIvars

/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (NSMutableArray *)mj_totalIgnoredPropertyNames {
    return @[
        @"preController",
    ].mutableCopy;
}

- (NSMutableDictionary *)keyValues {
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:self.mj_keyValues];
    
    if (_preController) {
        mDict[@"preController"] = _preController;
    }
    
    if (_completion) {
        mDict[@"completion"] = _completion;
    }
    
    return mDict;
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    if ([keyValues.allKeys containsObject:@"preController"]) {
        _preController = keyValues[@"preController"];
    }
}

@end














@implementation MGJRouterParamReciverData

@end

