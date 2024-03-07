//
//  GGBaseTitleImageView.m
//  CXGrainStudentApp
//
//  Created by GG on 2022/4/22.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "GGBaseTitleImageView.h"

@interface GGBaseTitleImageView ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIImageView *rightArrowImageView;

@property (nonatomic, strong) UIImageView *rightRedImageView;
@property (nonatomic, assign) CGFloat rightRedImageViewSize;

@end

@implementation GGBaseTitleImageView

#pragma mark ------------------------- Cycle -------------------------
+ (instancetype)view {
    GGBaseTitleImageView *view = [[GGBaseTitleImageView alloc] qmui_initWithSize:CGSizeMake(SCREEN_WIDTH, [self viewHeight])];
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark ------------------------- UI -------------------------
- (void)setUpUI {
    _rightRedImageViewSize = 5;
    
    self.backgroundColor = UIColorForBackground;
    
    self.iconImageView = [UIImageView new];
    [self addSubview:self.iconImageView];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleLabel = [UILabel labelWithSuperView:self withContent:nil withBackgroundColor:nil withTextColor:UIColorMakeWithHex(@"#15171A") withFont:UIFontBoldMake(18)];
    
    self.rightArrowImageView = [UIImageView new];
    [self addSubview:_rightArrowImageView];
    _rightArrowImageView.image = UIImageMake(@"newstudent_arrow_black_black");
    _rightRedImageView.contentMode = UIViewContentModeScaleAspectFit;
    _rightArrowImageView.hidden = YES;
    
    _rightRedImageView = [UIImageView new];
    [self addSubview:_rightRedImageView];
    _rightRedImageView.backgroundColor = UIColorRed;
    _rightRedImageView.layer.cornerRadius = _rightRedImageViewSize / 2.0;
    _rightRedImageView.hidden = YES;
    
    _subTitleLabel = [UILabel labelWithSuperView:self withContent:nil withBackgroundColor:nil withTextColor:UIColor.qd_descriptionTextColor withFont:UIFontMake(14)];
    
    [self layOutMasonry];
}

- (void)layOutMasonry {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16.0 * kScaleFit);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20 * kScaleFit, 20 * kScaleFit));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(self.iconImageView.mas_right).mas_equalTo(8 * kScaleFit);
    }];
    
    [_rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(- 16 * kScaleFit);
        make.size.mas_equalTo(CGSizeMake(7 * kScaleFit, 12 * kScaleFit));
    }];
    
    [_rightRedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.rightArrowImageView.mas_left).mas_equalTo(- 6 * kScaleFit);
        make.size.mas_equalTo(CGSizeMake(self.rightRedImageViewSize, self.rightRedImageViewSize));
    }];
    
    if (_showRightRedPointView) {
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self.rightRedImageView.mas_left).mas_equalTo(- 6 * kScaleFit);
        }];
    } else {
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self.rightArrowImageView.mas_left).mas_equalTo(- 6 * kScaleFit);
        }];
    }
}

#pragma mark ------------------------- Interface -------------------------
+ (CGFloat)viewHeight {
    return 57.0;
}

#pragma mark ------------------------- set / get -------------------------
- (void)setTitle:(NSString *)title {
    _title = title.copy;
    
    self.titleLabel.text = _title;
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    
    self.iconImageView.image = _icon;
}

- (void)setShowRightRedPointView:(BOOL)showRightRedPointView {
    _showRightRedPointView = showRightRedPointView;
    
    _rightRedImageView.hidden = !showRightRedPointView;
}

- (void)setShowRightArrowImage:(BOOL)showRightArrowImage {
    _showRightArrowImage = showRightArrowImage;
    
    _rightArrowImageView.hidden = !_showRightArrowImage;
}

- (void)setItemModel:(GGBaseTitleImageItem *)itemModel {
    _itemModel = itemModel;
    
    self.title = itemModel.title;
    self.icon = UIImageMake(itemModel.icon);
    
    self.showRightArrowImage = itemModel.showRightArrowImageView;
    self.showRightRedPointView = itemModel.showRightRedImageView;
    self.subTitleLabel.text = itemModel.subTitle;
    
    [self layOutMasonry];
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle.copy;
    
    self.subTitleLabel.text = subTitle;
}

@end












@implementation GGBaseTitleImageItem

MJLogAllIvars

@end
