//
//  BasePageModel.m
//  BasePageModel
//
//  Created by Wei on 2017/7/19.
//  Copyright © 2017年 ASK. All rights reserved.
//

#import "GGBasePageModel.h"

@interface GGBasePageModel ()

@property (strong, nonatomic, readwrite) NSMutableArray * dataSource;/**< 数据 */

@property (assign, nonatomic, readwrite) BOOL dataRefreshed;/**< 数据是否已经刷新，可以根据这个值来判断是否需要刷新UI */

@property (assign, nonatomic, readwrite) BOOL loadMoreAndNoMoreData;/**< 上拉加载 数据量是否小于 _count */

@property (nonatomic, assign, readwrite) BOOL loadAndLessDataCount;/**< 下拉刷新、上拉加载的数据量是否小于 _count */

@property (assign, nonatomic, readwrite) NSInteger page;/**< 当前分页数 */

@property (assign, nonatomic, readwrite) NSInteger count;/**< 每个分页数量, 默认10 */

@property (strong, nonatomic) NSArray * origenalData;/**< 刷新之前的数据源 */

@property (nonatomic, assign) NSInteger origenalPage;/**< 初始化的分页 */

@end

@implementation GGBasePageModel

#pragma mark ------------------- 初始化 -------------------
#pragma mark 初始化方法
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initialized];
    }
    
    return self;
}

#pragma mark 子类自定义初始化属性方法
- (void)preparePageModel
{
    
}

#pragma mark ------------------- 接口 -------------------
#pragma mark 刷新数据源方法
- (void)refreshDataSourceWithArray:(NSArray *)array refreshType:(GGRefreshType)refreshType
{
    /**< 保存上次加载数据 */
    _origenalData = [NSArray arrayWithArray:self.dataSource];
    
    /**< 判断数据 */
    if ([array isKindOfClass:[NSArray class]]) {
        if (refreshType == GGRefreshType_Refresh) {
            /**< 下拉加载 */
            if (array.count > 0) {
                /**< 有值 */
                /**< 清空源数据源、将page改为 初始值 + 1 */
                [self refreshDataSourceWithArray:array];
            }else
            {
                /**< 没值 */
                /**< 清空数据源、将page改为 初始值 */
                [self.dataSource removeAllObjects];
                self.page = _origenalPage;
            }
        }else
        {
            /**< 上拉刷新 */
            if (array.count > 0) {
                /**< 有值 */
                /**< 加入数据源、page++ */
                [self addObjectFromArray:array];
            }
        }
    }
    
    /**< 判断是否已经刷新了数据源 */
    _dataRefreshed = ![_origenalData isEqualToArray:self.dataSource];
    _origenalData = nil;
    
    /**< 判断刷新后的状态 */
    if (array.count < _count) {
        _loadAndLessDataCount = YES;
        
        if (refreshType == GGRefreshType_LoadMore) {
            _loadMoreAndNoMoreData = YES;
        }
    }else
    {
        _loadAndLessDataCount = NO;
        
        if (refreshType == GGRefreshType_LoadMore) {
            _loadMoreAndNoMoreData = NO;
        }
    }
}

#pragma mark 清空数据
- (void)clearData
{
    [self initialized];
}

#pragma mark 根据刷新类型返回page
- (NSInteger)pageWithRefreshType:(GGRefreshType)type
{
    if (type == GGRefreshType_Refresh) {
        return _origenalPage;
    }else if (type == GGRefreshType_LoadMore)
    {
        return _page;
    }
    
    return _origenalPage;
}

#pragma mark ------------------- 内部方法 -------------------
#pragma mark ---- 初始化
- (void)initialized
{
    _count = 5;
    
    _dataSource = [NSMutableArray array];
    
    _dataRefreshed = NO;
    
    _loadMoreAndNoMoreData = NO;
    
    _loadAndLessDataCount = NO;
    
    _page = 1;
    
    [self preparePageModel];
    
    _origenalPage = _page;
}

#pragma mark ---- 刷新数据(下拉刷新)
- (void)refreshDataSourceWithArray:(NSArray *)array
{
    self.page = _origenalPage + 1;
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:array];
}

#pragma mark ---- 刷新数据(上拉加载)
- (void)addObjectFromArray:(NSArray *)array
{
    self.page += 1;
    [self.dataSource addObjectsFromArray:array];
}

@end

