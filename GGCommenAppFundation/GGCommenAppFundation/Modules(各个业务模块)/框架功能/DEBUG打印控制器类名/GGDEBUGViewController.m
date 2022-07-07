//
//  GGDEBUGViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/24.
//

#import "GGDEBUGViewController.h"
#import <QMUIKit.h>
#import "UILabel+GG.h"
#import <Masonry.h>
#import "UIViewController+GG.h"
#import "GGAppModulesDefine.h"
#import "MGJRouter+GG.h"
#import "QMUIDropdownNotification+GG.h"

@interface GGDEBUGViewController ()

@property (nonatomic, assign, getter=isDebugLogClassName) BOOL debugLogClassName;// 是否允许debug模式打印类名

@end

static NSUInteger kDEBUGVCIndex = 0;

@implementation GGDEBUGViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_DEBUG_OpenDEUBGController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        GGDEBUGViewController *vc = [GGDEBUGViewController new];
        
        if (param.senderData.data) {
            NSNumber *debugLogClassName = param.senderData.data[@"debugLogClassName"];
            vc.debugLogClassName = debugLogClassName.boolValue;
        }
        
        [param.senderData.preController showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    self.title = self.isDebugLogClassName ? @"打印" : @"不打印";
}

- (void)uibase_setUpSubViews {
    [super uibase_setUpSubViews];
    
    [self showEmptyViewWithText:@"是否允许debug模式打印正在显示的控制器类名:\n①#import \"UIViewController+GGDEBUG.h\"\n②遵循协议<GGUIBaseViewControllerDebugProtocol>\n③按需实现 - (BOOL)debugLogClassName\n④继承自 UIBaseTabelViewController 、UIBaseTabelViewController 的控制器已经自动打印" detailText:@"跳转新控制器，查看打印情况" buttonTitle:@"跳转" buttonAction:@selector(actions_jumpNewVC)];
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- DEBUG
/// 是否在 debug 模式下，当显示出页面时打印类名
- (BOOL)debugLogClassName {
    if (!self.isDebugLogClassName) {
        [QMUIDropdownNotification showNotificationWithTitle:@"不打印控制器类名" content:@"因为 - (BOOL)debugLogClassName {} 返回NO"];
    } else {
        [QMUIDropdownNotification showNotificationWithTitle:[NSString stringWithFormat:@"当前控制器类名:%@", NSStringFromClass([self class])] content:@"可以看控制台打印"];
    }
    
    return self.isDebugLogClassName;
}

- (NSString *)customDebugLogClassName {
    return [NSString stringWithFormat:@"%@ - %ld", NSStringFromClass([self class]), (long)kDEBUGVCIndex];
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 跳转新控制器
- (void)actions_jumpNewVC {
    kDEBUGVCIndex++;
    
    GGDEBUGViewController *vc = [GGDEBUGViewController new];

    vc.debugLogClassName = !self.isDebugLogClassName;

    [self showControllerInSameWay:vc animated:YES block:nil];
}

@end
