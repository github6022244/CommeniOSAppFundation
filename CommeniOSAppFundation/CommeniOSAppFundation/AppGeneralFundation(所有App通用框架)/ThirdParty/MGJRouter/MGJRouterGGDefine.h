//
//  MGJRouterGGDefine.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/27.
//

#import <Foundation/Foundation.h>
@class MGJRouterParam;

/**
 *  routerParameters 里内置的几个参数会用到上面定义的 string
 */
typedef void (^GGMGJRouterHandler)(NSDictionary * _Nullable routerParameters, MGJRouterParam *_Nullable param);

/**
 *  需要返回一个 object，配合 objectForURL: 使用
 */
typedef id _Nullable (^GGMGJRouterObjectHandler)(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param);

// openURL completion
typedef void (^GGMGJRouterCompletion)(id _Nullable data);









// [MGJRouter openUrl:...] 的功能
typedef NS_ENUM(NSUInteger, MGJRouterParamFunction) {
    MGJRouterParamFunction_None, // 默认没有功能
    MGJRouterParamFunction_PastParamOrGetObject, // 传递参数 || 获取值
    MGJRouterParamFunction_ShowController, // 跳转新控制器
};

// 跳转页面的方式
typedef NS_ENUM(NSUInteger, MGJRouterParamShowNewControllerWay) {
    MGJRouterParamShowNewControllerWay_Automatic,// 自动判断(与上一个控制器展示方式相同)
    MGJRouterParamShowNewControllerWay_Push, // psuh 新控制器
    MGJRouterParamShowNewControllerWay_Present, // present 新控制器
    MGJRouterParamShowNewControllerWay_NewWindowRootController, // 直接设置window根控制器
};
