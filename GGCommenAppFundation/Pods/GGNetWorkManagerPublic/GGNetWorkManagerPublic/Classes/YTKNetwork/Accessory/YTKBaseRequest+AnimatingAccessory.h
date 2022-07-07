//
// Created by Chenyu Lan on 10/30/14.
// Copyright (c) 2014 Fenbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YTKBaseRequest.h"

@interface YTKBaseRequest (AnimatingAccessory)

@property (nonatomic, assign) BOOL doNotShowHUD;

@property (weak, nonatomic) UIView *animatingView;

@property (strong, nonatomic) NSString *animatingText;

@end
