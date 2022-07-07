//
//  AppWelcomeController.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/30.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "AppWelcomeController.h"
#import "PageControlView.h"
#import <Masonry.h>
#import "GGCommenDefine.h"

@interface AppWelcomeController ()

@property(strong , nonatomic)PageControlView *pageControlV;

@property(strong , nonatomic)NSArray *imageArr;

@end

@implementation AppWelcomeController

#pragma mark ------------------------- Cycle -------------------------
- (instancetype)initWithEnterBlock:(void(^)(void))enterBlock {
    if (self = [super init]) {
        _enterBlock = enterBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark ------------------------- UI -------------------------
- (void)setUpUI {
    [self.view addSubview:self.pageControlV];
    
    _pageControlV.pageV.hidden = YES;
    
    [_pageControlV.btn setBackgroundImage:[UIImage imageNamed:@"placeholder_lostnet"] forState:UIControlStateNormal];
    CGFloat width = 200.0 * kScaleFit;
    CGFloat height = 68.0 * kScaleFit;
    CGFloat bottom = 30.f + SafeAreaInsetsConstantForDeviceWithNotch.bottom;
    [_pageControlV.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(- bottom);
        make.centerX.equalTo(_pageControlV);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    __weak typeof(self) ws = self;
    _pageControlV.enterBlock = ^{
        if (ws.enterBlock) {
            ws.enterBlock();
        }
    };
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- 无网络视图
- (BOOL)autoShowNetStatusChangeAlertView {
    return NO;
}

#pragma mark ------------------------- set / get -------------------------
- (NSArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSArray arrayWithObjects:@"placeholder_lostnet", @"placeholder_lostnet", @"placeholder_lostnet", @"placeholder_lostnet", nil];
    }
    return _imageArr;
}

- (PageControlView *)pageControlV
{
    if (!_pageControlV) {
        _pageControlV = [[PageControlView instance] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andImageList:self.imageArr];
    }
    return _pageControlV;
}

@end
