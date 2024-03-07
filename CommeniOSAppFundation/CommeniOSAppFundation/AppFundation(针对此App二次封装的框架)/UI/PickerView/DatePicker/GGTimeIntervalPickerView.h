//
//  GGTimeIntervalPickerView.h
//  CXGLNewStudentApp
//
//  Created by GG on 2024/1/31.
//  开始时间 至 结束时间 选择器

#import "BRBaseView.h"
#import "BRDatePickerView.h"

#import "BRResultModel.h"

/// 字符串选择器类型
typedef NS_ENUM(NSInteger, GGTimeIntervalPickerMode) {
    /// 时、分
    GGTimeIntervalPickerMode_HM,
};

NS_ASSUME_NONNULL_BEGIN

/// 点击确定后回调 block
typedef void(^GGTimeIntervalResultModelBlock)(NSString *startDate_String, NSString *endDate_String, NSDate *startDate, NSDate *endDate);

@interface GGTimeIntervalPickerView : BRBaseView

@property (nonatomic, assign) GGTimeIntervalPickerMode pickerMode;

@property (nonatomic, strong) NSDate *minDate;

@property (nonatomic, strong) NSDate *maxDate;

@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic, strong) NSDate *endDate;

@property (nonatomic, copy) GGTimeIntervalResultModelBlock resultModelBlock;

/// 弹出选择器视图
- (void)show;

/// 关闭选择器视图
- (void)dismiss;

@end
















@interface GGTimeIntervalPickerItemView : BRDatePickerView

@property (nonatomic, assign) CGRect customFrame;

- (void)setPickerView:(UIView *)pickerView toView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
