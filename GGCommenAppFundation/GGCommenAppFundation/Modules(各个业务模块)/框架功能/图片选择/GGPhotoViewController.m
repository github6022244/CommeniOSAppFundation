//
//  GGPhotoViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/6.
//

#import "GGPhotoViewController.h"
#import "MRPhotoPickerManager.h"
#import "QMUIButton+GG.h"
#import "GGCommenDefine.h"
#import "MGJRouter+GG.h"
#import "GGAppModulesDefine.h"

@interface GGPhotoViewController ()

@property (nonatomic, strong) QMUIGridView *gridView;

@end

@implementation GGPhotoViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_Photo_OpenPhotoController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        UIViewController *preVC = param.senderData.preController;
        
        GGPhotoViewController *vc = [GGPhotoViewController new];
        
        [preVC showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    self.title = @"图片选择";
}

#pragma mark ------------------------- Override -------------------------
- (NSArray<GGBaseFunctionsItem *> *)configFunctionsItems {
    NSArray *array = @[
        @"普通",
        @"带裁剪框",
    ];
    
    NSMutableArray *marr_data = @[].mutableCopy;
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        NSString *selStr = NSStringFormat(@"actions_showPicker%ld", (long)i);
        
        GGBaseFunctionsItem *item = [GGBaseFunctionsItem itemWithTitle:obj selectorName:selStr];
        
        [marr_data addObject:item];
    }];
    
    return marr_data;
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 展示图片选择器
- (void)actions_showPicker0 {
    MRPhotoPickerManager *manager = [MRPhotoPickerManager share];
    [manager configController:self];
    
    [manager showWithPickerType:MRPhotoPickerManagerShowType_Other finishBlock:^(id  _Nonnull data, NSString * _Nonnull dataName) {
        QMUILog(@"展示图片 picker", @"调试");
    }];
}

#pragma mark --- 展示图片选择器(带裁剪框)
- (void)actions_showPicker1 {
    MRPhotoPickerManager *manager = [MRPhotoPickerManager share];
    [manager configController:self];
    
    [manager showWithPickerType:MRPhotoPickerManagerShowType_Clip finishBlock:^(id  _Nonnull data, NSString * _Nonnull dataName) {
        QMUILog(@"展示图片 picker", @"调试");
    }];
}

@end
