//
//  NSArray+GG.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/15.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (GG)

- (id)gg_safeObjectAtIndex:(NSInteger)index;

- (NSString *)convertToJSONString;

@end

NS_ASSUME_NONNULL_END
