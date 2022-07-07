//
//  GGNetWorkManager.h
//  RKZhiChengYun
//
//  Created by GG on 2022/5/17.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "GGNetWorkManagerDefine.h"
#import "GGNetWorkManagerConfigProtocol.h"
#import "GGNetWorkManagerLoadingProtocol.h"


#pragma mark --- GGNetWorkManager
NS_ASSUME_NONNULL_BEGIN

@interface GGNetWorkManager : NSObject

@property (nonatomic, strong, readonly) id<GGNetWorkManagerConfigProtocol> configModel;// 配置对象模型

@property (nonatomic, copy, readonly) NSString *currentServerURL;// 当前主接口域名(通过 configModel 配置)

@property (nonatomic, copy, readonly) NSString *currentH5URL;// 当前H5相关域名(通过 configModel 配置)

@property (nonatomic, copy, readonly) NSString *currentCDNURL;// 当前CDN域名(通过 configModel 配置)

@property (nonatomic, strong, readonly) NSDictionary *requestHeaders;// 请求 header (通过 configModel 配置)

@property (nonatomic, strong, readonly) NSDictionary *commenParameters;// 请求公共参数 (通过 configModel 配置)

@property (nonatomic, strong, readonly) NSDictionary *filterCacheDirPath;// 请求缓存本地地址

@property (nonatomic, assign, readonly) GGNetManagerServerType currentSeverType;// 网络环境 (通过 configModel 配置)

@property (nonatomic, assign, readonly) BOOL isTesting;// 是否在非正式接口环境(通过 configModel 配置获取)

@property (nonatomic, assign, readonly) NSInteger timeoutInterval;// 请求超时时间(通过 configModel 配置)

@property (nonatomic, assign) BOOL debugLogEnable;// 是否开启 debug 打印

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// 唯一 初始化\单例 方法
+ (instancetype)share;

/// 初始化配置，传入自定义的 model
/// @param configModel 配置模型
/// 内部已经设置了 [YTKNetworkConfig sharedConfig].baseUrl 、cdnUrl
+ (void)setUpConfigModel:(id<GGNetWorkManagerConfigProtocol>)configModel;

/// 传入 path 组合成完整 url(根据当前的接口环境自动选择域名)
/// @param path url 路径
/// @param urlType 接口类型
+ (NSString *)combinURLWithPath:(NSString *)path URLType:(GGNetManagerURLType)urlType;

/// 根据url类型返回当前配置的域名
/// @param urlType url 类型
+ (NSString *)getCurrentURLWithUrlType:(GGNetManagerURLType)urlType;

/// 清除网络请求缓存
+ (void)clearNetRequestCaches;

/// 获取网络缓存大小
+ (CGFloat)getNetRequestCachesSize;

/// 获取网络缓存文件路径
+ (NSString *)getNetRequestCachesFilePath;

@end

NS_ASSUME_NONNULL_END
