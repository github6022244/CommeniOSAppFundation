//
//  CXGSearchBar.m
//  ChangXiangGrain
//
//  Created by GG on 2022/11/4.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "CXGSearchBar.h"

@interface CXGSearchBar ()
/// 重新指定搜索框边距
@property (nonatomic, assign) BOOL resetSearchTFEdgeInsets;

@end

@implementation CXGSearchBar

#pragma mark ------------------------- Cycle -------------------------
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    
    return self;
}

#pragma mark ------------------------- UI -------------------------
- (void)setUpUI {
    self.backgroundColor = UIColorForBackground;
    _searchTFEdgeInsets = UIEdgeInsetsMake(5.f, 16.f, 5.f, 59.f);
    
    [self addSubview:self.searchTF];
    
    [self addSubview:self.rightButton];
    
    [self updateMasory];
}

- (void)updateMasory {
    BOOL hidden_rightButton = self.rightButton.isHidden;
    
    if (hidden_rightButton && !_resetSearchTFEdgeInsets) {
        UIEdgeInsetsSetRight(self.searchTFEdgeInsets, 16.f);
    }
    
    [self.searchTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.searchTFEdgeInsets);
    }];
    
    [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.searchTF);
        make.right.equalTo(self);
        make.left.equalTo(self.searchTF.mas_right);
    }];
    
    _searchTF.leftView = [self _createTextFieldLeftView];
}

#pragma mark ------------------------- Private -------------------------
#pragma mark --- 创建输入框 left view
- (UIView *)_createTextFieldLeftView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.qmui_size = CGSizeMake(44.f, self.qmui_height - self.searchTFEdgeInsets.top - self.searchTFEdgeInsets.bottom);
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_homepage_search"]];
    [bgView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(bgView);
        make.left.mas_equalTo(16.f);
    }];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    return bgView;
}

#pragma mark ------------------------- set / get -------------------------
- (QMUITextField *)searchTF {
    if (!_searchTF) {
        _searchTF = [[QMUITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 34.f)];
        _searchTF.font = [UIFont systemFontOfSize:14];
        _searchTF.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
        _searchTF.layer.masksToBounds = YES;
        _searchTF.layer.cornerRadius = 8;
        _searchTF.leftView = [self _createTextFieldLeftView];
        _searchTF.leftViewMode = UITextFieldViewModeAlways;
        _searchTF.returnKeyType = UIReturnKeySearch;
//        _searchTF.delegate = self;
        _searchTF.placeholder = @"请输入文字..";
        _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _searchTF;
}

- (QMUIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitleColor:UIColorMakeWithHex(@"#666666") forState:UIControlStateNormal];
        _rightButton.titleLabel.font = UIFontMake(14.f);
    }
    
    return _rightButton;
}

- (void)setSearchTFEdgeInsets:(UIEdgeInsets)searchTFEdgeInsets {
    _searchTFEdgeInsets = searchTFEdgeInsets;
    
    _resetSearchTFEdgeInsets = YES;
    
    [self updateMasory];
}

@end
