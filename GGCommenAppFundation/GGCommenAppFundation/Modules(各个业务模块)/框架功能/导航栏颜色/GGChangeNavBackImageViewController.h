//
//  GGChangeNavBackImageViewController.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/6.
//

#import "GGBaseViewController.h"

typedef NS_ENUM(NSUInteger, GGChangeNavBackImageViewControllerNavType) {
    GGChangeNavBackImageViewControllerNavType_Light,// 亮色
    GGChangeNavBackImageViewControllerNavType_Dark,// 暗色
    GGChangeNavBackImageViewControllerNavType_Hidden,// 隐藏
};

NS_ASSUME_NONNULL_BEGIN

@interface GGChangeNavBackImageViewController : GGBaseViewController

@property (nonatomic, assign) GGChangeNavBackImageViewControllerNavType navBarType;// 导航栏类型

@end

NS_ASSUME_NONNULL_END
