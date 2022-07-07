//
//  MGJRouterParam.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MGJRouterGGDefine.h"

@class MGJRouterParamSenderData;
@class MGJRouterParamReciverData;

NS_ASSUME_NONNULL_BEGIN

@interface MGJRouterParam : NSObject

@property (nonatomic, assign) MGJRouterParamFunction functionType;// 功能类型

@property (nonatomic, copy) NSString *parameterURL;// url

@property (nonatomic, strong) MGJRouterParamSenderData *senderData;// 需向下传递的参数

@property (nonatomic, strong) MGJRouterParamReciverData *reciverData;// 返回传递参数

// 框架内部使用的方法
/// @Private
- (NSMutableDictionary *)keyValues;
/// @Private
+ (MGJRouterParam *)objectWithKeyValues:(NSDictionary *)keyValues;

// 创建方法
/// @Public 适用于传值、获取值
+ (MGJRouterParam *)objectWithData:(NSDictionary * _Nullable)data;

/// @Public 适用于跳转页面
+ (MGJRouterParam *)objectWithPreController:(UIViewController * _Nullable)preController theWayToShowController:(MGJRouterParamShowNewControllerWay)theWayToShowController data:(NSDictionary * _Nullable)data;

/// @Public 全的
+ (MGJRouterParam *)objectWithFunctionType:(MGJRouterParamFunction)functionType preController:(UIViewController * _Nullable)preController theWayToShowController:(MGJRouterParamShowNewControllerWay)theWayToShowController data:(NSDictionary * _Nullable)data url:(NSString * _Nullable)url;

@end

NS_ASSUME_NONNULL_END








@interface MGJRouterParamSenderData : NSObject

@property (nonatomic, strong) UIViewController * _Nullable preController;// 需要 push / present 新控制器的视图

@property (nonatomic, assign) MGJRouterParamShowNewControllerWay theWayToShowController;// 展示控制器的方式

@property (nonatomic, strong) NSDictionary * _Nullable data;// 自定义参数

@property (nonatomic, copy) GGMGJRouterCompletion _Nullable completion;

- (NSMutableDictionary * _Nullable)keyValues;

@end












@interface MGJRouterParamReciverData : NSObject

@end







