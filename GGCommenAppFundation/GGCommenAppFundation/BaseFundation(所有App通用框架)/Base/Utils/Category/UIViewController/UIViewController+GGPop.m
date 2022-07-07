//
//  UIViewController+GGPop.m
//  ChangXiangGrain
//
//  Created by GG on 2022/3/14.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "UIViewController+GGPop.h"
#import <objc/runtime.h>

@implementation UIViewController (GGPop)

- (void)setGg_popTargetControllerClassName:(NSString *)gg_popTargetControllerClassName {
    objc_setAssociatedObject(self, @selector(gg_popTargetControllerClassName), gg_popTargetControllerClassName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)gg_popTargetControllerClassName {
    return objc_getAssociatedObject(self, _cmd);
}

@end
