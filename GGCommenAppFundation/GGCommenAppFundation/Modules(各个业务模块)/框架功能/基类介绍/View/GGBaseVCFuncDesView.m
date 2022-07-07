//
//  GGBaseVCFuncDesView.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/7.
//

#import "GGBaseVCFuncDesView.h"
#import "QDThemeManager.h"
#import <QMUIKit.h>
#import "UILabel+GG.h"

@implementation GGBaseVCFuncDesView

#pragma mark ------------------------- Cycle -------------------------
+ (instancetype)view {
    GGBaseVCFuncDesView *view = [GGBaseVCFuncDesView new];
    
    [view setUpUI];
    
    return view;
}

#pragma mark ------------------------- UI -------------------------
- (void)setUpUI {
    NSString *fun0 = @"1.默认自动显示、隐藏网络状态改变提示\n通过- (BOOL)autoShowNetStatusChangeAlertView;控制\n可以断网看看效果";
    
    NSString *fun1 = @"2.强制使用返回手势\n通过- (BOOL)forceEnableInteractivePopGestureRecognizer;控制";
    
    NSString *fun2 = @"3.统一比较通用的功能方法\n在 UIViewControllerUIBaseSpecificationProtocol 协议里";
    
    NSString *fun3 = @"4.默认不管是 present 还是 push, 都会添加一个返回按钮\n图片通过 QDThemeManager 的 qd_navigationBarBackIndicatorImage 控制";
    
    NSString *fun4 = @"5.修改颜色、字体等UI配置在 QMUIConfigurationTemplate.m 里\n一般必须更改的在 #pragma mark - <QDThemeProtocol>\n有些属性在 QDThemeManager.m 里配置\n所有相关UI宏都要使用QMUI提供的, 方便统一UI管理";
    
    NSString *fun5 = @"5.1 如果想添加UI配置项, 方法:\n①在 QDThemeProtocol 里添加方法\n②在相关 QMUIConfigurationTemplate 的 #pragma mark - <QDThemeProtocol> 返回所需内容\n③在 QDThemeManager.h UIColor或者UIImage分类添加属性\n在 QDThemeManager.m 给 QDThemeManager 添加延展属性, init 中获取相关主题初始化这个属性\n在 QDThemeManager.m 的UIColor或UIImage方法返回这个值";
    
    NSArray *funStrArray = @[
        fun0,
        fun1,
        fun2,
        fun3,
        fun4,
        fun5,
    ];
    
    __block NSMutableString *funcMStr = @"".mutableCopy;
    [funStrArray enumerateObjectsUsingBlock:^(NSString  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (*stop) {
            [funcMStr appendFormat:@"%@", obj];
        } else {
            [funcMStr appendFormat:@"%@\n\n", obj];
        }
    }];
    
    QMUILabel *label = [QMUILabel labelWithSuperView:self withContent:funcMStr withBackgroundColor:nil withTextColor:UIColor.qd_mainTextColor withFont:UIFontMake(14)];
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)];
    label.qmui_size = size;
    
    self.frame = CGRectSetHeight([UIScreen mainScreen].bounds, label.qmui_height + 20.f);
    
    label.center = self.center;
}

@end
