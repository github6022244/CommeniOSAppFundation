//
//  CXGLNBaseNoLoginView.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/7/6.
//

#import "CXGLNBaseNoLoginView.h"

@implementation CXGLNBaseNoLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
           [self setupUI];
       }
       return self;
}

- (void)setupUI {
    [self addSubview:self.noLoginImageView];
    [self addSubview:self.titleL];
    [self addSubview:self.detailL];
    [self addSubview:self.loginButton];

    [self addMasonry];

    
}

- (void)addMasonry {
    
    [self.noLoginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo (0.f * kScaleFit);
        make.top.mas_equalTo (64 * kScaleFit);
        make.height.mas_equalTo (184 * kScaleFit);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo (0.f * kScaleFit);
        make.top.mas_equalTo(self.noLoginImageView.mas_bottom).mas_offset (8 * kScaleFit);
        make.height.mas_equalTo (25 * kScaleFit);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo (0.f * kScaleFit);
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset (0 * kScaleFit);
        make.height.mas_equalTo (25 * kScaleFit);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (96.f * kScaleFit);
        make.right.mas_equalTo (-96.f * kScaleFit);

        make.top.mas_equalTo(self.detailL.mas_bottom).mas_offset (40 * kScaleFit);
        make.height.mas_equalTo (48 * kScaleFit);
    }];
}
#pragma mark - Action

- (void)loginAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginButtonDidClick)]) {
        [self.delegate loginButtonDidClick];
    }
}

#pragma mark - Lazy

- (UIImageView *)noLoginImageView {
    if (!_noLoginImageView) {
        _noLoginImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _noLoginImageView.image = [UIImage imageNamed:@"icon_coursespace_nologin"];
    }
    return _noLoginImageView;
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.textColor = [UIColorBlack colorWithAlphaComponent:0.4];
        _titleL.font = [UIFont systemFontOfSize:18];
        _titleL.text = @"随时随地在线";
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}

- (UILabel *)detailL {
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.textColor = [UIColorBlack colorWithAlphaComponent:0.4];
        _detailL.font = [UIFont systemFontOfSize:18];
        _detailL.text = @"教材选用及订购";
        _detailL.textAlignment = NSTextAlignmentCenter;

    }
    return _detailL;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = UIColor.qd_tintColor;
        _loginButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        [_loginButton setTitleColor:UIColorForBackground forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 8 * kScaleFit;
    }
    return _loginButton;
}

@end
