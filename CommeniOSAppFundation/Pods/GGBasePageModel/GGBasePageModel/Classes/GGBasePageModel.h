//
//  BasePageModel.h
//  BasePageModel
//
//  Created by Wei on 2017/7/19.
//  Copyright © 2017年 ASK. All rights reserved.
//  分页使用的模型

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GGRefreshType) {
    GGRefreshType_Refresh, // 下拉刷新
    GGRefreshType_LoadMore // 上拉加载
};

@interface GGBasePageModel : NSObject

@property (assign, nonatomic, readonly) NSInteger page;/**< 当前分页数, 默认冲 1 开始 */

@property (assign, nonatomic, readonly) NSInteger count;/**< 每个分页数量, 默认 10 */

@property (strong, nonatomic, readonly) NSMutableArray * dataSource;/**< 数据 */

@property (assign, nonatomic, readonly) BOOL dataRefreshed;/**< 数据是否已经刷新，可以根据这个值来判断是否需要刷新UI */

@property (assign, nonatomic, readonly) BOOL loadMoreAndNoMoreData;/**< 上拉加载 数据量是否小于 _count */

@property (nonatomic, assign, readonly) BOOL loadAndLessDataCount;/**< 下拉刷新、上拉加载的数据量是否小于 _count */

/**
 子类重写
 
 可以在此方法中定义 page、count 等属性的初始值
 */
- (void)preparePageModel;

/**
 刷新数据源
 
 1. 下拉刷新
 如果array不为空则清空数据源并加入array里所有的元素, page = 初始化值 + 1;
 如果array为空, page = 初始化值
 2. 上拉加载
 如果array不为空则加入array里所有元素, page += 1;
 如果array为空, page不变, 数据源不变
 
 @param refreshType 刷新方式
 @param array 数组
 */
- (void)refreshDataSourceWithArray:(NSArray *)array refreshType:(GGRefreshType)refreshType;

/**
 清空数据、并且各个属性更改为初始值
 */
- (void)clearData;

/**
 根据刷新类型返回 page
 
 @param type 刷新类型
 @return 上拉加载 ：_page / 下拉刷新 : _page 初始值
 */
- (NSInteger)pageWithRefreshType:(GGRefreshType)type;

@end
