//
//  CXGLNAuthenticationInfoCell.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/2.
//

#import "GGBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXGLNAuthenticationInfoCell : GGBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, assign) BOOL required;

- (void)setTitle:(NSString *)title required:(BOOL)required canEdit:(BOOL)canEdit;

@end

NS_ASSUME_NONNULL_END
