//
//  CountdownTimer.h
//  https://www.jianshu.com/p/58b431ad14d4
//
//  Created by wu, hao on 2019/10/28.
//  Copyright © 2019 wuhao. All rights reserved.
//  https://github.com/remember17/CountdownTimer

#import <Foundation/Foundation.h>

// 当需要一个倒计时的时候就在这里加一个key
typedef enum : NSUInteger {
    
    verificationCodeTeacherTimer = 0,
    verificationCodeStudentTimer,
    verificationCodeChangePhoneNumTimer,
    
    // 登录遇到问题 更换手机号
    loginProblemChangeMobileTimer,
    
    // 验证码登录--设置密码
    setPasswordSendVcodeTimer,
    
    studentPaymentBindAccountSendVcodeTimer,
    userSignOutAccountSendVcodeTimer,
    
    // 调用小程序支付
    wechatMiniProgremPaymentTimer,
    
    // 积分任务：浏览电子书
    integralTaskBrowserEbook,
    
    // 积分任务：查看课程资源
    integralTaskBrowserCourseResource,
    
    // 积分任务：浏览教材
    integralTaskBrowserTextbook,
    
    // 积分任务：查看动态
    integralTaskBrowserDynamics,
    
    // 积分任务：查看云展活动
    integralTaskBrowserActivity,
    
    // 积分任务：查看出版社
    integralTaskBrowserPress
    
} CountdownKey;

typedef void(^CountdownCallback)(NSInteger count, BOOL isFinished);

@interface CountdownTimer : NSObject

+ (instancetype)shared;
//实例化存储验证码页面手机号
@property (nonatomic, copy) NSString *teacherPhoneNum;
@property (nonatomic, copy) NSString *studentPhoneNum;
@property (nonatomic, copy) NSString *changePhoneNum;


/**
 开启某个倒计时
 
 @param key 倒计时key
 @param count 倒计时长
 @param callback 回调
 */
+ (void)startTimerWithKey:(CountdownKey)key
                    count:(NSInteger)count
                 callBack:(CountdownCallback)callback;

/**
 停止一个倒计时
 
 @param key 倒计时key
 */
+ (void)stopTimerWithKey:(CountdownKey)key;

/**
 继续某个倒计时
 
 @param key 倒计时key
 @param callback 回调
 */
+ (void)continueTimerWithKey:(CountdownKey)key
                     callBack:(CountdownCallback)callback;

/**
 判断某个倒计时是否已经完成
 
 @param key 倒计时key
 @return 倒计时是否完成
 */
+ (BOOL)isFinishedTimerWithKey:(CountdownKey)key;

@end
