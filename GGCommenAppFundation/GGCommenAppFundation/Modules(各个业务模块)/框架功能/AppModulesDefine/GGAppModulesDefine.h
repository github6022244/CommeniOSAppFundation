//
//  GGAppModulesDefine.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/24.
//

#import <Foundation/Foundation.h>
#import "MGJRouter+GG.h"

#pragma mark --- DEBUG
extern NSString *const GGModulesUrl_DEBUG_OpenDEUBGController;// 跳转DEBUG控制器

#pragma mark --- 缓存处理
extern NSString *const GGModulesUrl_Caches_OpenCachesController;// 跳转缓存处理控制器

#pragma mark --- 网络请求
extern NSString *const GGModulesUrl_Net_OpenNetTestController;// 跳转网络控制器

#pragma mark --- 图片选择
extern NSString *const GGModulesUrl_Photo_OpenPhotoController;// 跳转照片控制器d

#pragma mark --- 权限
extern NSString *const GGModulesUrl_Permission_OpenPermissionController;// 跳转权限控制器

#pragma mark --- 导航栏颜色
extern NSString *const GGModulesUrl_NavChangeColor_OpenNavChangeColorController;// 跳转导航栏颜色改变控制器

#pragma mark --- 基类
extern NSString *const GGModulesUrl_BaseClass_OpenInfoViewController;// 跳转基类介绍控制器

extern NSString *const GGModulesUrl_BaseViewController_OpenBaseViewController;// 跳转基类控制器

extern NSString *const GGModulesUrl_BaseTableViewController_OpenBaseTableViewController;// 跳转列表基类控制器

extern NSString *const GGModulesUrl_BaseFunctionsViewController_Open;// 跳转分类栏基类控制器
extern NSString *const GGModulesUrl_BaseFunctionsViewController_Get;// 获取分类栏基类控制器

#pragma mark --- MGJRouter
extern NSString *const GGModulesUrl_Router_OpenMGJRouterController;// 跳转router页面

extern NSString *const GGModulesUrl_Router_OpenHandleEvent;// 处理逻辑

extern NSString *const GGModulesUrl_Router_GetObject;// 获取object

extern NSString *const GGModulesUrl_Router_CustomeParam;// 自定义参数

extern NSString *const GGModulesUrl_Router_HandleReturnBlock;// 处理返回值block
