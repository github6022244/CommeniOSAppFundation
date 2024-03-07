//
//  GGBaseTitleImageView.h
//  CXGrainStudentApp
//
//  Created by GG on 2022/4/22.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GGBaseTitleImageItem;

NS_ASSUME_NONNULL_BEGIN

@interface GGBaseTitleImageView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, strong) GGBaseTitleImageItem *itemModel;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, assign) BOOL showRightArrowImage;

@property (nonatomic, assign) BOOL showRightRedPointView;


@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subTitleLabel;
@property (nonatomic, strong, readonly) UIImageView *rightArrowImageView;
@property (nonatomic, strong, readonly) UIImageView *rightRedImageView;
@property (nonatomic, assign, readonly) CGFloat rightRedImageViewSize;

+ (instancetype)view;

+ (CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END











@interface GGBaseTitleImageItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, assign) BOOL showRightArrowImageView;

@property (nonatomic, assign) BOOL showRightRedImageView;

@end
