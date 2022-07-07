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
    if (@available(iOS 15, *)) {
      __block UIScene * _Nonnull tmpSc;
       [[[UIApplication sharedApplication] connectedScenes] enumerateObjectsUsingBlock:^(UIScene * _Nonnull obj, BOOL * _Nonnull stop) {
           if (obj.activationState == UISceneActivationStateForegroundActive) {
               tmpSc = obj;
               *stop = YES;
           }
       }];
       UIWindowScene *curWinSc = (UIWindowScene *)tmpSc;
        
        UIWindow *rWindow = curWinSc.keyWindow;
        
        if (rWindow) {
            return rWindow;
        } else {
            return [[UIApplication sharedApplication] windows].lastObject;
        }
    } else if (@available(iOS 13, *)) {
        __block UIScene * _Nonnull tmpSc;
         [[[UIApplication sharedApplication] connectedScenes] enumerateObjectsUsingBlock:^(UIScene * _Nonnull obj, BOOL * _Nonnull stop) {
             if (obj.activationState == UISceneActivationStateForegroundActive) {
                 tmpSc = obj;
                 *stop = YES;
             }
         }];
         UIWindowScene *curWinSc = (UIWindowScene *)tmpSc;
          
          UIWindow *rWindow = [curWinSc valueForKeyPath:@"delegate.window"];
          
          if (rWindow) {
              return rWindow;
          } else {
              return [[UIApplication sharedApplication] windows].lastObject;
          }
    }
    else {
       return [UIApplication sharedApplication].keyWindow;
   }
}

#pragma mark --- 获取打印网络请求字符串
+ (NSString *)getStringToLogRequest:(YTKBaseRequest *)request forRequestFail:(BOOL)forRequestFail appendString:(NSString *)appendString {
    // 获取所有参数
    NSMutableDictionary *totalParam = [NSMutableDictionary dictionaryWithDictionary:[GGNetWorkManager share].commenParameters];
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
        
        NSMutableString *mStr = [NSString stringWithFormat:@"\n\n\n!!!!!!!!!!!!!!!!!!网络请求!!!!!!!!!!!!!!!!!!!\n域名:\n%@\n路径:\n%@\n公共参数:\n%@\n独立参数:\n%@\n请求接口所在的页面 :\n%@\n", baseUrl, [request requestUrl], [GGNetWorkManager share].commenParameters, [request requestArgument], targetName].mutableCopy;
        
        if (appendString) {
            [mStr appendFormat:@"%@\n", appendString];
        }
        
        [mStr appendString:@"!!!!!!!!!!!!!!!!!!网络请求!!!!!!!!!!!!!!!!!!!\n\n\n"];
        
        return mStr;
    }
}

@end
