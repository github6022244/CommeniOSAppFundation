//
//  CXGLNTitleSwitchCell.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/8.
//

#import "CXGLNTitleSwitchCell.h"

@implementation CXGLNTitleSwitchCell

+ (CGFloat)cellHeight {
    return 54.f;
}

- (void)base_setUpUI {
    [super base_setUpUI];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.switchV];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.mas_equalTo(16.f);
    }];
    
    [self.switchV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 16.f);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)actions_clickSwitch:(UISwitch *)aSwitch {
    if (_titleSwitchCellBlock) {
        _titleSwitchCellBlock(aSwitch.isOn);
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = UIColor.qd_descriptionTextColor;
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UISwitch *)switchV {
    if (!_switchV) {
        _switchV = [[UISwitch alloc] init];
        [_switchV addTarget:self action:@selector(actions_clickSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchV;
}

@end
