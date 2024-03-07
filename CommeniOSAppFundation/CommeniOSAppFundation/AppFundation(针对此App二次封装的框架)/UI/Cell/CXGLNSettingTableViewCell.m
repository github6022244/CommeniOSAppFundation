//
//  CXGLNSettingTableViewCell.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/6.
//

#import "CXGLNSettingTableViewCell.h"

@interface CXGLNSettingTableViewCell ()

@property (nonatomic, strong) UIImageView *rightArrowImageView;

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation CXGLNSettingTableViewCell

- (void)base_setUpUI {
    [super base_setUpUI];
    
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.rightArrowImageView];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lineView];
    [self addMasonry];
}

- (void)addMasonry {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16.f * kScaleFit);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(25 * kScaleFit);
    }];

    [self.rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-16.f * kScaleFit);
        make.height.width.mas_equalTo(16 * kScaleFit);
    }];

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightArrowImageView.mas_left).mas_offset(-8.f * kScaleFit);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(22.f * kScaleFit);
        make.height.mas_equalTo(22 * kScaleFit);
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16.f * kScaleFit);
        make.left.mas_equalTo(16.f * kScaleFit);
        make.height.mas_equalTo(1.f * kScaleFit);
        make.bottom.mas_equalTo(0);
    }];

    //    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(16.f* kScaleFit);
    //        make.top.mas_equalTo(self.detailLabel.mas_bottom).mas_offset(8.f* kScaleFit);
    //        make.width.mas_equalTo(96 * kScaleFit);
    //        make.height.mas_equalTo(72 * kScaleFit);
    //    }];
}

- (void)setLeftLabelText:(NSString *)leftStr AndRightLabelText:(NSString *)rightStr rightFont:(CGFloat)rightFontSize {
    self.titleLabel.text = leftStr;
    self.detailLabel.text = rightStr;
    self.detailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:rightFontSize];
}

+ (CGFloat)cellHeight {
    return 55.f;
}

#pragma mark - Lazy
- (UIImageView *)rightArrowImageView {
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightArrowImageView.image = [UIImage imageNamed:@"icon_authenticationArrow"];
    }
    return _rightArrowImageView;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _coverImageView.image = [UIImage imageNamed:@"icon_personSpaceDynamicDefault"];
    }
    return _coverImageView;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _detailLabel.textColor = UIColor.qd_descriptionTextColor;
        _detailLabel.text = @"";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = UIFontMediumMake(16.f);
        _titleLabel.textColor = UIColor.qd_titleTextColor;
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];

        _lineView.backgroundColor = UIColorSeparator;
    }
    return _lineView;
}

@end
