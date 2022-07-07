//
//  GGBaseFunctionsTestViewController.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/27.
//

#import "GGBaseTableViewController.h"
#import <QMUIKit.h>
#import "UILabel+GG.h"
#import <Masonry.h>

@class GGBaseFunctionsItem;

NS_ASSUME_NONNULL_BEGIN

@interface GGBaseFunctionsTestViewController : GGBaseTableViewController

@property (nonatomic, strong, readonly) NSArray<GGBaseFunctionsItem *> *itemsArray;

/// 说明性文字
/// 顶部显示
- (NSString *_Nullable)configAlertFunctionsTitle;

/// 功能标题+响应方法
- (NSArray<GGBaseFunctionsItem *> *)configFunctionsItems;

/// 工具方法
- (NSArray<GGBaseFunctionsItem *> *)buildFunctionsItemsWithKeyValues:(NSArray<NSDictionary *> *)keyValues;

@end





@interface GGBaseFunctionsItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *selectorName;

+ (GGBaseFunctionsItem *)itemWithTitle:(NSString *)title selectorName:(NSString *)selectorName;

@end

NS_ASSUME_NONNULL_END
