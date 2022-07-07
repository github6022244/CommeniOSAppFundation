//
//  GGAddCachesViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/8.
//

#import "GGAddCachesViewController.h"
#import "GGCachesRequest.h"
#import "UIImageView+GGWeb.h"
#import <Masonry.h>
#import <SDWebImage.h>
#import <MJExtension.h>

@interface GGAddCachesViewController ()

@property (nonatomic, strong) QMUIGridView *gridView;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *cachesImageView;

@property (nonatomic, strong) GGCachesRequest *cachesRequest;

@end

@implementation GGAddCachesViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_setUpNavigationItems {
    [super uibase_setUpNavigationItems];
    
    self.title = @"添加缓存";
}

- (void)uibase_setUpSubViews {
    [super uibase_setUpSubViews];
    
    _headerView = [[UIView alloc] qmui_initWithSize:CGSizeMake(SCREEN_WIDTH, 150.f)];
    
    _cachesImageView = [UIImageView new];
    [_headerView addSubview:_cachesImageView];
    [_cachesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15.f, 15.f, 15.f, 15.f));
    }];
    _cachesImageView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark ------------------------- Override -------------------------
- (NSArray<GGBaseFunctionsItem *> *)configFunctionsItems {
    NSArray *array = @[
        @"添加网络请求缓存",
        @"添加图片缓存",
    ];
    
    NSMutableArray *marr_data = @[].mutableCopy;
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        NSString *actionName = [NSString stringWithFormat:@"test_action%ld", (long)i];
        
        GGBaseFunctionsItem *item = [GGBaseFunctionsItem itemWithTitle:obj selectorName:actionName];
        
        [marr_data addObject:item];
    }];
    
    return marr_data;
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- TableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 150.f;
    }
    
    return [super tableView:tableView heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerView;
    }
    
    return [super tableView:tableView viewForHeaderInSection:section];
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 添加网络请求缓存
- (void)test_action0 {
    GGCachesRequest *request = self.cachesRequest;
    
    request.ignoreCache = NO;
    
    NSError *error = [NSError new];
    BOOL loadCaches = [request loadCacheWithError:&error];
    if (loadCaches) {
        [QMUITips showInfo:@"有缓存信息"];
        
        QMUILog(nil, @"缓存信息: \n%@", request.responseJSONObject);
        
        return;
    } else {
        QMUILog(nil, @"%@", error.localizedDescription);
    }
    
    request.successCompletionBlock = ^(__kindof YTKRequest * _Nonnull request) {
        [QMUITips showSucceed:@"请求成功\n已缓存"];
    };
    
    request.failureCompletionBlock = ^(__kindof YTKRequest * _Nonnull request) {
        [QMUITips showError:@"请求失败"];
    };
    
    [request start];
}

#pragma mark --- 添加图片缓存
- (void)test_action1 {
    [_cachesImageView gg_setImageWithURL:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.360zimeiti.com%2Fuploads%2Fallimg%2F150609%2F-1-150609210411349.jpg&refer=http%3A%2F%2Fwww.360zimeiti.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1657270920&t=e9332f4b804c6b79b7d8c99d7c304d88" placeholderImage:nil cornerRadius:18.f];
}

#pragma mark ------------------------- set / get -------------------------
- (GGCachesRequest *)cachesRequest {
    if (!_cachesRequest) {
        _cachesRequest = [GGCachesRequest new];
    }
    
    return _cachesRequest;
}

@end
