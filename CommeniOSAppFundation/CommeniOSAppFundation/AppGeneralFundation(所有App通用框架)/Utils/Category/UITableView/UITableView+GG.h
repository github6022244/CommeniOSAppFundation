//
//  UITableView+GG.h
//  CXGLNewStudentApp
//
//  Created by GG on 2024/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (GG)

/// 解决 UITableViewStyleGrouped 偏移问题
- (void)gg_fixGroupedTableViewExcursion;

@end

NS_ASSUME_NONNULL_END
