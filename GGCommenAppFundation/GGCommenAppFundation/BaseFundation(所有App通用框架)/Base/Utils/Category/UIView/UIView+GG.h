//
//  UIView+GG.h
//  FrameDemo
//
//  Created by Wei on 2017/9/21.
//  Copyright © 2017年 weiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+GGFrame.h"

typedef void(^GGViewTapBlock)(void);

typedef NS_ENUM(NSInteger, GGCornerType) {
    GGCornerType_None,/**< 没有圆角 */
    GGCornerType_TopTowCorner,/**< 顶部两个角 */
    GGCornerType_BottomTowCorner,/**< 底部两个角 */
    GGCornerType_All,/**< 四个角 */
};

@interface UIView (GG)

@property (nonatomic, copy) GGViewTapBlock tapBlock;/**< 点击回调 */

@property (strong, nonatomic) UIActivityIndicatorView * indicator;/**< 菊花(系统样式) */

/**
 添加圆角
 */
- (void)addCornersbyRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
- (void)addCornersbyRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor;
@property (nonatomic, assign) GGCornerType currentCorner;/**< 当前的corner */
- (void)removeCorners;

//左右渐变
- (void)addTransitionColorLeftToRight:(UIColor *)startColor endColor:(UIColor *)endColor;
//斜渐变
- (void)addTransitionColor:(UIColor *)startColor endColor:(UIColor *)endColor;
- (void)addTransitionColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint;
- (void)removeTransitionColorLayer;

/**
 添加阴影
 */
- (void)addShadowWithColor:(UIColor *)shadowColor shadowOpacity:(float)shadowOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius;

/**
 添加分割线
 */
- (UIView *)addSepratorLineWithTopSpace:(CGFloat)topSpace leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace lineColor:(UIColor *)lineColor;

- (void)removeSeperatorLineView;

/**
 添加底部分割线
 */
- (UIView *)addBottomSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace bottomSpace:(CGFloat)bottomSpace;

- (UIView *)addBottomSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;

- (UIView *)addBottomSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace lineColor:(UIColor *)lineColor;

- (void)removeBottomLineView;

/**
 添加顶部分割线
 */
- (UIView *)addTopSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;

- (UIView *)addTopSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace lineColor:(UIColor *)lineColor;

- (UIView *)addTopSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace topSpace:(CGFloat)topSapce;

- (void)removeTopLineView;

/**
 添加垂直方向分割线

 @param is 是否在右侧
 */
- (UIView *)addVerticalSepratorLineIsOnRight:(BOOL)is;

- (UIView *)addVerticalSepratorLineIsOnRight:(BOOL)is topSpace:(CGFloat)topSpace bottomSpace:(CGFloat)bottomSpace;

/**
 添加点击block
 */
- (void)addTapGestureRecognizerWithBlock:(GGViewTapBlock)block;

/**
 局部透明
 */
- (CAShapeLayer *)addTransparencyViewWith:(UIBezierPath *)tempPath;
@end
