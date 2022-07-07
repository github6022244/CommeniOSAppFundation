//
//  GGNetWorkManagerLoadingProtocol.h
//  GGNetWorkManager
//
//  Created by GG on 2022/5/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



// 菊花效果协议
@protocol GGNetWorkManagerLoadingProtocol <NSObject>

/// 请求中的菊花效果
/// @param text 例如：加载中。。。
/// @param view 展示的view
- (void)gg_configShowLoadingText:(NSString *_Nullable)text inView:(UIView *_Nonnull)view;

- (void)gg_configHideLoading;

@end
