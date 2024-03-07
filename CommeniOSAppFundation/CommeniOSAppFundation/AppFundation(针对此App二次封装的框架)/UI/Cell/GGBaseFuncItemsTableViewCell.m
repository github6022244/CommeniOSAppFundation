//
//  NewStudentUserCenterFuncItemCell.m
//  CXGrainStudentApp
//
//  Created by GG on 2022/5/5.
//  Copyright © 2022 ChangXiangCloud. All rights reserved.
//

#import "GGBaseFuncItemsTableViewCell.h"

@interface GGBaseFuncItemsTableViewCell ()

@property (nonatomic, strong) UICollectionView *toolBarCollectionView;

@end

@implementation GGBaseFuncItemsTableViewCell

#pragma mark ------------------------- UI -------------------------
- (void)base_setUpUI {
    [super base_setUpUI];
    
    [self makeBackGroudColorNil];
    
    [self.contentView addSubview:self.toolBarCollectionView];
    [self.toolBarCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 16 * kScaleFit, 0, 16 * kScaleFit));
    }];
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark - collectionViewDelegateAndDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.toolBarArr.count;
}

// 每个UICollectionViewCell展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GGBaseFuncItemsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GGBaseFuncItemsCollectionCell" forIndexPath:indexPath];
    GGBaseFuncItem *model = [self.toolBarArr gg_safeObjectAtIndex:indexPath.item];
    cell.itemModel = model;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(funcItemCell:clickItemAtIndex:)]) {
        [self.delegate funcItemCell:self clickItemAtIndex:indexPath.item];
    }
}

#pragma mark ------------------------- Interface -------------------------
+ (CGFloat)cellHeight {
    return 100 * kScaleFit;
}

#pragma mark ------------------------- set / get -------------------------
- (UICollectionView *)toolBarCollectionView {
    if (!_toolBarCollectionView) {
        CGFloat itemWidth = (SCREEN_WIDTH - 16 * kScaleFit * 2 - 5 * kScaleFit * 2) / 5.0;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0; //上下间距
//        flowLayout.minimumLineSpacing = (SCREEN_WIDTH - (20 * 2 + 56 * 4) * kScaleFit) / 3;//32.0 * kScaleFit;   //左右间距
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5 * kScaleFit, 0, 5 * kScaleFit);
//        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.itemSize = CGSizeMake(itemWidth, [GGBaseFuncItemsTableViewCell cellHeight]);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _toolBarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 16 * kScaleFit * 2, [GGBaseFuncItemsTableViewCell cellHeight]) collectionViewLayout:flowLayout];
        _toolBarCollectionView.layer.cornerRadius = 8.f;
        _toolBarCollectionView.backgroundColor = UIColorForBackground;
        _toolBarCollectionView.showsHorizontalScrollIndicator = NO;
        _toolBarCollectionView.scrollEnabled = YES;
        _toolBarCollectionView.delegate = self;
        _toolBarCollectionView.dataSource = self;
        [_toolBarCollectionView registerClass:[GGBaseFuncItemsCollectionCell class] forCellWithReuseIdentifier:@"GGBaseFuncItemsCollectionCell"];
        _toolBarCollectionView.tag = 1000;
    }
    return _toolBarCollectionView;
}

@end












@implementation GGBaseFuncItemsCollectionCell

#pragma mark ------------------------- Cycle -------------------------
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    
    return self;
}

#pragma mark ------------------------- UI -------------------------
- (void)setUpUI {
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16 * kScaleFit);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40 * kScaleFit, 44 * kScaleFit));
    }];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _ttLabel = [UILabel labelWithSuperView:self.contentView withContent:nil withBackgroundColor:nil withTextColor:UIColorMakeWithHex(@"#020822") withFont:UIFontMake(12)];
    [_ttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_bottom).mas_equalTo(9 * kScaleFit);
        make.bottom.mas_equalTo(- 19 * kScaleFit);
        make.left.right.equalTo(self.contentView);
    }];
    _ttLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark ------------------------- set / get -------------------------
- (void)setItemModel:(GGBaseFuncItem *)itemModel {
    _itemModel = itemModel;
    
    _iconImageView.image = UIImageMake(itemModel.icon);
    
    _ttLabel.text = itemModel.title;
}

@end














@implementation GGBaseFuncItem

MJLogAllIvars

@end
