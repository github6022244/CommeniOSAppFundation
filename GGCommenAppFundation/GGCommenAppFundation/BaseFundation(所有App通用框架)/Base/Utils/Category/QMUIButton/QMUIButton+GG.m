//
//  QMQMUIButton+GG.m
//  RKZhiChengYunHuiTong
//
//  Created by GG on 2020/11/20.
//

#import "QMUIButton+GG.h"
#import <objc/runtime.h>
#import <QMUIKit.h>

@interface QMUIButton ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *backgroundColors;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIFont *> *titleLabelFonts;

@end

@implementation QMUIButton (GG)

#pragma mark ------------------------- Interface -------------------------
#pragma mark - 快速创建 button

/**
 QMUIButton：快速创建 button1：frame、title、titleColor、titleFont
 
 @param frame frame
 @param title title
 @param titleColor titleColor
 @param titleFont titleFont
 @return button
 */
+ (id)gg_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
              titleColor:(UIColor * __nullable)titleColor
               titleFont:(UIFont * __nullable)titleFont {
    QMUIButton *button = [QMUIButton gg_buttonWithFrame:frame title:title titleColor:titleColor titleFont:titleFont backgroundColor:nil];
    
    return button;
}

/**
 QMUIButton：快速创建 button2：frame、title、backgroundColor
 
 @param frame frame
 @param title title
 @param backgroundColor backgroundColor
 @return button
 */
+ (id)gg_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
         backgroundColor:(UIColor * __nullable)backgroundColor {
    QMUIButton *button = [QMUIButton gg_buttonWithFrame:frame title:title titleColor:nil titleFont:nil backgroundColor:backgroundColor];
    
    return button;
}

/**
 QMUIButton：快速创建 button3：frame、title、titleColor、titleFont、backgroundColor
 
 @param frame frame
 @param title title
 @param titleColor titleColor
 @param titleFont titleFont
 @param backgroundColor backgroundColor
 @return button
 */
+ (id)gg_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
              titleColor:(UIColor * __nullable)titleColor
               titleFont:(UIFont * __nullable)titleFont
         backgroundColor:(UIColor * __nullable)backgroundColor {
    QMUIButton *button = [QMUIButton gg_buttonWithFrame:frame title:title titleColor:titleColor titleFont:titleFont image:nil backgroundColor:backgroundColor];
    
    return button;
}

/**
 QMUIButton：快速创建 button4：frame、title、backgroundImage
 
 @param frame frame
 @param title title
 @param backgroundImage backgroundImage
 @return button
 */
+ (id)gg_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
         backgroundImage:(UIImage * __nullable)backgroundImage {
    QMUIButton *button = [QMUIButton gg_buttonWithFrame:frame title:title titleColor:nil titleFont:nil image:nil backgroundImage:backgroundImage];
    return button;
}

/**
 QMUIButton：快速创建 button5：frame、title、titleColor、titleFont、image、backgroundColor
 
 @param frame frame description
 @param title title description
 @param titleColor titleColor description
 @param titleFont titleFont description
 @param image image description
 @param backgroundColor backgroundColor description
 @return button
 */
+ (instancetype)gg_buttonWithFrame:(CGRect)frame
                             title:(NSString * __nullable)title
                        titleColor:(UIColor * __nullable)titleColor
                         titleFont:(UIFont * __nullable)titleFont
                             image:(UIImage * __nullable)image
                   backgroundColor:(UIColor * __nullable)backgroundColor {
    QMUIButton *button = [QMUIButton gg_creatButtonWithFrame:frame title:title selTitle:nil disableTitle:nil titleColor:titleColor selTitleColor:nil disableTitleColor:nil titleFont:titleFont selTitleFont:nil disableTitleFont:nil image:image selImage:nil disableImage:nil backGroundColor:backgroundColor selBackGroundColor:nil disableBackGroundColor:nil backGroundImage:nil selBackGroundImage:nil disableBackGroundImage:nil padding:0.f buttonPositionStyle:QMUIButtonImagePositionLeft target:nil selector:nil];
    
    return button;
}

/**
 QMUIButton：快速创建 button6：frame、title、titleColor、titleFont、image、backgroundImage
 
 @param frame frame description
 @param title title description
 @param titleColor titleColor description
 @param titleFont titleFont description
 @param image image description
 @param backgroundImage backgroundImage description
 @return button
 */
+ (instancetype)gg_buttonWithFrame:(CGRect)frame
                             title:(NSString * __nullable)title
                        titleColor:(UIColor * __nullable)titleColor
                         titleFont:(UIFont * __nullable)titleFont
                             image:(UIImage * __nullable)image
                   backgroundImage:(UIImage * __nullable)backgroundImage {
    QMUIButton *button = [QMUIButton gg_creatButtonWithFrame:frame title:title selTitle:nil disableTitle:nil titleColor:titleColor selTitleColor:nil disableTitleColor:nil titleFont:titleFont selTitleFont:nil disableTitleFont:nil image:image selImage:nil disableImage:nil backGroundColor:nil selBackGroundColor:nil disableBackGroundColor:nil backGroundImage:backgroundImage selBackGroundImage:nil disableBackGroundImage:nil padding:0.f buttonPositionStyle:QMUIButtonImagePositionLeft target:nil selector:nil];
    
    return button;
}


/**
 QMUIButton：快速创建 button7：大汇总-点击事件、圆角
 
 @param frame frame
 @param title title
 @param selTitle selTitle
 @param titleColor titleColor，默认：黑色
 @param titleFont titleFont默认：15
 @param image image description
 @param selImage selImage
 @param padding padding 文字图片间距
 @param buttonLayoutType buttonLayoutType 文字图片布局样式
 @param target target
 @param sel sel
 @return button
 */
+ (instancetype __nonnull)gg_creatButtonWithFrame:(CGRect)frame
                                            title:(NSString * __nullable)title
                                         selTitle:(NSString * __nullable)selTitle
                                     disableTitle:(NSString *__nullable)disableTitle
                                       titleColor:(UIColor * __nullable)titleColor
                                    selTitleColor:(UIColor *__nullable)selTitleColor
                                disableTitleColor:(UIColor *__nullable)disableTitleColor
                                        titleFont:(UIFont * __nullable)titleFont
                                     selTitleFont:(UIFont *__nullable)selTitleFont
                                 disableTitleFont:(UIFont *__nullable)disableTitleFont
                                            image:(UIImage * __nullable)image
                                         selImage:(UIImage * __nullable)selImage
                                     disableImage:(UIImage * __nullable)disableImage
                                  backGroundColor:(UIColor *__nullable)backGroundColor
                               selBackGroundColor:(UIColor *__nullable)selBackGroundColor
                           disableBackGroundColor:(UIColor *__nullable)disableBackGroundColor
                                  backGroundImage:(UIImage *__nullable)backGroundImage
                               selBackGroundImage:(UIImage *__nullable)selBackGroundImage
                           disableBackGroundImage:(UIImage *__nullable)disableBackGroundImage
                                          padding:(CGFloat)padding
                              buttonPositionStyle:(QMUIButtonImagePosition)buttonLayoutType
                                           target:(id __nullable)target
                                         selector:(SEL __nullable)sel {
    QMUIButton *button = [[self class] buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (selTitle) {
        [button setTitle:selTitle forState:UIControlStateSelected];
    }
    
    if (disableTitle) {
        [button setTitle:disableTitle forState:UIControlStateDisabled];
    }
    
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    if (selTitleColor) {
        [button setTitleColor:selTitleColor forState:UIControlStateSelected];
    }
    
    if (disableTitleColor) {
        [button setTitleColor:disableTitleColor forState:UIControlStateDisabled];
    }
    
    if (titleFont) {
        [button gg_buttonSetTitleLabelFont:titleFont forState:UIControlStateNormal];
    }
    
    if (selTitleFont) {
        [button gg_buttonSetTitleLabelFont:selTitleFont forState:UIControlStateSelected];
    }
    
    if (disableTitleFont) {
        [button gg_buttonSetTitleLabelFont:disableTitleFont forState:UIControlStateDisabled];
    }
    
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    if (selImage) {
        [button setImage:selImage forState:UIControlStateSelected];
    }
    
    if (disableImage) {
        [button setImage:disableImage forState:UIControlStateDisabled];
    }
    
    if (backGroundColor) {
        [button gg_buttonSetBackgroundColor:backGroundColor forState:UIControlStateNormal];
    }
    
    if (selBackGroundColor) {
        [button gg_buttonSetBackgroundColor:selBackGroundColor forState:UIControlStateSelected];
    }
    
    if (disableBackGroundColor) {
        [button gg_buttonSetBackgroundColor:disableBackGroundColor forState:UIControlStateDisabled];
    }
    
    if (backGroundImage) {
        [button setBackgroundImage:backGroundImage forState:UIControlStateNormal];
    }
    
    if (selBackGroundImage) {
        [button setBackgroundImage:selBackGroundImage forState:UIControlStateSelected];
    }
    
    if (disableBackGroundColor) {
        [button setBackgroundImage:disableBackGroundImage forState:UIControlStateDisabled];
    }
    
    button.imagePosition = buttonLayoutType;
    
    if (padding) {
        button.spacingBetweenImageAndTitle = padding;
    }
    
    if (target && sel) {
        [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    
    __weak typeof(button) wBtn = button;
    button.qmui_setSelectedBlock = ^(BOOL selected) {
        UIControlState state = selected ? UIControlStateSelected : UIControlStateNormal;
        
        if ([wBtn.titleLabelFonts.allKeys containsObject:@(state)]) {
            wBtn.titleLabel.font = wBtn.titleLabelFonts[@(state)];
        }
        
        if ([wBtn.backgroundColors.allKeys containsObject:@(state)]) {
            [wBtn setBackgroundColor:wBtn.backgroundColors[@(state)]];
        }
    };
    
    button.qmui_setEnabledBlock = ^(BOOL enabled) {
        UIControlState state = enabled ? UIControlStateNormal : UIControlStateDisabled;
        
        if ([wBtn.titleLabelFonts.allKeys containsObject:@(state)]) {
            wBtn.titleLabel.font = wBtn.titleLabelFonts[@(state)];
        }
        
        if ([wBtn.backgroundColors.allKeys containsObject:@(state)]) {
            [wBtn setBackgroundColor:wBtn.backgroundColors[@(state)]];
        }
    };
    
    return button;
}

- (void)gg_buttonSetTitleLabelFont:(UIFont *)titleLabelFont forState:(UIControlState)state {
    if (titleLabelFont) {
        [self.titleLabelFonts setObject:titleLabelFont forKey:@(state)];
    }
    if(self.state == state) {
        self.titleLabel.font = titleLabelFont;
    }
}

- (void)gg_buttonSetBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (backgroundColor) {
        [self.backgroundColors setObject:backgroundColor forKey:@(state)];
    }
    if(self.state == state) {
        self.backgroundColor = backgroundColor;
    }
}

#pragma mark ------------------------- set / get -------------------------
- (void)setTitleLabelFonts:(NSMutableDictionary *)titleLabelFonts {
    objc_setAssociatedObject(self, @selector(titleLabelFonts), titleLabelFonts, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary *)titleLabelFonts {
    NSMutableDictionary *titleLabelFonts = objc_getAssociatedObject(self, _cmd);
    if(!titleLabelFonts) {
        titleLabelFonts = [[NSMutableDictionary alloc] init];
        self.titleLabelFonts = titleLabelFonts;
    }
    return titleLabelFonts;
}

- (void)setBackgroundColors:(NSMutableDictionary *)backgroundColors {
    objc_setAssociatedObject(self, @selector(backgroundColors), backgroundColors, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary *)backgroundColors {
    NSMutableDictionary *backgroundColors = objc_getAssociatedObject(self, _cmd);
    if(!backgroundColors) {
        backgroundColors = [[NSMutableDictionary alloc] init];
        self.backgroundColors = backgroundColors;
    }
    return backgroundColors;
}

@end
