//
//  CXGLNEmptyDataView.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/7/6.
//

#import "CXGLNEmptyDataView.h"

@interface CXGLNEmptyDataView ()

@property (nonatomic, strong) UIImageView *noDataImageView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *detailL;

@end

@implementation CXGLNEmptyDataView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
           [self setupUI];
       }
       return self;
}

- (void)setupUI {
    [self addSubview:self.noDataImageView];
    [self addSubview:self.titleL];
    [self addSubview:self.detailL];

    [self addMasonry];
}

- (void)addMasonry {
    
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo (0.f * kScaleFit);
        make.top.mas_equalTo (64 * kScaleFit);
        make.height.mas_equalTo (184 * kScaleFit);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo (0.f * kScaleFit);
        make.top.mas_equalTo(self.noDataImageView.mas_bottom).mas_offset (8 * kScaleFit);
        make.height.mas_equalTo (25 * kScaleFit);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo (0.f * kScaleFit);
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset (0 * kScaleFit);
        make.height.mas_equalTo (25 * kScaleFit);
    }];
    
    ;
}
#pragma mark - Action

- (void)tapAction{
    
}

#pragma mark - Lazy

- (UIImageView *)noDataImageView {
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _noDataImageView.image = [UIImage imageNamed:@"icon_bg_kongyemian"];
    }
    return _noDataImageView;
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.textColor = UIColor.qd_tintColor;
        _titleL.font = [UIFont systemFontOfSize:18];
        _titleL.text = @"暂无数据~";
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_titleL addGestureRecognizer:tap];
    }
    return _titleL;
}

- (UILabel *)detailL {
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.textColor = [UIColorBlack colorWithAlphaComponent:0.4];
        _detailL.font = [UIFont systemFontOfSize:12];
        _detailL.text = @"请先认领课程，才能为该课程选用教材";
        _detailL.textAlignment = NSTextAlignmentCenter;

    }
    return _detailL;
}

@end
