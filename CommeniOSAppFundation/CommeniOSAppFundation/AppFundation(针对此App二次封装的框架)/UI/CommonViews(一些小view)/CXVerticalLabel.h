//
//  CXVertitalLabel.h
//  CXGrainStudentApp
//
//  Created by LiuZhengwei on 2020/10/9.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface CXVerticalLabel : UILabel {
  @private
    VerticalAlignment _verticalAlignment;
}
@property (nonatomic) VerticalAlignment verticalAlignment;

@end

NS_ASSUME_NONNULL_END
