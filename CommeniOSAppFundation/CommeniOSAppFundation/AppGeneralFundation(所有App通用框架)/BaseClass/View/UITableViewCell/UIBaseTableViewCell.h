//
//  UIBaseTableViewCell.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/5/31.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBaseTableViewCell : QMUITableViewCell

- (void)base_setUpUI NS_REQUIRES_SUPER;

- (void)makeBackGroudColorNil;

///**
// *  初始化时调用的方法，会在两个 NS_DESIGNATED_INITIALIZER 方法中被调用，所以子类如果需要同时支持两个 NS_DESIGNATED_INITIALIZER 方法，则建议把初始化时要做的事情放到这个方法里。否则仅需重写要支持的那个 NS_DESIGNATED_INITIALIZER 方法即可。
// */
//- (void)didInitializeWithStyle:(UITableViewCellStyle)style NS_REQUIRES_SUPER;

/// 自动切圆角
/// 需要配合 updateCellAppearanceWithIndexPath: 使用
/// 初始化方法只能是 - (instancetype)initForTableView:(UITableView *)tableView withReuseIdentifier:(NSString *)reuseIdentifier
/// /// 默认切法：
/// QMUITableViewCellPositionFirstInSection : UIRectCornerTopLeft | UIRectCornerTopRight
/// QMUITableViewCellPositionMiddleInSection：没有圆角
/// QMUITableViewCellPositionLastInSection：UIRectCornerBottomLeft | UIRectCornerBottomRight
/// QMUITableViewCellPositionSingleInSection：UIRectCornerAllCorners
///
/// customeRectCornerForCellPosition 自定义 cellPosition 对应的需要切的圆角
/// 格式：
// @{ @(QMUICellPostion) : @(UIRectCorner) }
- (void)autoCornerWithCorner:(CGFloat)corner cornerView:(UIView *)cornerView customeRectCornerForCellPosition:(NSDictionary * _Nullable)customeRectCornerForCellPosition;

/// 重新计算切圆角view的frame，在自动切圆角时调用
/// 子类重写
- (void)autoCornerLayoutCornerViewFrame;

/// 自动显隐分隔线
- (void)autoControlSeparateLineView:(UIView *)separateLineView;

+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
