//
//  GGAppModulesDefine.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/24.
//

#import "GGAppModulesDefine.h"

#pragma mark --- DEBUG
NSString *const GGModulesUrl_DEBUG_OpenDEUBGController = @"gg://debug/open/debugcontroller";// 跳转DEBUG控制器

#pragma mark --- 缓存处理
NSString *const GGModulesUrl_Caches_OpenCachesController = @"gg://caches/open/cachescontroller";// 跳转缓存处理控制器

#pragma mark --- 网络请求
NSString *const GGModulesUrl_Net_OpenNetTestController = @"gg://net/open/nettestcontroller";// 跳转网络控制器

#pragma mark --- 图片选择
NSString *const GGModulesUrl_Photo_OpenPhotoController = @"gg://phtoto/open/openphotocontroller";// 跳转照片控制器

#pragma mark --- 图片选择
NSString *const GGModulesUrl_Permission_OpenPermissionController = @"gg://permission/open/openpermissioncontroller";// 跳转权限控制器

#pragma mark --- 导航栏颜色
NSString *const GGModulesUrl_NavChangeColor_OpenNavChangeColorController = @"gg://navchangecolor/open/opennavchangecolorcontroller";// 跳转导航栏颜色改变控制器

#pragma mark --- 基类
NSString *const GGModulesUrl_BaseClass_OpenInfoViewController = @"gg://baseclass/open/info";// 跳转基类介绍控制器

NSString *const GGModulesUrl_BaseViewController_OpenBaseViewController = @"gg://baseviewcontroller/open/openbaseviewcontroller";// 跳转基类控制器

NSString *const GGModulesUrl_BaseTableViewController_OpenBaseTableViewController = @"gg://basetableviewcontroller/open/openbasetableviewcontroller";// 跳转列表基类控制器

NSString *const GGModulesUrl_BaseFunctionsViewController_Open = @"gg://router/open/basefunctionsviewcontroller";// 跳转分类栏基类控制器
NSString *const GGModulesUrl_BaseFunctionsViewController_Get = @"gg://router/get/basefunctionsviewcontroller";// 获取分类栏基类控制器

#pragma mark --- MGJRouter
NSString *const GGModulesUrl_Router_OpenMGJRouterController = @"gg://router/open/routercontroller";// 跳转router页面

NSString *const GGModulesUrl_Router_OpenHandleEvent = @"gg://router/handle/event";// 处理逻辑

NSString *const GGModulesUrl_Router_GetObject = @"gg://router/get/object";// 获取object

NSString *const GGModulesUrl_Router_CustomeParam = @"gg://router/handle/customeparam";// 自定义参数

NSString *const GGModulesUrl_Router_HandleReturnBlock = @"gg://router/handle/returnblock";// 处理返回值block
