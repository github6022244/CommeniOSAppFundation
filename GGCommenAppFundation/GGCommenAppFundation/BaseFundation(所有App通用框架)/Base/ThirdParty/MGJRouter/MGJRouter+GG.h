//
//  MGJRouter+GG.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/24.
//

#import "MGJRouter.h"
#import "MGJRouterGGDefine.h"
#import "MGJRouterParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface MGJRouter (GG)

// 正常功能
+ (void)gg_registerURLPattern:(NSString *)URLPattern toHandler:(GGMGJRouterHandler)handler;

+ (void)gg_registerURLPattern:(NSString *)URLPattern toObjectHandler:(GGMGJRouterObjectHandler)handler;

+ (void)gg_openURL:(NSString *)URL completion:(GGMGJRouterCompletion _Nullable)completion;

+ (void)gg_openURL:(NSString *)URL withParam:(MGJRouterParam * _Nullable)param completion:(GGMGJRouterCompletion _Nullable)completion;

+ (id)gg_objectForURL:(NSString *)URL;

+ (id)gg_objectForURL:(NSString *)URL withUserInfo:(NSDictionary * _Nullable)userInfo;

// 提供一个根据 MGJRouterParam 的配置跳转页面的方法
+ (void)gg_openController:(UIViewController *)vc param:(MGJRouterParam *)param;

@end

NS_ASSUME_NONNULL_END
