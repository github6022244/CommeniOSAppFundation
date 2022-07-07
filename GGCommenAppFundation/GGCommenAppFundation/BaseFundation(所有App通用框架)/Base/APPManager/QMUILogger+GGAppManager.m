//
//  QMUILogger+GGAppManager.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/5/31.
//

#import "QMUILogger+GGAppManager.h"
#import "GGAppManager.h"
#import <QMUIRuntime.h>

static NSUInteger kQMUILoggerAlertCount = 1;

@implementation QMUILogger (GGAppManager)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(printLogWithFile:line:func:logItem:), @selector(gg_printLogWithFile:line:func:logItem:));
    });
}

- (void)gg_printLogWithFile:(const char *)file line:(int)line func:(const char *)func logItem:(QMUILogItem *)logItem {
    if (GGAppManager.logAble) {
        [self gg_printLogWithFile:file line:line func:func logItem:logItem];
    } else if (IS_DEBUG && kQMUILoggerAlertCount) {
        NSLog(@"\n GGWarning: 当前 GGAppManager.logAble == NO, 所以不打印 QMUILog(...), 如需打印可以搜索 'GGAppManager.logAble =' 设置为YES即可");
        
        kQMUILoggerAlertCount--;
    }
}

@end
