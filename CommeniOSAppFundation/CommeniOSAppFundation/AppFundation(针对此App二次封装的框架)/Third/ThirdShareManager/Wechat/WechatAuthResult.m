//
//  WechatAuthResult.m
//  CXGrainStudentApp
//
//  Created by User on 2020/8/17.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import "WechatAuthResult.h"

@implementation WechatAuthResult

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.openID = @"";
        self.accessToken = @"";
        self.refreshToken = @"";
        self.scope = @"";
        self.expiresIn = @"";
        self.originAuthInfo = nil;
    }
    return self;
}


@end
