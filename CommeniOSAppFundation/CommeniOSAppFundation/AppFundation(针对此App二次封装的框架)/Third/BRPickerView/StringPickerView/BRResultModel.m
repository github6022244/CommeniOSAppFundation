//
//  BRResultModel.m
//  BRPickerViewDemo
//
//  Created by 任波 on 2019/10/2.
//  Copyright © 2019年 91renb. All rights reserved.
//
//  最新代码下载地址：https://github.com/91renb/BRPickerView

#import "BRResultModel.h"

@implementation BRResultModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"key" : @"id",
//        @"key" : @"major_id",
        @"value" : @"faculty_name",
//        @"value" : @"major_name"
    };
}

- (NSString *)name {
    return _value;
}

- (NSString *)selectValue {
    return _value;
}

- (void)setMajor_id:(NSString *)major_id {
    _major_id = major_id;
    _key = major_id;
}

- (void)setMajor_name:(NSString *)major_name {
    _major_name = major_name;
    _value = major_name;
}

- (void)setFaculty_id:(NSString *)faculty_id {
    _faculty_id = faculty_id;
    _key = faculty_id;
}

- (void)setRoom_id:(NSString *)room_id {
    _room_id = room_id;
    _key = room_id;
}

- (void)setRoom_name:(NSString *)room_name {
    _room_name = room_name;
    _value = room_name;
}

@end
