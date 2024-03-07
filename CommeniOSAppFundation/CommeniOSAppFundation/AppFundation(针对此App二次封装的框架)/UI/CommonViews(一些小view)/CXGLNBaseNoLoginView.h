//
//  CXGLNBaseNoLoginView.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/7/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CXGLNBaseNoLoginViewDelegate <NSObject>

@optional
- (void)loginButtonDidClick;

@end

@interface CXGLNBaseNoLoginView : UIView

@property (nonatomic, weak) id<CXGLNBaseNoLoginViewDelegate> delegate;

@property (nonatomic, strong) UIImageView *noLoginImageView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *detailL;

@property (nonatomic, strong) UIButton *loginButton;

@end

NS_ASSUME_NONNULL_END
