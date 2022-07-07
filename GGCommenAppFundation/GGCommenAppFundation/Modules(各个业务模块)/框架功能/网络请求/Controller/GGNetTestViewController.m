//
//  GGNetTestViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/6.
//

#import "GGNetTestViewController.h"
#import <GGNetWork.h>
#import "GGTestRequest.h"
#import <QMUIKit.h>
#import "UILabel+GG.h"
#import <Masonry.h>
#import "GGBaseCXGAlertView.h"
#import "GGAppModulesDefine.h"

@interface GGNetTestViewController ()<YTKChainRequestDelegate>

@property (nonatomic, strong) QMUIGridView *gridView;

@property (nonatomic, strong) GGTestRequest *request;

@property (nonatomic, strong) YTKChainRequest *chainRequest;

@property (nonatomic, strong) YTKBatchRequest *batchRequest;

@end

@implementation GGNetTestViewController

#pragma mark ------------------------- Cycle -------------------------
+ (void)load {
    [MGJRouter gg_registerURLPattern:GGModulesUrl_Net_OpenNetTestController toHandler:^(NSDictionary * _Nullable routerParameters, MGJRouterParam * _Nullable param) {
        GGNetTestViewController *vc = [GGNetTestViewController new];
        
        [param.senderData.preController showControllerInSameWay:vc animated:YES block:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    self.title = @"网络请求";
}

#pragma mark ------------------------- Override -------------------------
- (NSString *)configAlertFunctionsTitle {
    return @"①使用 GGNetWorkManager 做统一配置，在 Appdelegate+GGService.m 的 - (void)setUpNetwork\n\n②GGNetWorkConfigModel 作为配置对象可以在其.m里实现各种配置\n\n③GGBaseRequest 作为所有网络请求的父类，需完善请求成功与失败的处理";
}

- (NSArray<GGBaseFunctionsItem *> *)configFunctionsItems {
    NSArray *array = @[
        @"单个请求",
        @"多个请求串行",
        @"多个请求并行",
    ];
    
    NSMutableArray *marr_data = @[].mutableCopy;
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        NSString *actionName = [NSString stringWithFormat:@"test_Req%ld", (long)i];
        
        GGBaseFunctionsItem *item = [GGBaseFunctionsItem itemWithTitle:obj selectorName:actionName];
        
        [marr_data addObject:item];
    }];
    
    return marr_data;
}

#pragma mark ------------------------- Actions -------------------------
- (void)test_Req0 {
    GGTestRequest *req = [GGTestRequest new];
    
    _request = req;
    
    req.animatingView = self.view;
    
    [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        QMUILog(nil, @"\n请求成功 : %@", request.responseObject);
        
        [QMUITips showSucceed:@"单个请求成功"];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        QMUILog(nil, @"\n请求失败 : %@\n", request.error.localizedDescription);
        
        [QMUITips showError:@"单个请求失败"];
    }];
}

- (void)test_Req1 {
    GGTestRequest *req = [GGTestRequest new];
    req.doNotShowHUD = YES;
    req.tag = 1000;
    
    GGTestRequest *req_1 = [GGTestRequest new];
    req_1.doNotShowHUD = YES;
    req_1.tag = 1001;
    
    GGTestRequest *req_2 = [GGTestRequest new];
    req_2.doNotShowHUD = YES;
    req_2.tag = 1002;
    
    YTKChainRequest *chainReq = [YTKChainRequest new];
    
    [chainReq addRequest:req callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        if (!baseRequest.error) {
            QMUILog(nil, @"请求成功 : req");
        } else {
            QMUILog(nil, @"\n请求失败 : req %@\n", baseRequest.error.localizedDescription);
        }
    }];
    
    [chainReq addRequest:req_1 callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        if (!baseRequest.error) {
            QMUILog(nil, @"请求成功 : req-1");
        } else {
            QMUILog(nil, @"\n请求失败 : req-1 %@\n", baseRequest.error.localizedDescription);
        }
    }];
    
    [chainReq addRequest:req_2 callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        if (!baseRequest.error) {
            QMUILog(nil, @"请求成功 : req-2");
        } else {
            QMUILog(nil, @"\n请求失败 : req-2 %@\n", baseRequest.error.localizedDescription);
        }
    }];
    
    chainReq.animatingText = @"请求中..";
    chainReq.animatingView = self.view;
    
    [chainReq start];
    
    chainReq.delegate = self;
    
    _chainRequest = chainReq;
}

- (void)test_Req2 {
    GGTestRequest *req = [GGTestRequest new];
    req.doNotShowHUD = YES;
    req.tag = 1000;
    
    GGTestRequest *req_1 = [GGTestRequest new];
    req_1.doNotShowHUD = YES;
    req_1.tag = 1001;
    
    GGTestRequest *req_2 = [GGTestRequest new];
    req_2.doNotShowHUD = YES;
    req_2.tag = 1002;
    
    YTKBatchRequest *batchReq = [[YTKBatchRequest alloc] initWithRequestArray:@[
        req,
        req_1,
        req_2,
    ]];
    
    _batchRequest = batchReq;
    
    [batchReq startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        QMUILog(nil, @"请求成功 : req");
        [QMUITips showSucceed:@"并行请求完成"];
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        QMUILog(nil, @"\n请求失败 : BatchRequest - request tag : %ld \n%@\n", (long)batchRequest.failedRequest.tag, batchRequest.failedRequest.error.localizedDescription);
        [QMUITips showError:@"并行请求失败"];
    }];
    
    batchReq.animatingText = @"请求中..";
    batchReq.animatingView = self.view;
    
    [batchReq start];
}

#pragma mark ------------------------- Delegate -------------------------
- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    QMUILog(nil, @"请求完成 : ChainRequest");
    [QMUITips showSucceed:@"串行请求完成"];
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest *)request {
    QMUILog(nil, @"\n请求失败 : ChainRequest - request tag : %ld \n%@\n", (long)request.tag, request.error.localizedDescription);
    [QMUITips showError:@"串行请求失败"];
}

@end
