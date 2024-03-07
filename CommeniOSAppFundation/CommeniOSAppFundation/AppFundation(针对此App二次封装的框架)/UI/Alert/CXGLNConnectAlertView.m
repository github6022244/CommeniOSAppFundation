//
//  CXGLNConnectAlertView.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/1/31.
//

#import "CXGLNConnectAlertView.h"

@implementation CXGLNConnectAlertView

+ (void)showAlert {
    [GGBaseCXGAlertView alertViewWithSubTitleOnlyTitle:@"联系客服" subTitle:@"联系电话：4001018878\n工作时间：9:00 - 17:30" leftCancelButtonTitle:@"取消" rightDownButtonTitle:@"电话联系" inView:nil block:^(NSInteger tag, NSString *textFieldText, GGBaseAlertView *alertView) {
        if (tag == 1) {
            [alertView dismissView];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://4001018878"]]];
        }
    }];
}

@end
