//
//  GGBaseInputMessageView.h
//  CXGrainStudentApp
//
//  Created by GG on 2022/5/17.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGBaseInputMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GGBaseInputMessageView : UIView

@property (nonatomic, strong, readonly) QMUILabel *titleLabel;

@property (nonatomic, strong) GGBaseInputMessage *messageModel;

+ (instancetype)viewWithModel:(GGBaseInputMessage *)messageModel;

@end

NS_ASSUME_NONNULL_END












@interface UITextView (GGBaseInputMessageView)

@property (nonatomic, strong) GGBaseInputMessageBaseModel *model;

@end
