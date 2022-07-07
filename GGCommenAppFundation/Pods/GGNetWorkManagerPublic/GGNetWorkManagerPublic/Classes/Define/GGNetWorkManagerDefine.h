//
//  GGNetWorkManagerDefine.h
//  GGNetWorkManager
//
//  Created by GG on 2022/5/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma mark ------------------------- ENUM -------------------------
// 指定的接口环境
typedef NS_ENUM(NSUInteger, GGNetManagerServerType) {
    GGNetManagerServerType_Public,      // 上架
    GGNetManagerServerType_Develop,     // 开发
    GGNetManagerServerType_Test,        // 测试
};

// 接口类型
typedef NS_ENUM(NSUInteger, GGNetManagerURLType) {
    GGNetManagerURLType_Server,     // 普通接口
    GGNetManagerURLType_H5,         // H5 接口
    GGNetManagerURLType_CDN,        // CDN 接口
};







#pragma mark ------------------------- Functions -------------------------
/// 交换同一个 class 里的 originSelector 和 newSelector 的实现，如果原本不存在 originSelector，则相当于给 class 新增一个叫做 originSelector 的方法
CG_INLINE void
GGNetWorkExchangeImplementations(Class _class, SEL org_Selector, SEL new_Selector) {
    if (!_class || !org_Selector || !new_Selector) {
        return;
    }
    
    Method org_method = class_getInstanceMethod(_class, org_Selector);
    Method dt_method  = class_getInstanceMethod(_class, new_Selector);
    
    BOOL isAdd = class_addMethod(_class, org_Selector, method_getImplementation(dt_method), method_getTypeEncoding(dt_method));
    if (isAdd) {
        class_replaceMethod(_class, new_Selector, method_getImplementation(org_method), method_getTypeEncoding(org_method));
    }else{
        method_exchangeImplementations(org_method, dt_method);
    }
}









#pragma mark ------------------------- Defines -------------------------
/// GGNetWorkLog
/// 依赖 GGNetWorkManager 所以在这里引入相关文件
#import "GGNetWorkManager.h"

#ifdef DEBUG
#define GGNetWorkLog(...) \
    if ([GGNetWorkManager share].debugLogEnable) { \
        NSLog(__VA_ARGS__); \
    }
#else
#define GGNetWorkLog(...)
#endif

// 屏蔽没有定义方法的警告
#define GGNetWorkPushIgnoreUndeclaredSelectorWarning \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"")

#define GGNetWorkPopClangDiagnosticWarnings _Pragma("clang diagnostic pop")
