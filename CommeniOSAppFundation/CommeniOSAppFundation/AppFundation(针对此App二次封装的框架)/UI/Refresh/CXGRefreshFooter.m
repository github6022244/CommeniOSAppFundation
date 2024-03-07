//
//  CXGRefreshFooter.m
//  CXGrainStudentApp
//
//  Created by GG on 2022/3/8.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "CXGRefreshFooter.h"

@implementation CXGRefreshFooter

- (void)prepare {
    [super prepare];
    
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"暂无更多~" forState:MJRefreshStateNoMoreData];
    
    self.refreshingTitleHidden = YES;
    self.stateLabel.hidden = NO;
    
    self.stateLabel.font = UIFontMake(14.f);
}

@end
