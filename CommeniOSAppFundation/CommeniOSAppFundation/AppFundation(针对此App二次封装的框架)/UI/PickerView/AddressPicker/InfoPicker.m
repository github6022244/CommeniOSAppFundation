//
//  InfoPicker.m
//  CXGrainStudentApp
//
//  Created by User on 2020/8/3.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import "InfoPicker.h"
#import "BRAddressModel.h"
#import "CXGLNAppFundationGetAddressPickerRequest.h"

@interface InfoPicker ()

@property (nonatomic, strong) CXGLNAppFundationGetAddressPickerRequest *getAddressPickerRequest;

@end

@implementation InfoPicker

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static InfoPicker *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+ (void)showPickerViewWithTitle:(NSString *)title
                        dataArr:(NSArray *)dataArr
                    selectIndex:(NSInteger)selectIndex
                    resultBlock:(BRStringResultModelBlock)resultBlock {
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc] init];
    stringPickerView.pickerMode = BRStringPickerComponentSingle;
    stringPickerView.title = title;
    stringPickerView.dataSourceArr = dataArr;
    stringPickerView.selectIndex = selectIndex;
    stringPickerView.isAutoSelect = YES;
    stringPickerView.resultModelBlock = resultBlock;

    // 自定义弹框样式
    BRPickerStyle *customStyle = [[BRPickerStyle alloc] init];
    customStyle.cancelTextColor = UIColor.qd_mainTextColor;
    customStyle.cancelTextFont = [UIFont systemFontOfSize:16];
    customStyle.cancelBtnTitle = @"取消";
    customStyle.doneTextColor = UIColor.qd_tintColor;
    customStyle.doneTextFont = [UIFont systemFontOfSize:16];
    customStyle.doneBtnTitle = @"确定";
    customStyle.titleTextFont = [UIFont systemFontOfSize:18];
    customStyle.titleTextColor = UIColor.qd_titleTextColor;
    stringPickerView.pickerStyle = customStyle;

    [stringPickerView show];
}

+ (void)showPickerViewWithTitle:(NSString *)title
                        dataArr:(NSArray *)dataArr
                     autoSelect:(BOOL)autoSelect
                    selectIndex:(NSInteger)selectIndex
                    resultBlock:(BRStringResultModelBlock)resultBlock {
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc] init];
    stringPickerView.pickerMode = BRStringPickerComponentSingle;
    stringPickerView.title = title;
    stringPickerView.dataSourceArr = dataArr;
    stringPickerView.selectIndex = selectIndex;
    stringPickerView.isAutoSelect = autoSelect;
    stringPickerView.resultModelBlock = resultBlock;

    // 自定义弹框样式
    BRPickerStyle *customStyle = [[BRPickerStyle alloc] init];
    customStyle.cancelTextColor =  UIColor.qd_mainTextColor;
    customStyle.cancelTextFont = [UIFont systemFontOfSize:16];
    customStyle.cancelBtnTitle = @"取消";
    customStyle.doneTextColor = UIColor.qd_tintColor;
    customStyle.doneTextFont = [UIFont systemFontOfSize:16];
    customStyle.doneBtnTitle = @"确定";
    customStyle.titleTextFont = [UIFont systemFontOfSize:18];
    customStyle.titleTextColor = UIColor.qd_titleTextColor;
    stringPickerView.pickerStyle = customStyle;

    [stringPickerView show];
}

#pragma mark --- 网络获取地址展示
+ (void)showAddressPickerViewWithTitle:(NSString *)title
                          selectIndexs:(NSArray *)selectIndexs
                           resultBlock:(BRAddressResultBlock)resultBlock {
    BRAddressPickerView *addressPickerView = [[BRAddressPickerView alloc] init];
    addressPickerView.pickerMode = BRAddressPickerModeArea;
    addressPickerView.title = title;
//    addressPickerView.dataSourceArr = [self addressJsonArray];
    [self addressJsonArrayWithBlock:^(NSArray *addressModelsArray) {
        addressPickerView.dataSourceArr = addressModelsArray;
        addressPickerView.selectIndexs = selectIndexs;
        addressPickerView.isAutoSelect = YES;
        addressPickerView.resultBlock = resultBlock;

        // 自定义弹框样式
        BRPickerStyle *customStyle = [[BRPickerStyle alloc] init];
        customStyle.cancelTextColor =  UIColor.qd_mainTextColor;
        customStyle.cancelTextFont = [UIFont systemFontOfSize:16];
        customStyle.cancelBtnTitle = @"取消";
        customStyle.doneTextColor = UIColor.qd_tintColor;
        customStyle.doneTextFont = [UIFont systemFontOfSize:16];
        customStyle.doneBtnTitle = @"确定";
        addressPickerView.pickerStyle = customStyle;

        [addressPickerView show];
    }];
//    //addressPickerView.selectValues = [self.infoModel.addressStr componentsSeparatedByString:@" "];
    
//    addressPickerView.selectIndexs = selectIndexs;
//    addressPickerView.isAutoSelect = YES;
//    addressPickerView.resultBlock = resultBlock;
//
//    // 自定义弹框样式
//    BRPickerStyle *customStyle = [[BRPickerStyle alloc] init];
//    customStyle.cancelTextColor =  UIColor.qd_mainTextColor;
//    customStyle.cancelTextFont = [UIFont systemFontOfSize:16];
//    customStyle.cancelBtnTitle = @"取消";
//    customStyle.doneTextColor = UIColor.qd_tintColor;
//    customStyle.doneTextFont = [UIFont systemFontOfSize:16];
//    customStyle.doneBtnTitle = @"确定";
//    addressPickerView.pickerStyle = customStyle;
//
//    [addressPickerView show];
}

#pragma mark --- 自定义地址数据展示
+ (void)showAddressPickerViewWithTitle:(NSString *)title
                     customAddressData:(NSArray *)addressModelsArray
                          selectIndexs:(NSArray *)selectIndexs
                           resultBlock:(BRAddressResultBlock)resultBlock {
    BRAddressPickerView *addressPickerView = [[BRAddressPickerView alloc] init];
    addressPickerView.pickerMode = BRAddressPickerModeArea;
    addressPickerView.title = title;

    addressPickerView.dataSourceArr = addressModelsArray;
    addressPickerView.selectIndexs = selectIndexs;
    addressPickerView.isAutoSelect = YES;
    addressPickerView.resultBlock = resultBlock;

    // 自定义弹框样式
    BRPickerStyle *customStyle = [[BRPickerStyle alloc] init];
    customStyle.cancelTextColor =  UIColor.qd_mainTextColor;
    customStyle.cancelTextFont = [UIFont systemFontOfSize:16];
    customStyle.cancelBtnTitle = @"取消";
    customStyle.doneTextColor = UIColor.qd_tintColor;
    customStyle.doneTextFont = [UIFont systemFontOfSize:16];
    customStyle.doneBtnTitle = @"确定";
    addressPickerView.pickerStyle = customStyle;

    [addressPickerView show];
}

+ (NSArray *)addressJsonArray {
    static NSArray *addressArr = nil;

    if (addressArr == nil) {
        // 获取本地JSON文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        addressArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        addressArr = [BRProvinceModel mj_objectArrayWithKeyValuesArray:addressArr];

        for (BRProvinceModel *provinceModel in addressArr) {
            provinceModel.index = [addressArr indexOfObject:provinceModel];
            for (BRCityModel *cityModel in provinceModel.citylist) {
                cityModel.index = [provinceModel.citylist indexOfObject:cityModel];
                for (BRAreaModel *areaModel in cityModel.arealist) {
                    areaModel.index = [cityModel.arealist indexOfObject:areaModel];
                }
            }
        }
    }
    return addressArr;
}

/// 网络获取地址数组
+ (void)addressJsonArrayWithBlock:(InfoPickerNetGetAddressBlock)block {
    static NSArray *addressArr = nil;
    
    if (addressArr == nil) {
        InfoPicker *sharePicker = [InfoPicker sharedInstance];
        
        if (sharePicker.getAddressPickerRequest.isExecuting) {
            return;
        }
        
        sharePicker.getAddressPickerRequest = [CXGLNAppFundationGetAddressPickerRequest new];
        
        @ggweakify(sharePicker)
        sharePicker.getAddressPickerRequest.api_requestSuccessResultBlock = ^(GGBaseRequestReslutModel *apiReslutModel) {
            
            if (apiReslutModel.isRequestSuccessed) {
                addressArr = [BRProvinceModel mj_objectArrayWithKeyValuesArray:apiReslutModel.responseObject];
                
                for (BRProvinceModel *provinceModel in addressArr) {
                    provinceModel.index = [addressArr indexOfObject:provinceModel];
                    for (BRCityModel *cityModel in provinceModel.citylist) {
                        cityModel.index = [provinceModel.citylist indexOfObject:cityModel];
                        for (BRAreaModel *areaModel in cityModel.arealist) {
                            areaModel.index = [cityModel.arealist indexOfObject:areaModel];
                        }
                    }
                }
            }
            
            if (block) {
                block(addressArr);
            }
        };
        
        sharePicker.getAddressPickerRequest.api_requestFailureResultBlock = ^(NSError * _Nullable error) {
            
            if (block) {
                block(nil);
            }
        };
        
        [sharePicker.getAddressPickerRequest startWithoutCache];
    } else {
        if (block) {
            block(addressArr);
        }
    }
}

@end
