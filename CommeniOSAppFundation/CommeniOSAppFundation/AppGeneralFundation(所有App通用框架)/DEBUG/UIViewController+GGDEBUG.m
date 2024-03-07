//
//  UIViewController+GGDEBUG.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/24.
//

#import "UIViewController+GGDEBUG.h"
#import <objc/runtime.h>
#import <QMUIRuntime.h>

@implementation UIViewController (GGDEBUG)

#pragma mark ------------------------- Override -------------------------
+ (void)load {
#ifdef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(viewDidAppear:), @selector(gg_viewDidAppear:));
    });
#endif
}

- (void)gg_viewDidAppear:(BOOL)animated {
    if ([self conformsToProtocol:@protocol(GGUIBaseViewControllerDebugProtocol)]) {
        
        BOOL debugLog = NO;
        
        if ([self respondsToSelector:@selector(debugLogClassName)]) {
            debugLog = [self performSelector:@selector(debugLogClassName)];
        }
        
        if (debugLog) {
            NSString *logClassName = NSStringFromClass([self class]);
            
            if ([self respondsToSelector:@selector(customDebugLogClassName)]) {
                logClassName = [self performSelector:@selector(customDebugLogClassName)];
            }
            
            QMUILog(nil, @"\n\n\n========================\n控制器类名：%@\n========================\n\n\n", logClassName);
        }
    }
    
    [self gg_viewDidAppear:animated];
}

@end
