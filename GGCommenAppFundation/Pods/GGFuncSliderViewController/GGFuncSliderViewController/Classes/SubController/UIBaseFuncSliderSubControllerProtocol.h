//
//  UIBaseFuncSliderSubControllerProtocol.h
//  GGFuncSliderViewController
//
//  Created by GG on 2022/5/27.
//  子控制器需要实现的功能

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol UIBaseFuncSliderSubControllerProtocol <NSObject>

@optional
/// 主控制器下拉刷新的回调
/// 可以处理些网络请求
- (void)UIBaseFuncSliderControllerHeaderRefresh;

@end





/// 子类 可实现以下方法进行 配置
@protocol UIBaseFuncSliderSubControllerConfigProtocol <NSObject>

@optional
// 配置 tableview
- (void)initTableView;// tableView 初始化后调用
- (void)configTableView;// tableView 默认配置完成后最后调用

// 配置 tableview frame
- (CGRect)layoutConfigTableViewFrame;

@end
