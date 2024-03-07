//
//  WechatAuthResult.h
//  CXGrainStudentApp
//
//  Created by User on 2020/8/17.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WechatAuthResult : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *openID;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *expiresIn;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *scope;
// 原始数据(如果以上信息不能满足开发要求，则可以用此属性)
@property (nonatomic, strong, nullable) NSDictionary *originAuthInfo;

@end

NS_ASSUME_NONNULL_END
