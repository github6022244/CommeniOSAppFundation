//
//  UIBasePagerView.m
//  RKZhiChengYunHuiTong
//
//  Created by GG on 2020/12/14.
//

#import "UIBasePagerView.h"
#import <QMUIKit/QMUICommonDefines.h>

@interface UIBasePagerView ()<UIScrollViewDelegate>

@end

@implementation UIBasePagerView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isListHorizontalScrollEnabled) {
        self.listContainerView.scrollView.scrollEnabled = YES;
    }
    if (self.mainTableView.contentInset.top != 0 && self.pinSectionHeaderVerticalOffset != 0) {
        [self performSelector:@selector(adjustMainScrollViewToTargetContentInsetIfNeeded:) withObject:@(UIEdgeInsetsZero)];
    }

    if ([_basePagerDelegate respondsToSelector:@selector(basePagerView_scrollViewDidEndDecelerating:)]) {
        [_basePagerDelegate performSelector:@selector(basePagerView_scrollViewDidEndDecelerating:) withObject:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.isListHorizontalScrollEnabled && !decelerate) {
        self.listContainerView.scrollView.scrollEnabled = YES;
    }
    
    if (!decelerate) {
        if ([_basePagerDelegate respondsToSelector:@selector(basePagerView_scrollViewDidEndDecelerating:)]) {
            [_basePagerDelegate performSelector:@selector(basePagerView_scrollViewDidEndDecelerating:) withObject:scrollView];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.isListHorizontalScrollEnabled) {
        self.listContainerView.scrollView.scrollEnabled = YES;
    }
    
    if ([_basePagerDelegate respondsToSelector:@selector(basePagerView_scrollViewDidEndDecelerating:)]) {
        [_basePagerDelegate performSelector:@selector(basePagerView_scrollViewDidEndDecelerating:) withObject:scrollView];
    }
}

@end
