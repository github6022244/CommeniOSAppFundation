//
//  UIViewController+UIBaseTableView.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/2.
//

#import <UIKit/UIKit.h>
#import <GGBasePageModel.h>
#import <MJRefresh.h>
#import <QMUIKit.h>
#import "UIViewController+UIBase.h"

/// 刷新相关协议
@protocol UIBaseTabelViewControllerRefreshProtocol <NSObject>

@optional
/// 只需要实现 footer 的样式，回调用  - (void)tableViewRefreshWithType:(GGRefreshType)rType;
// 创建一个刷新 header
- (MJRefreshHeader *__nullable)uibase_createARefreshHeader;
// 创建一个刷新 footer
- (MJRefreshFooter *__nullable)uibase_createARefreshFooter;
/// footer 初始化后是否隐藏(默认不隐藏)
/// 在 - (void)tableViewEndFooterRefreshingWithPageModel: 中会将 footer 显示出来(footer.hidden = NO)
- (BOOL)hideRefreshFooterAfterInitialied;

// 刷新、加载回调(常用作网络请求)
- (void)tableViewRefreshWithType:(GGRefreshType)rType;

@end






/// 配置相关协议
@protocol UIBaseTabelViewControllerConfigProtocol <NSObject>

@required
// 是否是一个 tableviewController
- (BOOL)uibase_useTableViewControllerStyle;

@optional
// 配置 tableview 的类型
- (UITableViewStyle)uibase_tableViewStyle;

@end




// 定义一些格式
@protocol UITableViewViewControllerUIBaseSpecificationProtocol <NSObject>

@optional
- (void)uibase_initTableView;
- (void)uibase_configTableView;

@end




NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (UIBaseTableView)
<UIViewControllerUIBaseSpecificationProtocol, QMUITableViewDelegate, QMUITableViewDataSource, UIBaseTabelViewControllerRefreshProtocol, UIBaseTabelViewControllerConfigProtocol, UITableViewViewControllerUIBaseSpecificationProtocol>

@property (nonatomic, strong) QMUITableView *tableView;

// 控制 tableview 停止刷新动作
- (void)tableViewEndRefreshing;
/// ①停止刷新动作
/// ②根据 pageModel 控制 footer 是否展示没有更多数据
- (void)tableViewEndRefreshingWithPageModel:(GGBasePageModel *__nullable)pageModel;

@end

NS_ASSUME_NONNULL_END
