//
//  GGFloatLayoutView.h
//  ChangXiangGrain
//
//  Created by GG on 2023/3/6.
//  Copyright © 2023 ChangXiangCloud. All rights reserved.
//

#import "QMUIFloatLayoutView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GGFloatLayoutView : QMUIFloatLayoutView

/// 这个block会在布局子控件后返回整体view 的 size
@property (nonatomic, copy) void(^layoutSubViewsFrameBlock)(CGSize viewSize);

@end

NS_ASSUME_NONNULL_END
