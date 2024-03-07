//
//  NSDictionary+GG.m
//  RKMedicineReach
//
//  Created by GG on 2020/10/28.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "NSDictionary+GG.h"

@implementation NSDictionary (GG)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {

    if (jsonString == nil) {

    return nil;

    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *err;

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData

    options:NSJSONReadingMutableContainers

    error:&err];

    if(err) {

    NSLog(@"json解析失败：%@",err);

    return nil;

    }

    return dic;

}

+ (NSString*)dictionaryToJsonString:(NSDictionary *)dic

{

    NSError *parseError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}

+ (NSDictionary * _Nullable)gg_checkClass:(id)obj {
    if ([obj isKindOfClass:[self class]]) {
        return obj;
    }
    
    return nil;
}

- (id)gg_safeObjectForKey:(id)key {
    if ([[self allKeys] containsObject:key]) {
        return [self objectForKey:key];
    }
    
    return nil;
}

+ (id)gg_checkClass:(id)obj objectForKey:(id)key {
    return [self gg_checkClass:obj safeObjectForKey:key checkObjectClass:nil];
}

+ (id)gg_checkClass:(id)obj safeObjectForKey:(id)key checkObjectClass:(Class)objClass {
    NSDictionary *dict = [NSDictionary gg_checkClass:obj];
        
    id value = [dict gg_safeObjectForKey:key];
    
    if (objClass) {
        if ([value isKindOfClass:objClass]) {
            return value;
        } else {
            return nil;
        }
    } else {
        return value;
    }
}

@end
