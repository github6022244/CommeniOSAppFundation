//
//  NSTimer+GG.h
//  CXGLNewStudentApp
//
//  Created by GG on 2024/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (GG)

/// 倒计时
+ (void)ba_countDownTimeLength:(NSInteger)timeLength countBlock:(void(^)(NSInteger seconds))countBlock endBlock:(void(^)(void))endBlock;

@end

NS_ASSUME_NONNULL_END
