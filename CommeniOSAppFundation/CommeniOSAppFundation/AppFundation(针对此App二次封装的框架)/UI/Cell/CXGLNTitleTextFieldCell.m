//
//  CXGLNTitleTextFieldCell.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/8.
//

#import "CXGLNTitleTextFieldCell.h"

@interface CXGLNTitleTextFieldCell ()

//@property (nonatomic, strong) UIImageView *nextImageView;

@end

@implementation CXGLNTitleTextFieldCell

+ (CGFloat)cellHeight {
    return 54.f;
}

- (void)base_setUpUI {
    [super base_setUpUI];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
//    [self.contentView addSubview:self.nextImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.mas_equalTo(16.f);
        make.width.mas_lessThanOrEqualTo(100.f);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.mas_equalTo(- 16.f);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right);
    }];
    
//    [self.nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        <#code#>
//    }];
}

- (void)setCanEdit:(BOOL)canEdit {
    _canEdit = canEdit;
    
    self.textField.userInteractionEnabled = _canEdit;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = UIColor.qd_descriptionTextColor;
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

- (QMUITextField *)textField {
    if (!_textField) {
        _textField = [[QMUITextField alloc] init];
//        _textField.backgroundColor = [UIColor clearColor];
        _textField.font = [UIFont systemFontOfSize:16.0f];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.textColor = UIColor.qd_titleTextColor;
    }
    return _textField;
}

//- (UIImageView *)nextImageView {
//    if (!_nextImageView) {
//        _nextImageView = [[UIImageView alloc] init];
////        _nextImageView.backgroundColor = [UIColor clearColor];
//        _nextImageView.image = [UIImage imageNamed:@"icon_next"];
//    }
//    return _nextImageView;
//}

@end
