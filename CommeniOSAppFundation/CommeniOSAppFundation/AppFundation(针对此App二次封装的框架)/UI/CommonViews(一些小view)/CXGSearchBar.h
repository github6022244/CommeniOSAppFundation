//
//  CXGSearchBar.h
//  ChangXiangGrain
//
//  Created by GG on 2022/11/4.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXGSearchBar : UIView

@property (nonatomic, strong) QMUITextField *searchTF;

/// 可控制搜索框的上下左右间距
@property (nonatomic, assign) UIEdgeInsets searchTFEdgeInsets;

@property (nonatomic, strong) QMUIButton *rightButton;

@end

NS_ASSUME_NONNULL_END
