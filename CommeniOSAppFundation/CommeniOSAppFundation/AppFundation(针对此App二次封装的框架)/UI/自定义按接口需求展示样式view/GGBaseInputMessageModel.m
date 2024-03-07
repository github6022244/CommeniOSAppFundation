//
//  GGBaseInputMessageModel.m
//  CXGrainStudentApp
//
//  Created by GG on 2022/5/17.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "GGBaseInputMessageModel.h"
#import <ReactiveObjC.h>

@implementation GGBaseInputMessage

MJLogAllIvars

+ (instancetype)createModelWithDictionary:(NSDictionary *)dictionary {
    GGBaseInputMessage *model = [GGBaseInputMessage new];
    
    NSMutableArray *marr = @[].mutableCopy;
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *obj, BOOL * _Nonnull stop) {
        GGBaseInputMessageBaseModel *model = [GGBaseInputMessageBaseModel new];
        model.key = key;
        model.title = [NSDictionary gg_checkClass:obj objectForKey:@"title"];
        model.type = [NSDictionary gg_checkClass:obj objectForKey:@"type"];
        
        switch (model.funcType) {
            case GGBaseInputMessageBaseModelFuncType_TreeSelect: {
                // 省市区选择
                NSArray *sourceArray = [NSDictionary gg_checkClass:obj objectForKey:@"data"];
                NSMutableArray *modelsArray = @[].mutableCopy;
                
                [sourceArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    // 省
                    BRProvinceModel *model = [BRProvinceModel mj_objectWithKeyValues:obj];
                    model.index = idx;
                    
                    [model.citylist enumerateObjectsUsingBlock:^(BRCityModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        // 市
                        obj.index = idx;
                        
                        [obj.arealist enumerateObjectsUsingBlock:^(BRAreaModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            // 区
                            obj.index = idx;
                        }];
                    }];
                    
                    [modelsArray addObject:model];
                }];
                
                model.areaData = modelsArray;
            }
                break;
            case GGBaseInputMessageBaseModelFuncType_Select: {
                // 单选
                NSArray *sourceArray = [NSDictionary gg_checkClass:obj objectForKey:@"data"];
                
                NSArray *modelsArray = [GGBaseInputMessageSingleSelectData mj_objectArrayWithKeyValuesArray:sourceArray];;
                model.singleSelectData = modelsArray;
            }
                break;
            default:
                break;
        }
        
        NSLog(@"%@", model.title);
        
        [marr addObject:model];
    }];
    
    model.data = marr;
    
    return model;
}

// 检查未填项
- (GGBaseInputMessageBaseModel *)jugeRequiredMessageButNil {
    for (NSUInteger i = 0; i < self.data.count; i++) {
        GGBaseInputMessageBaseModel *model = self.data[i];
        
        switch (model.funcType) {
            case GGBaseInputMessageBaseModelFuncType_Input:
            case GGBaseInputMessageBaseModelFuncType_TextArea:
            case GGBaseInputMessageBaseModelFuncType_InputNumber: {
                if (!model.inputString.length) {
                    return model;
                }
            }
                break;
            case GGBaseInputMessageBaseModelFuncType_Select: {
                if (!model.singleSelectedID.length) {
                    return model;
                }
            }
                break;
            case GGBaseInputMessageBaseModelFuncType_DatePicker:
            case GGBaseInputMessageBaseModelFuncType_TimePicker: {
                if (!model.selectDate) {
                    return model;
                }
            }
                break;
            case GGBaseInputMessageBaseModelFuncType_TreeSelect: {
                if (!model.selectProvinceID.length && !model.selectCityID.length && !model.selectAreaID.length) {
                    return model;
                }
            }
                break;
            case GGBaseInputMessageBaseModelFuncType_Image: {
                QMUILog(nil, @"没有设计图，没做");
                return nil;
            }
                break;
            default:
                break;
        }
    }
    
    return nil;
}

// 获取接口上传形式的key-value
- (NSDictionary *)getApiParam {
    NSMutableDictionary *mDict = @{}.mutableCopy;
    
    for (NSUInteger i = 0; i < self.data.count; i++) {
        GGBaseInputMessageBaseModel *model = self.data[i];
        
        NSString *key = NSStringTransformEmpty(model.key);
        
        switch (model.funcType) {
            case GGBaseInputMessageBaseModelFuncType_Input:
            case GGBaseInputMessageBaseModelFuncType_TextArea:
            case GGBaseInputMessageBaseModelFuncType_InputNumber: {
                // 输入文本
                [mDict setValue:NSStringTransformEmpty(model.inputString) forKey:key];
            }
                break;
            case GGBaseInputMessageBaseModelFuncType_Select: {
                // 选择
                [mDict setValue:NSStringTransformEmpty(model.singleSelectedID) forKey:key];
            }
                break;
            case GGBaseInputMessageBaseModelFuncType_DatePicker:
            case GGBaseInputMessageBaseModelFuncType_TimePicker: {
                // 时间选择
                [mDict setValue:@([model.selectDate timeIntervalSince1970]) forKey:key];
            }
                break;
            case GGBaseInputMessageBaseModelFuncType_TreeSelect: {
                // 地址
                if (model.selectProvinceID.length) {
                    [mDict setValue:model.selectProvinceID forKey:@"province_id"];
                }
                
                if (model.selectCityID.length) {
                    [mDict setValue:model.selectCityID forKey:@"city_id"];
                }
                
                if (model.selectAreaID.length) {
                    [mDict setValue:model.selectAreaID forKey:@"district_id"];
                }
            }
                break;
            case GGBaseInputMessageBaseModelFuncType_Image: {
                // 图片
                QMUILog(nil, @"没有设计图，没做");
            }
                break;
            default:
                break;
        }
    }
    
    return mDict;
}

@end








@interface GGBaseInputMessageBaseModel ()

@property (nonatomic, assign) GGBaseInputMessageBaseModelFuncType funcType;// 功能类型

@property (nonatomic, copy) NSString *emptyAlertText;// 没有选择或者填写时的提示文字

@end

@implementation GGBaseInputMessageBaseModel

MJLogAllIvars

- (GGBaseInputMessageBaseModelFuncType)funcType {
    NSString *low_type = [_type lowercaseString];

    if ([low_type isEqualToString:@"input"]) {
        return GGBaseInputMessageBaseModelFuncType_Input;
    } else if ([low_type isEqualToString:@"inputnumber"]) {
        return GGBaseInputMessageBaseModelFuncType_InputNumber;
    } else if ([low_type isEqualToString:@"textarea"]) {
        return GGBaseInputMessageBaseModelFuncType_TextArea;
    } else if ([low_type isEqualToString:@"select"]) {
        return GGBaseInputMessageBaseModelFuncType_Select;
    } else if ([low_type isEqualToString:@"treeselect"]) {
        return GGBaseInputMessageBaseModelFuncType_TreeSelect;
    } else if ([low_type isEqualToString:@"datepicker"]) {
        return GGBaseInputMessageBaseModelFuncType_DatePicker;
    } else if ([low_type isEqualToString:@"timepicker"]) {
        return GGBaseInputMessageBaseModelFuncType_TimePicker;
    } else if ([low_type isEqualToString:@"image"]) {
        return GGBaseInputMessageBaseModelFuncType_Image;
    }

    return GGBaseInputMessageBaseModelFuncType_Input;
}

- (NSString *)emptyAlertText {
    switch (self.funcType) {
        case GGBaseInputMessageBaseModelFuncType_Input:
        case GGBaseInputMessageBaseModelFuncType_InputNumber:
        case GGBaseInputMessageBaseModelFuncType_TextArea: {
            return [NSString stringWithFormat:@"请填写%@", _title];;
        }
            break;
        case GGBaseInputMessageBaseModelFuncType_Select:
        case GGBaseInputMessageBaseModelFuncType_TreeSelect:
        case GGBaseInputMessageBaseModelFuncType_DatePicker:
        case GGBaseInputMessageBaseModelFuncType_TimePicker:
        case GGBaseInputMessageBaseModelFuncType_Image: {
            return [NSString stringWithFormat:@"请选择%@", _title];;
        }
            break;
        default:
            break;
    }
}

@end








@implementation GGBaseInputMessageSingleSelectData

MJLogAllIvars

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"ID": @"id",
    };
}

@end

