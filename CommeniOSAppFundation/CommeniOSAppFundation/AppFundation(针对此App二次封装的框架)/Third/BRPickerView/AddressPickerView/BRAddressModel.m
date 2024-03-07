//
//  BRAddressModel.m
//  BRPickerViewDemo
//
//  Created by 任波 on 2017/8/11.
//  Copyright © 2017年 91renb. All rights reserved.
//
//  最新代码下载地址：https://github.com/91renb/BRPickerView

#import "BRAddressModel.h"

@implementation BRProvinceModel

MJLogAllIvars

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"code" : @"id", @"citylist" : @"cityList" };
}

- (void)setCitylist:(NSArray *)citylist
{
    _citylist = [BRCityModel mj_objectArrayWithKeyValuesArray:citylist];
}

@end


@implementation BRCityModel

MJLogAllIvars

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"code" : @"id", @"arealist" : @"areaList" };
}

- (void)setArealist:(NSArray *)arealist
{
    _arealist = [BRAreaModel mj_objectArrayWithKeyValuesArray:arealist];
}

@end


@implementation BRAreaModel

MJLogAllIvars

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"code" : @"id" };
}

@end
