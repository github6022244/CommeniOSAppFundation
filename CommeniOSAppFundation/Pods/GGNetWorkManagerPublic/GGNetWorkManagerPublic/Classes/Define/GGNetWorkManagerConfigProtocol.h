//
//  GGNetWorkManagerConfigProtocol.h
//  GGNetWorkManager
//
//  Created by GG on 2022/5/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "GGNetWorkManagerDefine.h"
#import "GGNetWorkManagerLoadingProtocol.h"

#pragma mark --- 传入的配置对象需要实现的协议
@protocol GGNetWorkManagerConfigProtocol <NSObject>

@optional
// 返回 requestHeaders
- (NSDictionary *_Nullable)gg_configRequestHeaders;

// 返回公共参数
- (NSDictionary *_Nullable)gg_configcommonParameters;


/// 返回请求缓存 path
/// 格式:
/// @{
///   cdn path 或者 request path : 缓存地址，
///}
- (NSDictionary *_Nullable)gg_configFilterCacheDirPath;

// 返回请求超时时间
- (NSUInteger)gg_configTimeoutInterval;

// 配置 AFHTTPSessionManager，内部已经做了常见的处理
- (void)gg_configAFHTTPSessionManager:(AFHTTPSessionManager *_Nullable)manager;

@required
// 返回网络环境
- (GGNetManagerServerType)gg_configNetServerType;

// 配置请求域名
- (NSString *_Nullable)gg_configURL_Test_Sever;

- (NSString *_Nullable)gg_configURL_Develope_Sever;

- (NSString *_Nonnull)gg_configURL_Public_Sever;

// 配置H5相关域名
- (NSString *_Nullable)gg_configURL_Develope_H5;

- (NSString *_Nullable)gg_configURL_Test_H5;

- (NSString *_Nonnull)gg_configURL_Public_H5;

// 配置CDN域名
- (NSString *_Nullable)gg_configURL_Develope_CDN;

- (NSString *_Nullable)gg_configURL_Test_CDN;

- (NSString *_Nonnull)gg_configURL_Public_CDN;

// 获取一个菊花模型
- (id<GGNetWorkManagerLoadingProtocol>_Nonnull)gg_getLoadingModel;

@end
