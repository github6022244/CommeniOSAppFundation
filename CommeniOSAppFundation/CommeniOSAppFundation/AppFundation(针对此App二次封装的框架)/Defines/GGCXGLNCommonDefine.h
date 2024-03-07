//
//  GGCXGLNCommonDefine.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/1/31.
//

#import <Foundation/Foundation.h>


#pragma mark ------------------------- 通用宏 -------------------------
/**
 *  等比例适配系数
 */
#ifndef kScaleFit
#define kScaleFit (is_iPhone ? ((SCREEN_WIDTH < SCREEN_HEIGHT) ? SCREEN_WIDTH / 375.0f : SCREEN_WIDTH / 667.0f) : 1)
#endif

#define ScaleScreenWidth375(y) Scale(SCREEN_WIDTH, y, 375.0)

#define Scale(x, y, z) ((x) * (y) / (z))
#define ScaleScreenWidth(y, z) Scale(SCREEN_WIDTH, (y), (z))
#define ScaleScreenHeight(y, z, max) (SCREEN_HEIGHT > (max) ? (y) : Scale(SCREEN_HEIGHT, y, z))
