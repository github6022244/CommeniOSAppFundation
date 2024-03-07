//
//  CXGLNTitleSwitchCell.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/8.
//

#import "GGBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXGLNTitleSwitchCell : GGBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UISwitch *switchV;

@property (nonatomic, copy) void(^titleSwitchCellBlock)(BOOL isOn);

@end

NS_ASSUME_NONNULL_END
