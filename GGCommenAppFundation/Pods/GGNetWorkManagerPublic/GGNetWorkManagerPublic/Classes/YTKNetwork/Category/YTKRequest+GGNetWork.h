//
//  YTKRequest+GGNetWork.h
//  GGNetWorkManager
//
//  Created by GG on 2022/6/10.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTKRequest (GGNetWork)

#pragma mark --- 如果存在缓存文件则删除
- (void)clearCachesIfExists;

@end

NS_ASSUME_NONNULL_END
