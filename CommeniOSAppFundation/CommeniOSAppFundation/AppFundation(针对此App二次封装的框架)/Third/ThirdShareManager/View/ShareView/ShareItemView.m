//
//  ShareItemView.m
//  CXGrainStudentApp
//
//  Created by User on 2020/10/13.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import "ShareItemView.h"
#import "ShareInfoModel.h"

@interface ShareItemView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ShareItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setupUI];
}

- (void)setupUI {
    self.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addMasonry];
}

- (void)addMasonry {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(self).mas_offset(-12);
        make.width.mas_equalTo(self.imageView.mas_height);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.imageView.mas_bottom);
    }];
}

- (void)setShareInfoModel:(ShareInfoModel *)shareInfoModel {
    _shareInfoModel = shareInfoModel;
    self.imageView.image = [UIImage imageNamed:shareInfoModel.itemImageName];
    self.titleLabel.text = shareInfoModel.itemTitle;
}

#pragma mark-- lazy
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor darkGrayColor];
    }
    return _titleLabel;
}

@end
