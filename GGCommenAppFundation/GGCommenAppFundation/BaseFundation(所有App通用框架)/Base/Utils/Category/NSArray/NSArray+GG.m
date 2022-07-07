//
//  NSArray+GG.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/15.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "NSArray+GG.h"

@implementation NSArray (GG)

- (id)gg_safeObjectAtIndex:(NSInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    
    return nil;
}

@end
