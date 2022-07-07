//
//  UIBaseFuncSliderControllerRefreshProtocol.h
//  GGFuncSliderViewController
//
//  Created by GG on 2022/5/27.
///  主控制器需要实现的功能，在继承于 UIBaseFuncSliderController 的子类中实现
///  单独抽出来的原因是：这几个功能要在主控器实现，但是在子控制器调用

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 子控制器控制主控制器刷新控件 开始/停止刷新 方法， 在子控制器调用
@protocol UIBaseFuncSliderControllerRefreshProtocol <NSObject>

@required
- (void)mainControllerBeginRefresh;
- (void)mainControllerEndRefresh;
- (BOOL)mainControllerIsRefreshing;

@end
