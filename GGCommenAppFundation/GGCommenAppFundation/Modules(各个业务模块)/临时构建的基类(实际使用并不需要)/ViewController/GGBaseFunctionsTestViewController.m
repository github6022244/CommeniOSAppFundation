//
//  GGBaseFunctionsTestViewController.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/27.
//

#import "GGBaseFunctionsTestViewController.h"
#import <MJExtension.h>
#import "NSDictionary+GG.h"
#import "GGBaseTableViewCell.h"

@interface GGBaseFunctionsTestViewController ()

@property (nonatomic, strong) UIView *alertFunctionsTitleHeaderView;

@property (nonatomic, strong) QMUIGridView *gridView;

@property (nonatomic, copy) NSString *alertFunctionsTitle;

@property (nonatomic, strong) NSArray<GGBaseFunctionsItem *> *itemsArray;

@end

@implementation GGBaseFunctionsTestViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------- Config -------------------------
- (void)uibase_config {
    [super uibase_config];
    
    _alertFunctionsTitle = [self configAlertFunctionsTitle];
    
    _itemsArray = [self configFunctionsItems];
}

#pragma mark ------------------------- UI -------------------------
- (void)uibase_initTableView {
    [super uibase_initTableView];
    
    [self.tableView registerClass:[GGBaseTableViewCell class] forCellReuseIdentifier:@"GGBaseTableViewCell"];
}

#pragma mark ------------------------- Delegate / Protocol -------------------------
#pragma mark --- TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _itemsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GGBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GGBaseTableViewCell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor qmui_randomColor];
    
    GGBaseFunctionsItem *item = _itemsArray[indexPath.section];
    
    cell.textLabel.text = item.title;
    cell.textLabel.textColor = UIColorForBackground;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 && _alertFunctionsTitle) {
        return self.alertFunctionsTitleHeaderView.qmui_height;
    }
    
    return 6.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 && _alertFunctionsTitle) {
        return self.alertFunctionsTitleHeaderView;
    }
    
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GGBaseFunctionsItem *item = _itemsArray[indexPath.section];
    
    NSString *actionName = item.selectorName;
    
    BeginIgnorePerformSelectorLeaksWarning
    if ([self respondsToSelector:NSSelectorFromString(actionName)]) {
        [self performSelector:NSSelectorFromString(actionName)];
    }
    EndIgnorePerformSelectorLeaksWarning
}

#pragma mark ------------------------- Interface -------------------------
/// 说明性文字
/// 顶部显示
- (NSString *_Nullable)configAlertFunctionsTitle {
    return nil;
}

/// 功能标题+响应方法
- (NSArray<GGBaseFunctionsItem *> *)configFunctionsItems {
    return nil;
}

/// 工具方法
- (NSArray<GGBaseFunctionsItem *> *)buildFunctionsItemsWithKeyValues:(NSArray<NSDictionary *> *)keyValues {
    NSMutableArray *marr_data = @[].mutableCopy;
    
    [keyValues enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = [obj gg_safeObjectForKey:@"title"];
        NSString *sel = [obj gg_safeObjectForKey:@"sel"];
        
        GGBaseFunctionsItem *item = [GGBaseFunctionsItem itemWithTitle:title selectorName:sel];
        
        [marr_data addObject:item];
    }];
    
    return marr_data;
}

#pragma mark ------------------------- set / get -------------------------
- (UIView *)alertFunctionsTitleHeaderView {
    if (!_alertFunctionsTitleHeaderView) {
        UIView *view = [[UIView alloc] qmui_initWithSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)];
        
        if (_alertFunctionsTitle) {
            QMUILabel *label = [QMUILabel labelWithSuperView:view withContent:_alertFunctionsTitle withBackgroundColor:nil withTextColor:[UIColor orangeColor] withFont:UIFontMake(15)];
            label.numberOfLines = 0;
            label.qmui_width = view.qmui_width - 15.f * 2;
            
            [label sizeToFit];
            
            CGFloat needHeight = label.qmui_height + 15.f * 2;
            view.qmui_size = CGSizeMake(SCREEN_WIDTH, needHeight);
            
            label.center = view.center;
        }
        
        _alertFunctionsTitleHeaderView = view;
    }
    
    return _alertFunctionsTitleHeaderView;
}

@end














@implementation GGBaseFunctionsItem

MJLogAllIvars

+ (GGBaseFunctionsItem *)itemWithTitle:(NSString *)title selectorName:(NSString *)selectorName {
    GGBaseFunctionsItem *item = [GGBaseFunctionsItem new];
    
    item.title = title;
    item.selectorName = selectorName;
    
    return item;
}

@end
