//
//  GGNetWorkHelper.m
//  GGNetWorkManager
//
//  Created by GG on 2022/5/19.
//

#import "GGNetWorkHelper.h"
#import "GGNetWorkManager.h"
#import "YTKBaseRequest+AnimatingAccessory.h"
#import <YTKNetwork/YTKNetworkConfig.h>

@implementation GGNetWorkHelper

#pragma mark ------------------------- Interface -------------------------
#pragma mark --- 获取根window
+ (UIWindow *)getKeyWindow {
    if (@available(iOS 13, *)) {
        UIWindow *window = nil;
        
        UIScene * _Nonnull tmpSc = nil;
        for (UIScene *obj in [[UIApplication sharedApplication] connectedScenes]) {
            if (obj.activationState == UISceneActivationStateForegroundActive) {
                tmpSc = obj;
                break;
            }
        }
        
        UIWindowScene *curWinSc = (UIWindowScene *)tmpSc;
        
        for (UIWindow *w in curWinSc.windows) {
            if (w.isKeyWindow) {
                window = w;
            }
        }
          
        if (window) {
            return window;
        } else {
            NSLog(@"\n没有在 Scenes 中找到 window, 从 Application windows 中查找 keyWindow");
            return [self _getLastWindowInWindowsArray];
        }
    } else {
        NSLog(@"\n iOS 13 以下从 Application windows 中查找 keyWindow");
       return [self _getLastWindowInWindowsArray];
   }
}

/// 获取 window
+ (UIWindow *)_getLastWindowInWindowsArray {
    NSArray *windowsArray = [[UIApplication sharedApplication] windows];
    
    for (UIWindow *window in windowsArray) {
        if (window.isKeyWindow) {
            return window;
        }
    }
    
    return windowsArray.firstObject;
}

#pragma mark --- 获取打印网络请求字符串
+ (NSString *)getStringToLogRequest:(YTKBaseRequest *)request forRequestFail:(BOOL)forRequestFail appendString:(NSString *)appendString {
    // 获取所有参数
    NSMutableDictionary *totalParam = [NSMutableDictionary dictionaryWithDictionary:[GGNetWorkManager share].commonParameters];
    [totalParam addEntriesFromDictionary:[request requestArgument]];
    
    if (forRequestFail) {
        // 失败格式
        NSMutableString *mStr = [NSString stringWithFormat:@"\n\n\n----------------网络请求失败----------------\nurl:\n%@\n参数:\n%@\nerror:\n%@\nerror code:\n%ld\n", request.currentRequest.URL.absoluteString, totalParam, request.error.localizedDescription, (long)request.error.code].mutableCopy;
        
        if (appendString) {
            [mStr appendFormat:@"%@\n", appendString];
        }
        
        [mStr appendString:@"----------------网络请求失败----------------\n\n\n"];
        
        return mStr;
    } else {
        // 其他格式
        
        // 获取 animatingView 所在控制器或者 window
        UIView *animatingView = request.animatingView;
        NSString *targetName = @"未指定，默认Window";
        if (animatingView && ![animatingView isKindOfClass:[UIWindow class]]) {
            while (animatingView.nextResponder) {
                if ([animatingView.nextResponder isKindOfClass:[UIViewController class]]) {
                    UIViewController *vc = (UIViewController *)animatingView.nextResponder;
                    targetName = NSStringFromClass([vc class]);
                    break;
                } else if ([animatingView.nextResponder isKindOfClass:[UIWindow class]]) {
                    break;
                }
                
                animatingView = animatingView.superview;
            }
        }
        
        // 获取域名
        NSString *baseUrl;
        if ([request useCDN]) {
            if ([request cdnUrl].length > 0) {
                baseUrl = [request cdnUrl];
            } else {
                baseUrl = [[YTKNetworkConfig sharedConfig] cdnUrl];
            }
        } else {
            if ([request baseUrl].length > 0) {
                baseUrl = [request baseUrl];
            } else {
                baseUrl = [[YTKNetworkConfig sharedConfig] baseUrl];
            }
        }
        
        /// 获取独立参数
        /// 独立参数获取方式为 request 的 -(id)requestArgument {} 方法
        /// 因为在合成请求对象的时候(YTKNetworkAgent+GGNetWork.m  重写了 addRequest: 方法)，为了拼接公共参数而重写了独立参数方法导致在
        /// 请求合成 -> 请求开始之前，调用这个获取独立参数方法的时候，返回的是包含 公共参数 + 独立参数 的字典
        /// 所以进行一个去除公共参数的操作，获取独立参数
        NSDictionary *commonParameters = [GGNetWorkManager share].commonParameters;
        
        NSDictionary *requestArgument = [request requestArgument];
        NSMutableDictionary *mDict = [NSMutableDictionary dictionary];

        if ([requestArgument isKindOfClass:[NSDictionary class]]) {
            [requestArgument enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                // 去重
                if (![commonParameters.allKeys containsObject:key]) {
                    [mDict setObject:obj forKey:key];
                }
            }];
        }
        
        // 正式拼接所有内容
        NSMutableString *mStr = [NSString stringWithFormat:@"\n\n\n!!!!!!!!!!!!!!!!!!网络请求!!!!!!!!!!!!!!!!!!!\n域名:\n%@\n路径:\n%@\n公共参数:\n%@\n独立参数:\n%@\n请求接口所在的页面 :\n%@\n", baseUrl, [request requestUrl], commonParameters, requestArgument, targetName].mutableCopy;
        
        if (appendString) {
            [mStr appendFormat:@"%@\n", appendString];
        }
        
        [mStr appendString:@"!!!!!!!!!!!!!!!!!!网络请求!!!!!!!!!!!!!!!!!!!\n\n\n"];
        
        return mStr;
    }
}

@end
