//
//  UIView+GG.m
//  FrameDemo
//
//  Created by Wei on 2017/9/21.
//  Copyright © 2017年 weiyi. All rights reserved.
//

#import "UIView+GG.h"
#import <objc/runtime.h>
#import <Masonry.h>
#import <QMUIKit.h>

@implementation UIView (GG)

#pragma mark 添加圆角
- (void)addCornersbyRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    self.layer.masksToBounds = YES;
    
    [self removeCorners];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    shapeLayer.name = @"GGCornersLayer";
    [self.layer addSublayer:shapeLayer];
    self.layer.mask = shapeLayer;
}

- (void)addCornersbyRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor
{
    [self removeCorners];
    
    CAShapeLayer *dottedLineBorder  = [[CAShapeLayer alloc] init];
    dottedLineBorder.frame = self.bounds;
    [dottedLineBorder setLineWidth:lineWidth];
    if (strokeColor) {
        [dottedLineBorder setStrokeColor:strokeColor.CGColor];
    }
    if (fillColor) {
        [dottedLineBorder setFillColor:fillColor.CGColor];
    }
//    dottedLineBorder.lineDashPattern = @[@10,@20];//10 - 线段长度 ，20 － 线段与线段间距
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    dottedLineBorder.path = path.CGPath;
    dottedLineBorder.name = @"GGCornersLayer";
    [self.layer addSublayer:dottedLineBorder];
}

- (void)removeCorners {
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer.name isEqualToString:@"GGCornersLayer"]) {
            [subLayer removeFromSuperlayer];
        }
    }
}

#pragma mark 添加阴影
- (void)addShadowWithColor:(UIColor *)shadowColor shadowOpacity:(float)shadowOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius
{
    CALayer *shadowLayer0 = [[CALayer alloc] init];
    shadowLayer0.frame = self.bounds;
    shadowLayer0.shadowColor = shadowColor.CGColor;
    shadowLayer0.shadowOpacity = shadowOpacity;
    shadowLayer0.shadowOffset = shadowOffset;
    shadowLayer0.shadowRadius = shadowRadius;
    CGFloat shadowSize0 = 0;
    CGRect shadowSpreadRect0 = CGRectMake(-shadowSize0, -shadowSize0, self.bounds.size.width+shadowSize0*2, self.bounds.size.height+shadowSize0*2);
    CGFloat shadowSpreadRadius0 =  self.layer.cornerRadius == 0 ? 0 : self.layer.cornerRadius+shadowSize0;
    UIBezierPath *shadowPath0 = [UIBezierPath bezierPathWithRoundedRect:shadowSpreadRect0 cornerRadius:shadowSpreadRadius0];
    shadowLayer0.shadowPath = shadowPath0.CGPath;
    [self.layer addSublayer:shadowLayer0];
}

#pragma mark - 添加分割线
- (UIView *)addSepratorLineWithTopSpace:(CGFloat)topSpace leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace lineColor:(UIColor *)lineColor
{
    /**< 分割线 */
    UIView * lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSpace);
        make.top.mas_equalTo(topSpace);
        make.right.mas_equalTo(- rightSpace);
        make.height.mas_equalTo(0.5);
    }];
//    lineView.backgroundColor = lineColor?:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    lineView.backgroundColor = UIColorSeparator;
    lineView.tag = 7788;
    return lineView;
}

- (void)removeSeperatorLineView {
    UIView *lineView = [self viewWithTag:7788];
    [lineView removeFromSuperview];
    lineView = nil;
}

#pragma mark 添加底部分割线
- (UIView *)addBottomSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace bottomSpace:(CGFloat)bottomSpace {
    /**< 分割线 */
    UIView * lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSpace);
        make.bottom.mas_equalTo(- bottomSpace);
        make.right.mas_equalTo(- rightSpace);
        make.height.mas_equalTo(0.5);
    }];
//    lineView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    lineView.backgroundColor = [UIColorBlack colorWithAlphaComponent:0.1];
    lineView.tag = 8899;
    return lineView;
}

- (UIView *)addBottomSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace
{
    /**< 分割线 */
    return [self addBottomSepratorLineWithLeftSpace:leftSpace rightSpace:rightSpace bottomSpace:0];
}

- (UIView *)addBottomSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace lineColor:(UIColor *)lineColor
{
    UIView * lineView = [self addBottomSepratorLineWithLeftSpace:leftSpace rightSpace:rightSpace];
    lineView.backgroundColor = lineColor;
    return lineView;
}

- (void)removeBottomLineView {
    UIView *lineView = [self viewWithTag:8899];
    [lineView removeFromSuperview];
    lineView = nil;
}

#pragma mark  添加顶部分割线
- (UIView *)addTopSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace
{
    /**< 分割线 */
    UIView * lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSpace);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(- rightSpace);
        make.height.mas_equalTo(0.5);
    }];
//    lineView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    lineView.backgroundColor = UIColorSeparator;
    lineView.tag = 9988;
    return lineView;
}

- (UIView *)addTopSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace lineColor:(UIColor *)lineColor
{
    UIView * lineView = [self addTopSepratorLineWithLeftSpace:leftSpace rightSpace:rightSpace];
    lineView.backgroundColor = lineColor;
    return lineView;
}

- (UIView *)addTopSepratorLineWithLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace topSpace:(CGFloat)topSapce {
    UIView * lineView = [self addTopSepratorLineWithLeftSpace:leftSpace rightSpace:rightSpace];
    [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topSapce);
    }];
    
    return lineView;
}

- (void)removeTopLineView {
    UIView *lineView = [self viewWithTag:9988];
    [lineView removeFromSuperview];
    lineView = nil;
}

#pragma mark 添加垂直方向分割线
- (UIView *)addVerticalSepratorLineIsOnRight:(BOOL)is
{
    return [self addVerticalSepratorLineIsOnRight:is topSpace:0 bottomSpace:0];
}

- (UIView *)addVerticalSepratorLineIsOnRight:(BOOL)is topSpace:(CGFloat)topSpace bottomSpace:(CGFloat)bottomSpace {
    /**< 分割线 */
    UIView * lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (is) {
            make.right.equalTo(self).mas_equalTo(- 1);
        } else {
            make.left.equalTo(self);
        }
        make.top.mas_equalTo(topSpace);
        make.bottom.mas_equalTo(- bottomSpace);
        make.width.mas_equalTo(0.5);
    }];
//    lineView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    lineView.backgroundColor = UIColorSeparator;
    return lineView;
}

#pragma mark 展示/关闭菊花(系统)
- (void)activityIndicatorViewShow:(BOOL)isToShow
{
    if (!self.indicator) {
        /**< 不是第一次加载数据 */
        self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
        [self addSubview:self.indicator];
        self.indicator.clipsToBounds = YES;
        self.indicator.center = self.center;
        self.indicator.userInteractionEnabled = YES;
        [self.indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    
    if (!isToShow) {
        [self.indicator stopAnimating];
        [self.indicator removeFromSuperview];
        self.indicator = nil;
    }else
    {
        [self.indicator startAnimating];
    }
}

#pragma mark - 添加点击事件
// 添加点击回调
- (void)addTapGestureRecognizerWithBlock:(GGViewTapBlock)block
{
    self.tapBlock = block;
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
    [self addGestureRecognizer:gest];
    self.userInteractionEnabled = YES;
}

- (void)clickAction:(UITapGestureRecognizer *)gest
{
    if (self.tapBlock) {
        self.tapBlock();
    }
}

#pragma mark - 局部透明
- (CAShapeLayer *)addTransparencyViewWith:(UIBezierPath *)tempPath{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:[UIScreen mainScreen].bounds];
    [path appendPath:tempPath];
    path.usesEvenOddFillRule = YES;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor= [UIColor whiteColor].CGColor;  //其他颜色都可以，只要不是透明的
    shapeLayer.fillRule=kCAFillRuleEvenOdd;
    return shapeLayer;
}

//左右渐变
- (void)addTransitionColorLeftToRight:(UIColor *)startColor endColor:(UIColor *)endColor {
    [self addTransitionColor:startColor endColor:endColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
}

//斜渐变
- (void)addTransitionColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    [self addTransitionColor:startColor endColor:endColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
}

- (void)addTransitionColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint {
    [self removeTransitionColorLayer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0, @1];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = self.bounds;
    gradientLayer.name = @"addTransitionColor";
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self;
        if (button.currentImage) {
//            [button setImage:button.currentImage forState:UIControlStateNormal];
            [button bringSubviewToFront:button.imageView];
        }
    }
    
    self.clipsToBounds = YES;
}

- (void)removeTransitionColorLayer {
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer.name isEqualToString:@"addTransitionColor"]) {
            [subLayer removeFromSuperlayer];
            break;
        }
    }
}

#pragma mark ---------------------------- set / get ----------------------------
#pragma mark indicator
- (UIActivityIndicatorView *)indicator
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setIndicator:(UIActivityIndicatorView *)indicator
{
    objc_setAssociatedObject(self, @selector(indicator), indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark corners
- (void)setCurrentCorner:(GGCornerType)currentCorner
{
    objc_setAssociatedObject(self, @selector(currentCorner), [NSNumber numberWithInteger:currentCorner], OBJC_ASSOCIATION_RETAIN);
}

- (GGCornerType)currentCorner
{
    NSNumber *num = objc_getAssociatedObject(self, _cmd);
    return num.integerValue;
}

#pragma mark 点击block
- (void)setTapBlock:(GGViewTapBlock)tapBlock
{
    objc_setAssociatedObject(self, @selector(tapBlock), tapBlock, OBJC_ASSOCIATION_COPY);
}

- (GGViewTapBlock)tapBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
