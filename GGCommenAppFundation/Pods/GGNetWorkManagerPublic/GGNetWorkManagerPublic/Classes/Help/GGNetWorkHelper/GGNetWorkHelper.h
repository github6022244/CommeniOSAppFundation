//
//  GGNetWorkHelper.h
//  GGNetWorkManager
//
//  Created by GG on 2022/5/19.
//

#import <UIKit/UIKit.h>
#import <YTKNetwork/YTKBaseRequest.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGNetWorkHelper : NSObject

#pragma mark --- 获取根window
+ (UIWindow *)getKeyWindow;

#pragma mark --- 获取打印网络请求字符串
/// @param request request
/// @param forRequestFail 打印失败、成功结果
/// @param appendString 拼接字符串
+ (NSString *)getStringToLogRequest:(YTKBaseRequest *)request forRequestFail:(BOOL)forRequestFail appendString:(NSString *_Nullable)appendString;

@end

NS_ASSUME_NONNULL_END
