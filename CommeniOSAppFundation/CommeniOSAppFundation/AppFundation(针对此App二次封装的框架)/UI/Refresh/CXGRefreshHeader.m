//
//  CXGRefreshHeader.m
//  CXGrainStudentApp
//
//  Created by GG on 2022/3/8.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "CXGRefreshHeader.h"

@implementation CXGRefreshHeader

- (void)prepare {
    [super prepare];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.automaticallyChangeAlpha = YES;
}

@end
