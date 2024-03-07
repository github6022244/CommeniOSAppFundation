//
//  NSDate+GG.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/12/28.
//

#import "NSDate+GG.h"

static NSString *countDownTimerKey = @"NSDate+GGCountDown";

@implementation NSDate (GG)

#pragma mark --- 倒计时计算剩余支付时间
- (void)startCountLeftPayTimeWithCountDownTimerKey:(NSString *)key configBlock:(void(^)(void))configBlock handle:(LSTTimerChangeBlock)handle
                                            finish:(LSTTimerFinishBlock)finishBlock
                                             pause:(LSTTimerPauseBlock)pauseBlock {
    NSTimeInterval leftPayTime = [self pv_reCountLeftPayTime];
    
    if (leftPayTime < 0) {
        if (finishBlock) {
            finishBlock(key);
        }
        
        return;
    }
    
    key = key ? : countDownTimerKey;
    
    [LSTTimer removeTimerForIdentifier:key];
    
    @ggweakify(self)
    [LSTTimer setNotificationForName:key identifier:key changeNFType:LSTTimerSecondChangeNFTypeSecond];
    
    if (configBlock) {
        configBlock();
    }
    
    [LSTTimer addTimerForTime:leftPayTime identifier:key handle:handle finish:finishBlock
     pause:pauseBlock];
}

#pragma mark --- 计算剩余支付时间
- (NSTimeInterval)pv_reCountLeftPayTime {
//    NSDate *finishDate = [[NSDate dateWithTimeIntervalSince1970:(_createTime.integerValue / 1000)] dateByAddingDays:1];
//    _leftPayTime = [finishDate timeIntervalSinceDate:[NSDate date]];
    NSDate *finishDate = self;
//    [NSDate dateWithString:self.detailModel.order_expir_time format:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval leftPayTime = [finishDate timeIntervalSinceDate:[NSDate date]];
    
//    NSString *str = [NSString mr_timeStringWithMinsAndSecsFromSecs:leftPayTime format:@"%@时%@分"];
    
    return leftPayTime;
}

#pragma mark --- 转换东八区时间
- (NSDate *)changeToDongBaZoneTime {
    NSDate *currentDate = self;
    
    NSTimeZone *localTimeZone = [NSDate dongBaTimeZone];
    
    NSTimeInterval timeIn = [currentDate timeIntervalSince1970];

    NSInteger interval = [localTimeZone secondsFromGMTForDate:currentDate];

    NSDate *localDate = [currentDate dateByAddingTimeInterval:interval];
    
    return localDate;
}

#pragma mark --- 获取东八区zone
+ (NSTimeZone *)dongBaTimeZone {
    NSTimeZone *localTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    return localTimeZone;
}

@end
