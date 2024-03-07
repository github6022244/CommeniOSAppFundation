//
//  GGFloatLayoutView.m
//  ChangXiangGrain
//
//  Created by GG on 2023/3/6.
//  Copyright © 2023 ChangXiangCloud. All rights reserved.
//

#import "GGFloatLayoutView.h"

@protocol GGFloatLayoutViewSuperProtocol <NSObject>

- (CGSize)layoutSubviewsWithSize:(CGSize)size shouldLayout:(BOOL)shouldLayout;

@end

@implementation GGFloatLayoutView

+ (void)load {
    ExchangeImplementations([super class], @selector(layoutSubviewsWithSize:shouldLayout:), @selector(gg_layoutSubviewsWithSize:shouldLayout:));
}

- (CGSize)gg_layoutSubviewsWithSize:(CGSize)size shouldLayout:(BOOL)shouldLayout {
    CGSize size_reslut = [self gg_layoutSubviewsWithSize:size shouldLayout:shouldLayout];
    
    QMUILog(nil, @"\nreslut = %@", NSStringFromCGSize(size_reslut));
    
    if (shouldLayout) {
        if (_layoutSubViewsFrameBlock) {
            _layoutSubViewsFrameBlock(size_reslut);
        }
    }
    
    return size_reslut;
}

@end
