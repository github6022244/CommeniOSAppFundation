//
//  UIViewController+GGDEBUG.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/24.
//

#import <UIKit/UIKit.h>

@protocol GGUIBaseViewControllerDebugProtocol <NSObject>

@required
/// 是否在 debug 模式下，当显示出页面时打印类名
- (BOOL)debugLogClassName;

@optional
/// 自定义打印页面类名
- (NSString *)customDebugLogClassName;

@end


NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GGDEBUG)

@end

NS_ASSUME_NONNULL_END
