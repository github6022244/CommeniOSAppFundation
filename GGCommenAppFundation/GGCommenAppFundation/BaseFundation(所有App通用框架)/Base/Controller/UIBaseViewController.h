//
//  UIBaseViewController.h
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/2.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import <QMUIKit.h>
#import "UIViewController+UIBase.h"
#import "UIViewController+GGDEBUG.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIBaseViewController : QMUICommonViewController<GGUIBaseViewControllerDebugProtocol>

@end

NS_ASSUME_NONNULL_END
