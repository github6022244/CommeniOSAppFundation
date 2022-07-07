//
//  QMUIButton+GG.h
//  RKZhiChengYunHuiTong
//
//  Created by GG on 2020/11/20.
//

#import "QMUIButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface QMUIButton (GG)

#pragma mark - 快速创建 button

/**
 UIButton：快速创建 button1：frame、title、titleColor、titleFont
 
 @param frame frame
 @param title title
 @param titleColor titleColor
 @param titleFont titleFont
 @return button
 */
+ (id)gg_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
              titleColor:(UIColor * __nullable)titleColor
               titleFont:(UIFont * __nullable)titleFont;

/**
 UIButton：快速创建 button2：frame、title、backgroundColor
 
 @param frame frame
 @param title title
 @param backgroundColor backgroundColor
 @return button
 */
+ (id)gg_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
         backgroundColor:(UIColor * __nullable)backgroundColor;

/**
 UIButton：快速创建 button3：frame、title、titleColor、titleFont、backgroundColor
 
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
         backgroundColor:(UIColor * __nullable)backgroundColor;

/**
 UIButton：快速创建 button4：frame、title、backgroundImage
 
 @param frame frame
 @param title title
 @param backgroundImage backgroundImage
 @return button
 */
+ (id)gg_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
         backgroundImage:(UIImage * __nullable)backgroundImage;

/**
 UIButton：快速创建 button5：frame、title、titleColor、titleFont、image、backgroundColor
 
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
                   backgroundColor:(UIColor * __nullable)backgroundColor;

/**
 UIButton：快速创建 button6：frame、title、titleColor、titleFont、image、backgroundImage
 
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
                   backgroundImage:(UIImage * __nullable)backgroundImage;


/**
 UIButton：快速创建 button7：大汇总-点击事件、圆角
 
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
                                  backGroundImage:(UIColor *__nullable)backGroundImage
                               selBackGroundImage:(UIColor *__nullable)selBackGroundImage
                           disableBackGroundImage:(UIColor *__nullable)disableBackGroundImage
                                          padding:(CGFloat)padding
                              buttonPositionStyle:(QMUIButtonImagePosition)buttonLayoutType
                                           target:(id __nullable)target
                                         selector:(SEL __nullable)sel;

@end

NS_ASSUME_NONNULL_END
