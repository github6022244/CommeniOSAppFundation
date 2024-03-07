//
//  NSDictionary+GG.h
//  RKMedicineReach
//
//  Created by GG on 2020/10/28.
//  Copyright © 2020 ruikang. All rights reserved.
//
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (GG)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSString*)dictionaryToJsonString:(NSDictionary *)dic;

/// 检查 obj 是否是字典类型，如果是则返回 obj，不是返回 nil
/// - Parameter obj: 检测对象
+ (NSDictionary * _Nullable)gg_checkClass:(id)obj;

/// 获取 key 对应的 object
/// - Parameter key: key
/// 如果字典中没有这个 key，返回 nil
- (id _Nullable)gg_safeObjectForKey:(id)key;

/// 检查obj是否字典类型，如果是，返回 key 对应的 object
/// - Parameters:
///   - obj: 检测是否字典类型对象
///   - key: 字典中 object 对应的 key
+ (id _Nullable)gg_checkClass:(id)obj objectForKey:(id)key;

/// 检查obj是否字典类型，如果是，且 key 对应的 object 的 class 是传入的 Class 类型，返回对应的 object
/// - Parameters:
///   - obj: 检查 obj 是否字典类型
///   - key: 字典中 object 对应的 key
///   - objClass: 字典中 object 对应的 Class，不传则直接返回 object
+ (id _Nullable)gg_checkClass:(id)obj safeObjectForKey:(id)key checkObjectClass:(Class _Nullable)objClass;

@end

NS_ASSUME_NONNULL_END
