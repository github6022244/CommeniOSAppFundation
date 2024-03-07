//
//  NSTimer+GG.m
//  CXGLNewStudentApp
//
//  Created by GG on 2024/1/2.
//

#import "NSTimer+GG.h"

@implementation NSTimer (GG)

/// 倒计时
+ (void)ba_countDownTimeLength:(NSInteger)timeLength countBlock:(void(^)(NSInteger seconds))countBlock endBlock:(void(^)(void))endBlock {
    __block NSInteger time = timeLength - 1; //倒计时时间

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行

    dispatch_source_set_event_handler(_timer, ^{

        if (time <= 0) { //倒计时结束，关闭

            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{

//                //设置按钮的样式
//                [button setTitle:@"重新发送" forState:UIControlStateNormal];
//                [button setTitleColor:RGBColor(0xFB8557) forState:UIControlStateNormal];
//                button.userInteractionEnabled = YES;
                if (endBlock) {
                    endBlock();
                }
            });

        } else {

            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{

//                //设置按钮显示读秒效果
//                [button setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
//                [button setTitleColor:RGBColor(0x979797) forState:UIControlStateNormal];
//                button.userInteractionEnabled = NO;
                if (countBlock) {
                    countBlock(seconds);
                }
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
