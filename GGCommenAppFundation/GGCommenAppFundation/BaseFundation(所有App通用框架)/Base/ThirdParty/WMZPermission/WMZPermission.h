//
//  WMZPermission.h
//  WMZPermission
//
//  Created by wmz on 2018/12/10.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//权限类型
typedef enum : NSUInteger{
    PermissionTypeCamera = 0,           //相机权限
    PermissionTypePhoto = 1,            //相册权限
    PermissionTypeLocationWhen = 4,     //位置权限(使用中)
    PermissionTypeLocationAlways = 3,   //位置权限(一直使用)
}PermissionType;

typedef void (^callBack) (BOOL granted, id  data);

NS_ASSUME_NONNULL_BEGIN

@interface WMZPermission : NSObject

/*
 * 提示
 */
@property(nonatomic,strong)NSString *tip;

/*
 * 单例
 */
+ (instancetype)shareInstance;

/*
 * 获取权限
 * @param  type       类型
 * @param  block      回调
 */
- (void)permissonType:(PermissionType)type withHandle:(callBack)block;


@end

NS_ASSUME_NONNULL_END
