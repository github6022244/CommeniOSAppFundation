//
//  UIBasePagerView.h
//  RKZhiChengYunHuiTong
//
//  Created by GG on 2020/12/14.
//

#import <JXPagingView/JXPagerView.h>

@protocol UIBasePagerViewDelegate <NSObject>

- (void)basePagerView_scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface UIBasePagerView : JXPagerView

@property (nonatomic, weak) id<UIBasePagerViewDelegate> basePagerDelegate;

@end

NS_ASSUME_NONNULL_END
