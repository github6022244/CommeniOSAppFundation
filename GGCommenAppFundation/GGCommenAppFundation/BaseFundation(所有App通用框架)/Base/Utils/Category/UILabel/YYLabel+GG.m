//
//  YYLabel+GG.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/7.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "YYLabel+GG.h"

@implementation YYLabel (GG)

- (void)addTailWithText:(NSString *)oriText addPoint:(BOOL)addPoint color:(UIColor *)color font:(UIFont *)font clickBlock:(YYTextAction)clickBlock {
    __weak __typeof(self) weakSelf = self;
    
    NSString *showText = addPoint ? [NSString stringWithFormat:@"...%@", oriText] : oriText;

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:showText];

    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];

    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) { // 点击全文回调 YYLabel *label = weakSelf.label;
        if (clickBlock) {
            clickBlock(containerView, text, range, rect);
        }
    };

    [text setColor:color range:[text.string rangeOfString:showText]];
    [text setTextHighlight:hi range:[text.string rangeOfString:showText]];
    text.font = font;

    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];

    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.font alignment:YYTextVerticalAlignmentCenter];

    self.truncationToken = truncationToken;
}

/**
 *  获取lb的size
 */
+ (CGSize)getMessageSizeWithMess:(NSString *)mess lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font
{
    YYLabel *label = [YYLabel new];
    label.font = font;
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = width;
    
    NSMutableAttributedString *introText = [[NSMutableAttributedString alloc] initWithString:mess];
    introText.font = font;
    introText.lineSpacing = lineSpacing;
//    self.attributedText = introText;
    CGSize introSize = CGSizeMake(width, height);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:introText];
    label.textLayout = layout;
    return layout.textBoundingSize;
}

@end
