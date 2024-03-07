//
//  GGBaseInputMessage.h
//
//
//  Created by JSONConverter on 2022/05/17.
//  Copyright © 2022年 JSONConverter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRAddressModel.h"

@class GGBaseInputMessageBaseModel;
@class GGBaseInputMessageSingleSelectData;

// 功能类型
typedef NS_ENUM(NSUInteger, GGBaseInputMessageBaseModelFuncType) {
    GGBaseInputMessageBaseModelFuncType_Input,// 输入框,可以输入任意字符，最大长度限制120个字符。
    GGBaseInputMessageBaseModelFuncType_InputNumber,// 输入框，只能输入数字
    GGBaseInputMessageBaseModelFuncType_TextArea,// 文本框,可以显示多行文本的输入框，默认4行文本高度。
    GGBaseInputMessageBaseModelFuncType_Select,// 下拉选择框，最普通的下拉框，没有层级结构。
    GGBaseInputMessageBaseModelFuncType_TreeSelect,// 树形选择，树状选择器，呈现父子结构的数据，如果有“children”则说明有子节点。
    GGBaseInputMessageBaseModelFuncType_DatePicker,// 日期选择器，用于选择或输入日期。
    GGBaseInputMessageBaseModelFuncType_TimePicker,// 时间选择器，用于选择或输入时间。
    GGBaseInputMessageBaseModelFuncType_Image,// 图片容器，从相册或者相机选择图片。
};





@interface GGBaseInputMessage: NSObject
@property (nonatomic, strong) NSArray<GGBaseInputMessageBaseModel *> *data;// 各个item

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// 唯一创建方法
/// @param dictionary 字典
+ (instancetype)createModelWithDictionary:(NSDictionary *)dictionary;

/// 检查未填项
- (GGBaseInputMessageBaseModel *)jugeRequiredMessageButNil;

/// 获取接口上传形式的key-value
- (NSDictionary *)getApiParam;
@end






@interface GGBaseInputMessageBaseModel : NSObject
@property (nonatomic, copy) NSString *key;// 原始数据对应的 key
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSArray<BRProvinceModel *> *areaData;// 省市区类型数据
@property (nonatomic, strong) NSArray<GGBaseInputMessageSingleSelectData *> *singleSelectData;// 单选类型数据

// 自己添加接口
@property (nonatomic, assign, readonly) GGBaseInputMessageBaseModelFuncType funcType;// 功能类型
// 输入
@property (nonatomic, copy) NSString *inputString;// 用来存储输入的文字
// 单选
@property (nonatomic, copy) NSString *singleSelectedID;// 单一输入框选择的 ID
@property (nonatomic, assign) NSInteger currentSelectSingleOptionIndex;// 当前选择的单选项，默认 -1
// 地址
@property (nonatomic, copy) NSString *selectProvinceID;// 选择的省 id
@property (nonatomic, copy) NSString *selectCityID;// 选择的 id
@property (nonatomic, copy) NSString *selectAreaID;// 选择的区 id
@property (nonatomic, assign) NSUInteger currentSelectProvinceIndex;// 选择的省 下标
@property (nonatomic, assign) NSUInteger currentSelectCityIndex;// 选择的 下标
@property (nonatomic, assign) NSUInteger currentSelectAreaIndex;// 选择的区 下标
// 时间
@property (nonatomic, strong) NSDate *selectDate;// 已经选择的时间
@property (nonatomic, copy) NSString *selectDateValue;// 已经选择的时间（格式化后的）

// 没有选择或者填写时的提示文字
- (NSString *)emptyAlertText;
@end





@interface GGBaseInputMessageSingleSelectData: NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@end
