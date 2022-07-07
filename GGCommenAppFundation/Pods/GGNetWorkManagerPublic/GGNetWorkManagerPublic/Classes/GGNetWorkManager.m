//
//  GGNetWorkManager.m
//  RKZhiChengYun
//
//  Created by GG on 2022/5/17.
//

#import "GGNetWorkManager.h"
#import "GGNetWorkManagerDefine.h"
#import <YTKNetwork/YTKNetworkConfig.h>
#import <YTKNetwork/YTKRequest.h>
#import "MRUrlArgumentsFilter.h"
#import "MRCacheDirPathFilter.h"
#import "YTKChainRequest+AnimatingAccessory.h"
#import "YTKBatchRequest+AnimatingAccessory.h"
#import "YTKBaseRequest+AnimatingAccessory.h"

#define GGNetWorkManagerShareInstance [GGNetWorkManager share]

@interface GGNetWorkManager ()

@property (nonatomic, strong) id<GGNetWorkManagerConfigProtocol> configModel;// 配置对象模型

@property (nonatomic, copy) NSString *currentServerURL;// 当前主接口域名(通过 configModel 配置)

@property (nonatomic, copy) NSString *currentH5URL;// 当前H5相关域名(通过 configModel 配置)

@property (nonatomic, copy) NSString *currentCDNURL;// 当前CDN域名(通过 configModel 配置)

@property (nonatomic, strong) NSDictionary *requestHeaders;// 请求 header (通过 configModel 配置)

@property (nonatomic, strong) NSDictionary *commenParameters;// 请求公共参数 (通过 configModel 配置)

@property (nonatomic, strong) NSDictionary *filterCacheDirPath;// 请求缓存本地地址

@property (nonatomic, assign) GGNetManagerServerType currentSeverType;// 网络环境 (通过 configModel 配置)

@property (nonatomic, assign) BOOL isTesting;// 是否在非正式接口环境(通过 configModel 配置获取)

@property (nonatomic, assign) NSInteger timeoutInterval;// 请求超时时间(通过 configModel 配置)

@end

@implementation GGNetWorkManager

#pragma mark ------------------------- Cycle -------------------------
+ (instancetype)share {
    static dispatch_once_t onceToken;
    static GGNetWorkManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self share];
}

#pragma mark ------------------------- Cofnig -------------------------
- (void)config {
    self.currentSeverType = [self.configModel gg_configNetServerType];
    
    self.requestHeaders = [self.configModel gg_configRequestHeaders];
    
    self.commenParameters = [self.configModel gg_configCommenParameters];
    
    self.filterCacheDirPath = [self.configModel gg_configFilterCacheDirPath];
    
    self.timeoutInterval = [self.configModel gg_configTimeoutInterval];
    
    self.currentServerURL = [self _getCurrentServerURL];
    
    self.currentH5URL = [self _getCurrentH5URL];
    
    self.currentCDNURL = [self _getCurrentCDNURL];
    
    [self configYTKNetwork];
}

- (void)configYTKNetwork {
    [YTKNetworkConfig sharedConfig].baseUrl = GGNetWorkManagerShareInstance.currentServerURL;
    [YTKNetworkConfig sharedConfig].cdnUrl = GGNetWorkManagerShareInstance.currentCDNURL;
    [YTKNetworkConfig sharedConfig].debugLogEnabled = GGNetWorkManagerShareInstance.debugLogEnable;

    MRUrlArgumentsFilter *urlFilter = [MRUrlArgumentsFilter filterWithArguments:self.commenParameters];
    [[YTKNetworkConfig sharedConfig] addUrlFilter:urlFilter];
    
    MRCacheDirPathFilter *cacheDirPathFilter = [[MRCacheDirPathFilter alloc] init];
    [[YTKNetworkConfig sharedConfig] addCacheDirPathFilter:cacheDirPathFilter];
    
    /// 证书配置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
   // 如果需要验证自建证书(无效证书)，需要设置为YES，默认为NO;
    securityPolicy.allowInvalidCertificates = YES;
   // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = NO;
    [YTKNetworkConfig sharedConfig].securityPolicy = securityPolicy;
}

#pragma mark ------------------------- Interface -------------------------
// 初始化配置，传入自定义的 model
+ (void)setUpConfigModel:(id<GGNetWorkManagerConfigProtocol>)configModel {
    GGNetWorkLog(@"%@ 重新配置", NSStringFromClass([self class]));
    
    GGNetWorkManagerShareInstance.configModel = configModel;
    
    [GGNetWorkManagerShareInstance config];
}

// 传入 path 组合成完整 url(根据当前的接口环境自动选择域名)
+ (NSString *)combinURLWithPath:(NSString *)path URLType:(GGNetManagerURLType)urlType {
    switch (urlType) {
        case GGNetManagerURLType_Server: {
            return [NSString stringWithFormat:@"%@%@", GGNetWorkManagerShareInstance.currentServerURL, path];
        }
            break;
        case GGNetManagerURLType_H5: {
            return [NSString stringWithFormat:@"%@%@", GGNetWorkManagerShareInstance.currentH5URL, path];
        }
            break;
        case GGNetManagerURLType_CDN: {
            return [NSString stringWithFormat:@"%@%@", GGNetWorkManagerShareInstance.currentCDNURL, path];
        }
            break;
    }
}

/// 根据url类型返回当前配置的域名
/// @param urlType url 类型
+ (NSString *)getCurrentURLWithUrlType:(GGNetManagerURLType)urlType {
    switch (urlType) {
        case GGNetManagerURLType_Server: {
            return GGNetWorkManagerShareInstance.currentServerURL;
        }
            break;
        case GGNetManagerURLType_H5: {
            return GGNetWorkManagerShareInstance.currentH5URL;
        }
            break;
        case GGNetManagerURLType_CDN: {
            return GGNetWorkManagerShareInstance.currentCDNURL;
        }
            break;
    }
}

#pragma mark --- 清除网络请求缓存
+ (void)clearNetRequestCaches {
    [self _clearCacheWithFilePath:[self getNetRequestCachesFilePath]];
}

#pragma mark --- 获取网络缓存大小
+ (CGFloat)getNetRequestCachesSize {
    return [self _getCacheSizeWithFilePath:[self getNetRequestCachesFilePath]];
}

#pragma mark --- 获取网络缓存文件路径
+ (NSString *)getNetRequestCachesFilePath {
    YTKRequest *request = [YTKRequest new];
GGNetWorkPushIgnoreUndeclaredSelectorWarning
    if ([request respondsToSelector:@selector(cacheBasePath)]) {
        NSString *libraryCachePath = [request performSelector:@selector(cacheBasePath)];
GGNetWorkPopClangDiagnosticWarnings
        return libraryCachePath;
    }
    
    return nil;
}

#pragma mark ------------------------- Private -------------------------
- (NSString *)_getCurrentServerURL {
    switch (self.currentSeverType) {
        case GGNetManagerServerType_Test: {
            return [self.configModel gg_configURL_Test_Sever];
        }
            break;
        case GGNetManagerServerType_Develop: {
            return [self.configModel gg_configURL_Develope_Sever];
        }
            break;
        case GGNetManagerServerType_Public: {
            return [self.configModel gg_configURL_Public_Sever];
        }
            break;
    }
}

- (NSString *)_getCurrentH5URL {
    switch (self.currentSeverType) {
        case GGNetManagerServerType_Test: {
            return [self.configModel gg_configURL_Test_H5];
        }
            break;
        case GGNetManagerServerType_Develop: {
            return [self.configModel gg_configURL_Develope_H5];
        }
            break;
        case GGNetManagerServerType_Public: {
            return [self.configModel gg_configURL_Public_H5];
        }
            break;
    }
}

- (NSString *)_getCurrentCDNURL {
    switch (self.currentSeverType) {
        case GGNetManagerServerType_Test: {
            return [self.configModel gg_configURL_Test_CDN];
        }
            break;
        case GGNetManagerServerType_Develop: {
            return [self.configModel gg_configURL_Develope_CDN];
        }
            break;
        case GGNetManagerServerType_Public: {
            return [self.configModel gg_configURL_Public_CDN];
        }
            break;
    }
}

//清除path文件夹下缓存
+ (BOOL)_clearCacheWithFilePath:(NSString *)path {
    if (!path.length) {
        return NO;
    }
    
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString *filePath = nil;
    NSError *error = nil;
    for (NSString *subPath in subPathArr) {
        filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }
        
    }
    
    return YES;
}

+ (NSInteger)_getCacheSizeWithFilePath:(NSString *)path {
    if (!path.length) {
        return 0;
    }
    
    // 获取“path”文件夹下的所有文件
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    NSString *filePath = nil;
    NSInteger totleSize = 0;
    for (NSString *subPath in subPathArr) {
        
        filePath = [path stringByAppendingPathComponent:subPath];
        
        BOOL isDirectory = NO;
        
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        //忽略不需要计算的文件:文件夹不存在/ 过滤文件夹/隐藏文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) {
            continue;
        }
        
        /** attributesOfItemAtPath: 文件夹路径 该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因 */
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        // 计算总大小
        totleSize += size;
    }
    
    return totleSize;
}

#pragma mark ------------------------- set / get -------------------------
- (BOOL)isTesting {
    return GGNetWorkManagerShareInstance.currentSeverType != GGNetManagerServerType_Public;
}

- (void)setDebugLogEnable:(BOOL)debugLogEnable {
    _debugLogEnable = debugLogEnable;
    
    [YTKNetworkConfig sharedConfig].debugLogEnabled = debugLogEnable;
}

@end
