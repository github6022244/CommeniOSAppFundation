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

/**
 *  如果 fromClass 里存在 originSelector，则这个函数会将 fromClass 里的 originSelector 与 toClass 里的 newSelector 交换实现。
 *  如果 fromClass 里不存在 originSelecotr，则这个函数会为 fromClass 增加方法 originSelector，并且该方法会使用 toClass 的 newSelector 方法的实现，而 toClass 的 newSelector 方法的实现则会被替换为空内容
 *  @warning 注意如果 fromClass 里的 originSelector 是继承自父类并且 fromClass 也没有重写这个方法，这会导致实际上被替换的是父类，然后父类及父类的所有子类（也即 fromClass 的兄弟类）也受影响，因此使用时请谨记这一点。因此建议使用 OverrideImplementation 系列的方法去替换，尽量避免使用 ExchangeImplementations。
 *  @param _fromClass 要被替换的 class，不能为空
 *  @param _originSelector 要被替换的 class 的 selector，可为空，为空则相当于为 fromClass 新增这个方法
 *  @param _toClass 要拿这个 class 的方法来替换
 *  @param _newSelector 要拿 toClass 里的这个方法来替换 originSelector
 *  @return 是否成功替换（或增加）
 */
CG_INLINE BOOL
GGNetWorkExchangeImplementationsInTwoClasses(Class _fromClass, SEL _originSelector, Class _toClass, SEL _newSelector) {
    if (!_fromClass || !_toClass) {
        return NO;
    }
    
    Method oriMethod = class_getInstanceMethod(_fromClass, _originSelector);
    Method newMethod = class_getInstanceMethod(_toClass, _newSelector);
    if (!newMethod) {
        return NO;
    }
    
    BOOL isAddedMethod = class_addMethod(_fromClass, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        // 如果 class_addMethod 成功了，说明之前 fromClass 里并不存在 originSelector，所以要用一个空的方法代替它，以避免 class_replaceMethod 后，后续 toClass 的这个方法被调用时可能会 crash
        IMP oriMethodIMP = method_getImplementation(oriMethod) ?: imp_implementationWithBlock(^(id selfObject) {});
        const char *oriMethodTypeEncoding = method_getTypeEncoding(oriMethod) ?: "v@:";
        class_replaceMethod(_toClass, _newSelector, oriMethodIMP, oriMethodTypeEncoding);
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
    return YES;
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
