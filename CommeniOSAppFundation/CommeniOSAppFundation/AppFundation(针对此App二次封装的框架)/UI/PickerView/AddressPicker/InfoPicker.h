//
//  InfoPicker.h
//  CXGrainStudentApp
//
//  Created by User on 2020/8/3.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import "BRAddressPickerView.h"
#import "BRStringPickerView.h"
#import <Foundation/Foundation.h>

@class BRResultModel;

typedef void(^InfoPickerNetGetAddressBlock)(NSArray *addressModelsArray);

NS_ASSUME_NONNULL_BEGIN

@interface InfoPicker : NSObject

+ (void)showPickerViewWithTitle:(NSString *)title
                        dataArr:(NSArray *)dataArr
                    selectIndex:(NSInteger)selectIndex
                    resultBlock:(BRStringResultModelBlock)resultBlock;

+ (void)showPickerViewWithTitle:(NSString *)title
                        dataArr:(NSArray *)dataArr
                     autoSelect:(BOOL)autoSelect
                    selectIndex:(NSInteger)selectIndex
                    resultBlock:(BRStringResultModelBlock)resultBlock;

#pragma mark --- 网络获取地址展示
+ (void)showAddressPickerViewWithTitle:(NSString *)title
                          selectIndexs:(NSArray *)selectIndexs
                           resultBlock:(BRAddressResultBlock)resultBlock;

#pragma mark --- 自定义地址数据展示
+ (void)showAddressPickerViewWithTitle:(NSString *)title
                     customAddressData:(NSArray *)addressModelsArray
                          selectIndexs:(NSArray *)selectIndexs
                           resultBlock:(BRAddressResultBlock)resultBlock;

/// 本地获取地址数组
+ (NSArray *)addressJsonArray;

/// 网络获取地址数组
+ (void)addressJsonArrayWithBlock:(InfoPickerNetGetAddressBlock)block;

@end

NS_ASSUME_NONNULL_END
