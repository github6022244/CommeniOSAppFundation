//
//  CXGLNIconTextField.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/2.
//

#import "CXGLNIconTextField.h"

@interface CXGLNIconTextField ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation CXGLNIconTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.lineView];
    [self addSubview:self.leftIconView];
    [self addSubview:self.textField];
    [self addMasonry];
}

- (void)addMasonry {
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.f * kScaleFit);
        make.right.mas_equalTo(0.f * kScaleFit);
        make.bottom.mas_equalTo(0.f * kScaleFit);
        make.height.mas_equalTo(1.f * kScaleFit);
    }];

    [self.leftIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.f * kScaleFit);
//        make.top.mas_equalTo(9.f * kScaleFit);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(24.f * kScaleFit);
    }];

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftIconView.mas_right).mas_offset(16 * kScaleFit);
        make.right.mas_equalTo(0.f * kScaleFit);
        make.bottom.mas_equalTo(0.f * kScaleFit);
        make.height.mas_equalTo(49.f * kScaleFit);
    }];
}

#pragma mark - Lazy

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = UIColorSeparator;
    }
    return _lineView;
}

- (UIImageView *)leftIconView {
    if (!_leftIconView) {
        _leftIconView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _leftIconView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[QMUITextField alloc] init];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.font = [UIFont systemFontOfSize:16.0f];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.textColor = UIColor.qd_titleTextColor;
    }
    return _textField;
}

@end
