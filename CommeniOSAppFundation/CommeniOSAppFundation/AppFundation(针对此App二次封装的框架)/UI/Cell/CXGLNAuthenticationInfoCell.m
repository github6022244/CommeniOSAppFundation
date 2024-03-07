//
//  CXGLNAuthenticationInfoCell.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/2.
//

#import "CXGLNAuthenticationInfoCell.h"

#define kLeftMargin 16
#define kRowHeight 54

@interface CXGLNAuthenticationInfoCell ()

@property (nonatomic, strong) UIImageView *nextImageView;

@end

@implementation CXGLNAuthenticationInfoCell

- (void)base_setUpUI {
    [super base_setUpUI];
    
    self.separatorInset = UIEdgeInsetsMake(0, kLeftMargin, 0, kLeftMargin);
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.nextImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeftMargin);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(100);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(kLeftMargin);
        make.right.mas_equalTo(self.nextImageView.mas_left);
    }];
    
    [self.nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(18);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.separatorInset = UIEdgeInsetsMake(0, kLeftMargin, 0, kLeftMargin);
}

- (void)setCanEdit:(BOOL)canEdit {
    _canEdit = canEdit;
    self.nextImageView.hidden = canEdit;
//    [self.nextImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(canEdit ? 0 : 18);
//    }];
}

- (void)setRequired:(BOOL)required {
    _required = required;
    NSString *title = self.titleLabel.text;
    
    if (required) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ *", title]];
        [attStr addAttributes:@{NSForegroundColorAttributeName : UIColor.qd_descriptionTextColor} range:NSMakeRange(0, title.length)];
        [attStr addAttributes:@{NSForegroundColorAttributeName : BadgeBackgroundColor} range:NSMakeRange(title.length + 1, 1)];
        self.titleLabel.attributedText = attStr;
    } else {
        self.titleLabel.text = title;
    }
}

- (void)setTitle:(NSString *)title required:(BOOL)required canEdit:(BOOL)canEdit {
    if (required) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ *", title]];
        [attStr addAttributes:@{NSForegroundColorAttributeName : UIColor.qd_descriptionTextColor} range:NSMakeRange(0, title.length)];
        [attStr addAttributes:@{NSForegroundColorAttributeName : BadgeBackgroundColor} range:NSMakeRange(title.length + 1, 1)];
        self.titleLabel.attributedText = attStr;
    } else {
        self.titleLabel.text = title;
    }
    
    self.nextImageView.hidden = self.canEdit;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = UIColor.qd_descriptionTextColor;
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.font = [UIFont systemFontOfSize:16.0f];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.textColor = UIColor.qd_mainTextColor;
    }
    return _textField;
}

- (UIImageView *)nextImageView {
    if (!_nextImageView) {
        _nextImageView = [[UIImageView alloc] init];
        _nextImageView.backgroundColor = [UIColor clearColor];
        _nextImageView.image = [UIImage imageNamed:@"icon_authenticationArrow"];
    }
    return _nextImageView;
}

@end
