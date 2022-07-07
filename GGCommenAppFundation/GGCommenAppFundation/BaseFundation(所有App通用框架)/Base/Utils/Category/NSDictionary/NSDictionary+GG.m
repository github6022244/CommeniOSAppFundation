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

- (id)gg_safeObjectForKey:(id)key {
    if ([[self allKeys] containsObject:key]) {
        return [self objectForKey:key];
    }
    
    return nil;
}

+ (id)gg_checkClass:(id)obj objectForKey:(id)key {
    if ([obj isKindOfClass:[self class]]) {
        NSDictionary *dict = (NSDictionary *)obj;
        return [dict gg_safeObjectForKey:key];
    }
    
    return nil;
}

@end
