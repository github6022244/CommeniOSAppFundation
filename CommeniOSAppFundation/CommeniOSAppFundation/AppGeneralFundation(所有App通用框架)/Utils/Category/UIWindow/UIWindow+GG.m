//
//  UIWindow+GG.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/1.
//

#import "UIWindow+GG.h"

@implementation UIWindow (GG)

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

/// 倒序获取 window
+ (UIWindow *)_getLastWindowInWindowsArray {
    NSArray *windowsArray = [[[[UIApplication sharedApplication] windows] reverseObjectEnumerator] allObjects];
    
    for (UIWindow *window in windowsArray) {
        if (window.isKeyWindow) {
            return window;
        }
    }
    
    return windowsArray.lastObject;
}

@end
