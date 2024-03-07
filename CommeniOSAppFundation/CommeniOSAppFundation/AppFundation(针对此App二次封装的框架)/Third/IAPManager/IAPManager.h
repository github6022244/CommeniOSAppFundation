//
//  IAPManager.h
//  CXGrainStudentApp
//
//  Created by User on 2020/8/27.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "XYStore.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RechargeReceiptResultBlock)(NSDictionary * _Nullable param);


@interface IAPManager : NSObject



+ (instancetype)sharedManager;
// 没用到这个方法
//- (void)requestRechargeCoinList;

- (void)requestProductInfoWithProductId:(NSString *)productId receiptBlock:(RechargeReceiptResultBlock)receiptBlock;

@end

NS_ASSUME_NONNULL_END
