//
//  YTKAnimatingRequestAccessory.m
//  Ape_uni
//
//  Created by Chenyu Lan on 10/30/14.
//  Copyright (c) 2014 Fenbi. All rights reserved.
//

#import "YTKAnimatingRequestAccessory.h"
#import "GGNetWorkManager.h"
#import "GGNetWorkHelper.h"

/// 默认的 parentView
#define YTKAnimatingDefaultTipsParentView [GGNetWorkHelper getKeyWindow]

@interface YTKAnimatingRequestAccessory ()

@property (nonatomic, strong) id<GGNetWorkManagerLoadingProtocol> loadingHUD;

@end

@implementation YTKAnimatingRequestAccessory

- (id)initWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
        _animatingText = animatingText;
        _loadingHUD = [[GGNetWorkManager share].configModel gg_getLoadingModel];
    }
    return self;
}

- (id)initWithAnimatingView:(UIView *)animatingView {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
    }
    return self;
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView {
    return [[self alloc] initWithAnimatingView:animatingView];
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    return [[self alloc] initWithAnimatingView:animatingView animatingText:animatingText];
}

- (void)requestWillStart:(id)request {
    // TODO: show loading
    if (_animatingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadingHUD gg_configShowLoadingText:self.animatingText inView:self.animatingView];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadingHUD gg_configShowLoadingText:self.animatingText inView:YTKAnimatingDefaultTipsParentView];
        });
    }
}

- (void)requestWillStop:(id)request {
    // TODO: hide loading
    if (self.loadingHUD) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadingHUD gg_configHideLoading];
        });
    }
}

@end
