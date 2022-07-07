//
// Created by Chenyu Lan on 10/30/14.
// Copyright (c) 2014 Fenbi. All rights reserved.
//

#import "YTKBaseRequest+AnimatingAccessory.h"
#import "YTKAnimatingRequestAccessory.h"


@implementation YTKBaseRequest (AnimatingAccessory)

- (YTKAnimatingRequestAccessory *)animatingRequestAccessory {
    for (id accessory in self.requestAccessories) {
        if ([accessory isKindOfClass:[YTKAnimatingRequestAccessory class]]){
            return accessory;
        }
    }
    return nil;
}

- (UIView *)animatingView {
    return self.animatingRequestAccessory.animatingView;
}

- (void)setAnimatingView:(UIView *)animatingView {
    if (!self.animatingRequestAccessory) {
        [self addAccessory:[YTKAnimatingRequestAccessory accessoryWithAnimatingView:animatingView animatingText:nil]];
    } else {
        self.animatingRequestAccessory.animatingView = animatingView;
    }
}

- (NSString *)animatingText {
    return self.animatingRequestAccessory.animatingText;
}

- (void)setAnimatingText:(NSString *)animatingText {
    if (!self.animatingRequestAccessory) {
        [self addAccessory:[YTKAnimatingRequestAccessory accessoryWithAnimatingView:nil animatingText:animatingText]];
    } else {
        self.animatingRequestAccessory.animatingText = animatingText;
    }
}

- (void)setDoNotShowHUD:(BOOL)doNotShowHUD {
    if (doNotShowHUD && [self.requestAccessories containsObject:self.animatingRequestAccessory]) {
        [self.requestAccessories removeObject:self.animatingRequestAccessory];
    } else if (!doNotShowHUD) {
        if (!self.animatingRequestAccessory) {
            [self addAccessory:[YTKAnimatingRequestAccessory accessoryWithAnimatingView:nil animatingText:nil]];
        }
    }
}

- (BOOL)doNotShowHUD {
    return self.animatingRequestAccessory ? NO : YES;
}

@end
