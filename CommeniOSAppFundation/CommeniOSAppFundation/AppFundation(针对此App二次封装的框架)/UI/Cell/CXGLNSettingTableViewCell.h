//
//  CXGLNSettingTableViewCell.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/6.
//

#import "GGBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXGLNSettingTableViewCell : GGBaseTableViewCell

- (void)setLeftLabelText:(NSString *)leftStr AndRightLabelText:(NSString *)rightStr rightFont:(CGFloat)rightFontSize;

@end

NS_ASSUME_NONNULL_END
