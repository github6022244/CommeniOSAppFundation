//
//  GGCommenDefine.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/2.
//  Copyright © 2020 ruikang. All rights reserved.
//

#ifndef GGCommenDefine_h
#define GGCommenDefine_h

#import <QMUICommonDefines.h>

// 判断是否是暗黑模式
#define GGAppThemeStyleIsDark (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark)

/**
 * 注意 :
 1. 搜索 - gg 来完善
 */
#pragma mark - 变量-编译相关

#ifndef ggweakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define ggweakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define ggweakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define ggweakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define ggweakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef ggstrongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define ggstrongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define ggstrongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define ggstrongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define ggstrongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


/// 使用iOS7 API时要加`ifdef IOS7_SDK_ALLOWED`的判断

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
#define IOS7_SDK_ALLOWED YES
#endif


/// 使用iOS8 API时要加`ifdef IOS8_SDK_ALLOWED`的判断

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
#define IOS8_SDK_ALLOWED YES
#endif


/// 使用iOS9 API时要加`ifdef IOS9_SDK_ALLOWED`的判断

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
#define IOS9_SDK_ALLOWED YES
#endif


/// 使用iOS10 API时要加`ifdef IOS10_SDK_ALLOWED`的判断

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#define IOS10_SDK_ALLOWED YES
#endif


/// 使用iOS11 API时要加`ifdef IOS11_SDK_ALLOWED`的判断

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
#define IOS11_SDK_ALLOWED YES
#endif

#pragma mark - 变量-布局相关

#define Scale(x, y, z) ((x) * (y) / (z))
#define ScaleScreenWidth(y, z) Scale(SCREEN_WIDTH, (y), (z))
#define ScaleScreenHeight(y, z, max) (SCREEN_HEIGHT > (max) ? (y) : Scale(SCREEN_HEIGHT, y, z))
#define kAppScaleFit(width, height) (IS_NOTCHED_SCREEN ? ((SCREEN_WIDTH < SCREEN_HEIGHT) ? SCREEN_WIDTH / width : SCREEN_WIDTH / height) : 1)// 屏幕比例
#pragma mark --- gg 根据UI图修改
#define kScaleFit kAppScaleFit(375.0, 667.0)

#pragma mark - 方法-创建器
//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

#import "NSString+Util.h"
#define NSStringTransformEmpty(x) [NSString transformEmptyString:x]
#define NSStringTransformEmptyWithPlaceholder(x, placeholder) NSStringTransformEmpty(x).length ? NSStringTransformEmpty(x) : placeholder

#endif /* GGCommenDefine_h */
