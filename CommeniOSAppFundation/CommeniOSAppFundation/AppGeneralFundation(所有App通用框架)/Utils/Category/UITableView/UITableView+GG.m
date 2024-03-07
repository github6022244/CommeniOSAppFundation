//
//  UITableView+GG.m
//  CXGLNewStudentApp
//
//  Created by GG on 2024/3/4.
//

#import "UITableView+GG.h"

@implementation UITableView (GG)

- (void)gg_fixGroupedTableViewExcursion {
    if (self.style == UITableViewStyleGrouped) {
        if (!self.tableHeaderView) {
            self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        }
        
        if (!self.tableFooterView) {
            self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        }
    }
}

@end
