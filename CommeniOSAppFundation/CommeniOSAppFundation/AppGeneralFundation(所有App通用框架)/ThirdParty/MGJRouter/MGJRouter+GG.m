//
//  MGJRouter+GG.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/24.
//

#import "MGJRouter+GG.h"
#import "UIViewController+GG.h"
#import "UIWindow+GG.h"

#ifdef DEBUG
#define MGJRouterLog(...) NSLog(__VA_ARGS__)
#else
#define MGJRouterLog(...)
#endif

@implementation MGJRouter (GG)

+ (void)gg_registerURLPattern:(NSString *)URLPattern toHandler:(GGMGJRouterHandler)handler {
    [MGJRouter registerURLPattern:URLPattern toHandler:^(NSDictionary *routerParameters) {
        if (handler) {
            MGJRouterParam *param = [MGJRouterParam objectWithKeyValues:routerParameters];
            
            NSLog(@"\n%@", routerParameters);
            
            handler(routerParameters, param);
        }
    }];
}

+ (void)gg_registerURLPattern:(NSString *)URLPattern toObjectHandler:(GGMGJRouterObjectHandler)handler {
    [MGJRouter registerURLPattern:URLPattern toObjectHandler:^id(NSDictionary *routerParameters) {
        if (handler) {
            MGJRouterParam *param = [MGJRouterParam objectWithKeyValues:routerParameters];
            
            return handler(routerParameters, param);
        } else {
            return nil;
        }
    }];
}

+ (void)gg_openURL:(NSString *)URL completion:(GGMGJRouterCompletion)completion {
    [MGJRouter openURL:URL completion:completion];
}

+ (void)gg_openURL:(NSString *)URL withParam:(MGJRouterParam *)param completion:(GGMGJRouterCompletion)completion {
    NSDictionary *dict_param = [param keyValues];
    
    [MGJRouter openURL:URL withUserInfo:dict_param completion:completion];
}

+ (id)gg_objectForURL:(NSString *)URL {
    return [MGJRouter objectForURL:URL];
}

+ (id)gg_objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo {
    MGJRouterParam *param = [MGJRouterParam objectWithData:userInfo];
    
    return [MGJRouter objectForURL:URL withUserInfo:[param keyValues]];
}

// 提供一个根据 MGJRouterParam 的配置跳转页面的方法
+ (void)gg_openController:(UIViewController *)openTargetVC param:(MGJRouterParam *)param {
    if (!openTargetVC) {
        MGJRouterLog(@"openTargetVC 为空");
        return;
    }
    
    if (!param.senderData.preController) {
        MGJRouterLog(@"preController 为空");
        return;
    }
    
    switch (param.senderData.theWayToShowController) {
        case MGJRouterParamShowNewControllerWay_Automatic: {
            [param.senderData.preController showControllerInSameWay:openTargetVC animated:YES block:nil];
        }
            break;
        case MGJRouterParamShowNewControllerWay_Push: {
            [param.senderData.preController.navigationController pushViewController:openTargetVC animated:YES];
        }
            break;
        case MGJRouterParamShowNewControllerWay_Present: {
            dispatch_async(dispatch_get_main_queue(), ^{
                [param.senderData.preController presentViewController:openTargetVC animated:YES completion:nil];
            });
        }
            break;
        case MGJRouterParamShowNewControllerWay_NewWindowRootController: {
            UIWindow *keyWindow = [UIWindow getKeyWindow];
            dispatch_async(dispatch_get_main_queue(), ^{
                keyWindow.rootViewController = openTargetVC;
            });
        }
            break;
        default:
            break;
    }
}

@end
