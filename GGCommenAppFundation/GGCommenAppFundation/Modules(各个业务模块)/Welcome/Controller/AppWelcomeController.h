//
//  AppWelcomeController.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/30.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "GGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppWelcomeController : GGBaseViewController

@property (nonatomic, copy) void(^enterBlock)(void);

- (instancetype)initWithEnterBlock:(void(^)(void))enterBlock;

@end

NS_ASSUME_NONNULL_END
