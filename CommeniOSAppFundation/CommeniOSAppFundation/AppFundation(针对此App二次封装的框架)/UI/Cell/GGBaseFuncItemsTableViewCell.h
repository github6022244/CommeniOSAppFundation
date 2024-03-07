//
//  NewStudentUserCenterFuncItemCell.h
//  CXGrainStudentApp
//
//  Created by GG on 2022/5/5.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "GGBaseTableViewCell.h"

@class GGBaseFuncItemsTableViewCell;
@class GGBaseFuncItem;


@protocol GGBaseFuncItemsTableViewCellDelegate <NSObject>

// 点击某个item
- (void)funcItemCell:(GGBaseFuncItemsTableViewCell *)cell clickItemAtIndex:(NSUInteger)index;

@end


NS_ASSUME_NONNULL_BEGIN

@interface GGBaseFuncItemsTableViewCell : GGBaseTableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readonly) UICollectionView *toolBarCollectionView;

@property (nonatomic, weak) id<GGBaseFuncItemsTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSArray<GGBaseFuncItem *> *toolBarArr;

@end

NS_ASSUME_NONNULL_END








@interface GGBaseFuncItemsCollectionCell : UICollectionViewCell

@property (nonatomic, strong) GGBaseFuncItem *itemModel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *ttLabel;

@end







@interface GGBaseFuncItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;

@end
