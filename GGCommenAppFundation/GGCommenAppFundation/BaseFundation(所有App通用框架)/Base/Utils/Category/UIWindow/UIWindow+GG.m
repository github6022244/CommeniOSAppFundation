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

@end
