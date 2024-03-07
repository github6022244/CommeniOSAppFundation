//
//  NSDate+GG.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/12/28.
//

#import <Foundation/Foundation.h>

#import "LSTTimer.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (GG)

#pragma mark --- 倒计时计算剩余支付时间
- (void)startCountLeftPayTimeWithCountDownTimerKey:(NSString *)key configBlock:(void(^)(void))configBlock handle:(LSTTimerChangeBlock)handle
                                            finish:(LSTTimerFinishBlock)finishBlock
                                             pause:(LSTTimerPauseBlock)pauseBlock;

#pragma mark --- 转换东八区时间
- (NSDate *)changeToDongBaZoneTime;
#pragma mark --- 获取东八区zone
+ (NSTimeZone *)dongBaTimeZone;

@end

NS_ASSUME_NONNULL_END
