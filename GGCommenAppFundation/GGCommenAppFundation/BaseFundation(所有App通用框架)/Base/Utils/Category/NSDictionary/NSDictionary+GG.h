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

- (id)gg_safeObjectForKey:(id)key;

+ (id)gg_checkClass:(id)obj objectForKey:(id)key;

@end

NS_ASSUME_NONNULL_END
