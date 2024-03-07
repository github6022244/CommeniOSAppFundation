//
//  GGTimeIntervalPickerView.m
//  CXGLNewStudentApp
//
//  Created by GG on 2024/1/31.
//

#import "GGTimeIntervalPickerView.h"

#import "NSDate+GGTimeInterval.h"

@interface GGTimeIntervalPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) QMUILabel *centerLabel;

/// 记录开始时间——string
@property (nonatomic, copy) NSString *startDate_String;
/// 记录结束时间——string
@property (nonatomic, copy) NSString *endDate_String;

@property (nonatomic, strong) GGTimeIntervalPickerItemView *startPicker;

@property (nonatomic, strong) GGTimeIntervalPickerItemView *endPicker;

@end

@implementation GGTimeIntervalPickerView

#pragma mark ------------------------- Data -------------------------
//#pragma mark --- 设置默认选中行
//- (void)configDefaultSelectRow {
//    BRDatePickerView *startPicker = self.pickerViewArray.firstObject;
//    startPicker.minDate = [NSDate dateWithDate:self.minDate];
//    startPicker.maxDate = [NSDate dateWithDate:self.maxDate];
//    startPicker.selectDate = [NSDate dateWithDate:self.startDate];
//    
//    BRDatePickerView *endPicker = self.pickerViewArray.lastObject;
//    endPicker.minDate = [NSDate dateWithDate:self.minDate];
//    endPicker.maxDate = [NSDate dateWithDate:self.maxDate];
//    endPicker.selectDate = [NSDate dateWithDate:self.endDate];
//}

#pragma mark ------------------------- UI -------------------------
- (void)layoutContentView {
    // 布局 picker
//    self.contentView.backgroundColor = UIColorTestRed;
    
    [NSDate calendar].timeZone = [NSDate dongBaTimeZone];
    
    NSInteger pickerCount = 2;
    CGFloat defaultX = 16.f * kScaleFit;
    CGFloat centerLabelWidth = 20.f * kScaleFit;
    CGFloat pickerWidth = (SCREEN_WIDTH - defaultX * 2 - centerLabelWidth) / pickerCount;
//    CGFloat pickerHeaderViewHeight = 0.f;
    CGFloat x = defaultX;
    GGTimeIntervalPickerItemView *pickerView = nil;
 
    for (NSInteger idx = 0; idx < pickerCount; idx++) {
        if (idx == 0) {
            x = defaultX;
            pickerView = self.startPicker;
        } else if (idx == 1) {
            x += centerLabelWidth + pickerWidth;
            pickerView = self.endPicker;
        }
        
        [self.contentView addSubview:pickerView];
        pickerView.customFrame = CGRectMake(x, 0.f, pickerWidth, self.pickerStyle.pickerHeight);
//        [pickerView show];
//        pickerView.frame = pickerView.customFrame;
        [pickerView addPickerToView:self.contentView];
        [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.mas_equalTo(x);
            make.width.mas_equalTo(pickerWidth);
        }];
        pickerView.tag = 1000 + idx;
        if (idx == 0) {
            // 开始时间 picker
            self.startPicker = pickerView;
            
            if (self.minDate) {
                pickerView.minDate = [NSDate dateWithDate:self.minDate];
            }
            
            // 这里比较重要，设置最大可选时间
            if (self.endDate && self.maxDate) {
                NSDate *date = nil;
                if ([self.endDate compare:self.maxDate] == NSOrderedAscending) {
                    date = self.endDate;
                } else {
                    date = self.maxDate;
                }
                pickerView.maxDate = [NSDate dateWithDate:date];
            } else {
                pickerView.maxDate = [NSDate dateWithDate:self.endDate] ? : [NSDate dateWithDate:self.maxDate];
            }
            if (self.startDate) {
                pickerView.selectDate = [NSDate dateWithDate:self.startDate];
                
                NSString *dateString = NSStringFormat(@"%ld-%02ld-%02ld %02ld:%02ld:%02ld", [self.startDate year], [self.startDate month], [self.startDate day], [self.startDate hour], [self.startDate minute], [self.startDate second]);
                
                self.startDate_String = dateString;
            }
            @ggweakify(self)
            pickerView.changeBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
                @ggstrongify(self)
                
                NSString *dateString = NSStringFormat(@"%ld-%02ld-%02ld %@:00", [self.startDate year], [self.startDate month], [self.startDate day], selectValue);
                
                self.startDate_String = dateString;
                
                self.startDate = [NSDate dateWithDate:selectDate];
                
                self.endPicker.minDate = [NSDate dateWithDate:self.startDate];
                self.endPicker.maxDate = [NSDate dateWithDate:self.maxDate];
                self.endPicker.selectDate = [NSDate dateWithDate:self.endDate];
                
                [self.endPicker reloadData];
            };
            
            [pickerView reloadData];
        } else {
            // 结束时间 picker
            self.endPicker = pickerView;
            
            // 这里比较重要，设置最小可选时间
            if (self.startDate && self.minDate) {
                NSDate *date = nil;
                if ([self.startDate compare:self.minDate] == NSOrderedDescending) {
                    date = self.startDate;
                } else {
                    date = self.minDate;
                }
                pickerView.minDate = [NSDate dateWithDate:date];
            } else {
                pickerView.minDate = self.startDate ? [NSDate dateWithDate:self.startDate] : [NSDate dateWithDate:self.minDate];
            }
            if (self.maxDate) {
                pickerView.maxDate = [NSDate dateWithDate:self.maxDate];
            }
            if (self.endDate) {
                pickerView.selectDate = [NSDate dateWithDate:self.endDate];
                
                NSString *dateString = NSStringFormat(@"%ld-%02ld-%02ld %02ld:%02ld:%02ld", [self.endDate year], [self.endDate month], [self.endDate day], [self.endDate hour], [self.endDate minute], [self.endDate second]);
                
                self.endDate_String = dateString;
            }
            @ggweakify(self)
            pickerView.changeBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
                @ggstrongify(self)
                NSString *dateString = NSStringFormat(@"%ld-%02ld-%02ld %@:00", [self.endDate year], [self.endDate month], [self.endDate day], selectValue);
                
                self.endDate_String = dateString;
                
                self.endDate = [NSDate dateWithDate:selectDate];
                
                self.startPicker.minDate = [NSDate dateWithDate:self.minDate];
                self.startPicker.maxDate = [NSDate dateWithDate:self.endDate];
                self.startPicker.selectDate = [NSDate dateWithDate:self.startDate];
                
                [self.startPicker reloadData];
            };
            
            [pickerView reloadData];
        }
    }
    
    _centerLabel = [QMUILabel labelWithSuperView:self.contentView withContent:@"至" withBackgroundColor:nil withTextColor:UIColorMakeWithHex(@"#333333") withFont:UIFontMake(18.f)];
    [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startPicker.mas_right);
        make.right.equalTo(self.endPicker.mas_left);
        make.centerY.equalTo(self.startPicker);
        make.width.mas_equalTo(centerLabelWidth);
    }];
    _centerLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark ------------------------- Override -------------------------
- (void)addPickerToView:(UIView *)view {
    // 1.添加字符串选择器
    if (view) {
        // 立即刷新容器视图 view 的布局（防止 view 使用自动布局时，选择器视图无法正常显示）
        [view setNeedsLayout];
        [view layoutIfNeeded];
        
        self.frame = view.bounds;
        CGFloat pickerHeaderViewHeight = self.pickerHeaderView ? self.pickerHeaderView.bounds.size.height : 0;
        CGFloat pickerFooterViewHeight = self.pickerFooterView ? self.pickerFooterView.bounds.size.height : 0;
        self.contentView.frame = CGRectMake(0, pickerHeaderViewHeight, view.bounds.size.width, view.bounds.size.height - pickerHeaderViewHeight - pickerFooterViewHeight);
        [self addSubview:self.contentView];
        [self layoutContentView];
    } else {
        self.contentView.frame = CGRectMake(0, self.pickerStyle.titleBarHeight, self.alertView.width, self.pickerStyle.pickerHeight);
        [self.alertView addSubview:self.contentView];
        [self layoutContentView];
    }
    
    // 2.绑定数据
//    [self reloadData];
    
    @ggweakify(self)
    self.doneBlock = ^{
        @ggstrongify(self)
        // 点击确定按钮后，执行block回调
        
        if (self.pickerMode == GGTimeIntervalPickerMode_HM) {
            if (self.resultModelBlock) {
                self.resultModelBlock(self.startDate_String, self.endDate_String, self.startDate, self.endDate);
            }
        }
        
        [self removePickerFromView:view];
    };
    
    [super addPickerToView:view];
}

#pragma mark - 重写父类方法
- (void)reloadData {
    // 1.处理数据源
//    [self handlerPickerData];
    // 2.刷新选择器
    [self.startPicker reloadData];
    [self.endPicker reloadData];
    // 3.滚动到选择的值
//    [self configDefaultSelectRow];
}

#pragma mark - 弹出选择器视图
- (void)show {
    [self addPickerToView:nil];
}

#pragma mark - 关闭选择器视图
- (void)dismiss {
    [self removePickerFromView:nil];
}

#pragma mark ------------------------- set / get -------------------------
- (GGTimeIntervalPickerItemView *)startPicker {
    if (!_startPicker) {
        _startPicker = [[GGTimeIntervalPickerItemView alloc] initWithPickerMode:BRDatePickerModeHM];
    }
    
    return _startPicker;
}

- (GGTimeIntervalPickerItemView *)endPicker {
    if (!_endPicker) {
        _endPicker = [[GGTimeIntervalPickerItemView alloc] initWithPickerMode:BRDatePickerModeHM];
    }
    
    return _endPicker;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    
    return _contentView;
}

- (BRPickerStyle *)pickerStyle {
    BRPickerStyle *style = [super pickerStyle];
    style.pickerColor = nil;
    style.separatorColor = nil;
    style.selectRowColor = nil;
    
//    /** 设置 picker 的高度（height），系统默认高度为 216 */
//    @property (nonatomic, assign) CGFloat pickerHeight;
//
//    /** 设置 picker 的行高（rowHeight）*/
//    @property (nonatomic, assign) CGFloat rowHeight;
    
    return style;
    
//    /** 设置 picker 的背景颜色（backgroundColor）*/
//    @property (nullable, nonatomic, strong) UIColor *pickerColor;
//
//    /** 设置 picker 中间两条分割线的背景颜色（separatorColor）*/
//    @property (nullable, nonatomic, strong) UIColor *separatorColor;
//
//    /**
//     *  设置 picker 选中行的背景颜色，默认为nil
//     *  提示：当有设置选中行的背景颜色时，pickerColor默认会等于clearColor，此时可通过设置 pickerView 父视图的背景颜色 来设置选择器的背景颜色
//     */
//    @property (nullable, nonatomic, strong) UIColor *selectRowColor;
}

//- (void)setMinDate:(NSDate *)minDate {
//    _minDate = [minDate changeToDongBaZoneTime];
//}
//
//- (void)setMaxDate:(NSDate *)maxDate {
//    _maxDate = [maxDate changeToDongBaZoneTime];
//}
//
//- (void)setStartDate:(NSDate *)startDate {
//    _startDate = [startDate changeToDongBaZoneTime];
//}
//
//- (void)setEndDate:(NSDate *)endDate {
//    _endDate = [endDate changeToDongBaZoneTime];
//}

@end

















@implementation GGTimeIntervalPickerItemView

- (BRPickerStyle *)pickerStyle {
    BRPickerStyle *style = [super pickerStyle];
    style.titleBarHeight = 0.f;
    
    return style;
}

- (void)setPickerView:(UIView *)pickerView toView:(UIView *)view {
    if (view) {
        // 立即刷新容器视图 view 的布局（防止 view 使用自动布局时，选择器视图无法正常显示）
        [view setNeedsLayout];
        [view layoutIfNeeded];
        
        self.frame = _customFrame;
//        CGFloat pickerHeaderViewHeight = self.pickerHeaderView ? self.pickerHeaderView.bounds.size.height : 0;
//        CGFloat pickerFooterViewHeight = self.pickerFooterView ? self.pickerFooterView.bounds.size.height : 0;
//        pickerView.frame = CGRectMake(0, pickerHeaderViewHeight, self.qmui_width, self.qmui_height - pickerHeaderViewHeight - pickerFooterViewHeight);
        pickerView.frame = self.bounds;
        [self addSubview:pickerView];
    } else {
        [self.alertView addSubview:pickerView];
    }
}

@end
