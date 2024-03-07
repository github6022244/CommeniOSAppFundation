//
//  QQUserInfo.h
//  CXGrainStudentApp
//
//  Created by User on 2020/8/17.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQUserInfo : NSObject

/// 昵称
@property (nonatomic, copy, nullable) NSString *nickName;
/// 性别  0:未知   1:男  2:女
@property (nonatomic, assign) int sex;
/// 省份
@property (nonatomic, copy, nullable) NSString *province;
/// 城市
@property (nonatomic, copy, nullable) NSString *city;
/// 头像
@property (nonatomic, copy, nullable) NSString *headImgURL;
/// 原始数据(如果以上信息不能满足开发要求，则可以用此属性)
@property (nonatomic, strong, nullable) NSDictionary *originInfo;

@end

NS_ASSUME_NONNULL_END
