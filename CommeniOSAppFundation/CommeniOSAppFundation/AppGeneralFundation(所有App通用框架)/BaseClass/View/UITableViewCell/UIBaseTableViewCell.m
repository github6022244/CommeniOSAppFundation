//
//  UIBaseTableViewCell.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/5/31.
//

#import "UIBaseTableViewCell.h"
#import "UIView+GG.h"
#import "NSDictionary+GG.h"

@interface UIBaseTableViewCell ()

@property (nonatomic, assign) BOOL hasChangedBackGroudColor;

@property (nonatomic, strong) UIView *cornerView;

@property (nonatomic, assign) CGFloat corner;

@property (nonatomic, strong) NSDictionary *customeRectCornerForCellPosition;// 自定义cellPosition对应的圆角位置

/// 分割线 view
@property (nonatomic, strong) UIView *separateLineView;

@end

@implementation UIBaseTableViewCell

#pragma mark ------------------------- Cycle -------------------------
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
//        [self didInitializeWithStyle:UITableViewCellStyleDefault];
        
//        [self base_setUpUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self didInitializeWithStyle:style];
        
        [self base_setUpUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self base_setUpUI];
}

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
    [super didInitializeWithStyle:style];
    
}

- (void)makeBackGroudColorNil {
    self.backgroundColor = nil;
    self.backgroundView.backgroundColor = nil;
    self.contentView.backgroundColor = nil;
}

#pragma mark ------------------------- UI -------------------------
- (void)base_setUpUI {
    self.backgroundColor = nil;
    self.contentView.backgroundColor = UIColorForBackground;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
    [super updateCellAppearanceWithIndexPath:indexPath];
    
    if (!_corner || !_cornerView) {
        return;
    }
    
    QMUITableViewCellPosition cellPosition = self.cellPosition;
    
    [self.contentView layoutIfNeeded];
    
    [self autoCornerLayoutCornerViewFrame];
    
    [self.cornerView removeCorners];
    
    if ([_customeRectCornerForCellPosition.allKeys containsObject:@(cellPosition)]) {
        /// 有自定义 cellPosition 对应的 圆角 UIRectCorner
        /// 按照指定的来切
        NSNumber *cornerNum = [_customeRectCornerForCellPosition gg_safeObjectForKey:@(cellPosition)];
        
        if (cornerNum.integerValue <= 0) {
            [self.cornerView removeCorners];
        } else {
            UIRectCorner corner = cornerNum.integerValue;
            
            [self.cornerView addCornersbyRoundingCorners:corner cornerRadii:CGSizeMake(_corner, _corner)];
        }
        return;
    }
    
    /// 默认切法：
    /// QMUITableViewCellPositionFirstInSection : UIRectCornerTopLeft | UIRectCornerTopRight
    /// QMUITableViewCellPositionMiddleInSection：没有圆角
    /// QMUITableViewCellPositionLastInSection：UIRectCornerBottomLeft | UIRectCornerBottomRight
    /// QMUITableViewCellPositionSingleInSection：UIRectCornerAllCorners
    if ((cellPosition & QMUITableViewCellPositionSingleInSection) == QMUITableViewCellPositionSingleInSection) {
        [self.cornerView addCornersbyRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(_corner, _corner)];
        
        self.separateLineView.hidden = YES;
    } else if ((cellPosition & QMUITableViewCellPositionFirstInSection) == QMUITableViewCellPositionFirstInSection) {
        [self.cornerView addCornersbyRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(_corner, _corner)];
        
        self.separateLineView.hidden = NO;
    } else if ((cellPosition & QMUITableViewCellPositionMiddleInSection) == QMUITableViewCellPositionMiddleInSection) {
        [self.cornerView removeCorners];
        
        self.separateLineView.hidden = NO;
    } else if ((cellPosition & QMUITableViewCellPositionLastInSection) == QMUITableViewCellPositionLastInSection) {
        [self.cornerView addCornersbyRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(_corner, _corner)];
        
        self.separateLineView.hidden = YES;
    }
}

#pragma mark ------------------------- Interface -------------------------
+ (CGFloat)cellHeight {
    return UITableViewAutomaticDimension;
}

- (void)autoCornerWithCorner:(CGFloat)corner cornerView:(UIView *)cornerView customeRectCornerForCellPosition:(NSDictionary *)customeRectCornerForCellPosition {
    _corner = corner;
    
    _cornerView = cornerView;
    
    _customeRectCornerForCellPosition = customeRectCornerForCellPosition;
}

/// 重新计算切圆角view的frame，在自动切圆角时调用
- (void)autoCornerLayoutCornerViewFrame {
    
}

/// 自动显隐分隔线
- (void)autoControlSeparateLineView:(UIView *)separateLineView {
    _separateLineView = separateLineView;
}

@end
