//
//  CXGLNTitleTextFieldCell.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/8.
//

#import "GGBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXGLNTitleTextFieldCell : GGBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) QMUITextField *textField;
@property (nonatomic, assign) BOOL canEdit;

@end

NS_ASSUME_NONNULL_END
