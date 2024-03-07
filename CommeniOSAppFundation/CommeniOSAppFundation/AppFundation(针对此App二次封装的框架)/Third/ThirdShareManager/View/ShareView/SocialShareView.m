//
//  SocialShareView.m
//  CXGrainStudentApp
//
//  Created by User on 2020/10/13.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

typedef NS_ENUM(NSInteger, FromPageType) {
    FromPageTypeHomepageMorePage,
    FromPageTypeSearchPage,
    FromPageActivityPage,
    FromPageTypeMyLike,
};

#import "SocialShareView.h"
#import "ShareItemView.h"

// model
#import "ShareInfoModel.h"

#import "QQSharedManager.h"
#import "WechatSharedManager.h"

//#import "CXGFlashHeader.h"

//#import "CXGActivityNetwork.h"

#define SHARE_VIEW_HEIGHT 240

@interface SocialShareView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *cancelLabel;

@property (nonatomic, strong) ShareItemView *QQView;
@property (nonatomic, strong) ShareItemView *wechatView;
@property (nonatomic, strong) ShareItemView *cycleView;

@property (nonatomic, strong) NSMutableArray *infoArr;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *descriptionStr;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) NSDictionary *sharedParam;
@property (nonatomic, assign) ShareFromPage shareFromPage;

@property (nonatomic, assign) BOOL onlyShareUrl;

@property (nonatomic, copy) void(^shareCompleteBlock)(BOOL isSuccess);

@end

@implementation SocialShareView

+ (void)showShareViewWithTitle:(NSString *)title
                   description:(NSString *)description
                      imageUrl:(NSString *)imageUrl
                           url:(NSString *)url
                 shareFromPage:(ShareFromPage)shareFromPage
                   sharedParam:(NSDictionary *)sharedParam
                  onlyShareUrl:(BOOL)onlyShareUrl {
    SocialShareView *shareView = [[SocialShareView alloc] initWithTitle:title description:description imageUrl:imageUrl url:url shareFromPage:shareFromPage sharedParam:sharedParam onlyShareUrl:onlyShareUrl];
    [shareView showView];
}

+ (void)showShareViewWithTitle:(NSString *)title
                   description:(NSString *)description
                      imageUrl:(NSString *)imageUrl
                           url:(NSString *)url
                 shareFromPage:(ShareFromPage)shareFromPage
                   sharedParam:(NSDictionary *)sharedParam
                  onlyShareUrl:(BOOL)onlyShareUrl
            shareCompleteBlock:(void(^)(BOOL isSuccess))shareCompleteBlock {
    SocialShareView *shareView = [[SocialShareView alloc] initWithTitle:title description:description imageUrl:imageUrl url:url shareFromPage:shareFromPage sharedParam:sharedParam onlyShareUrl:onlyShareUrl shareCompleteBlock:shareCompleteBlock];
    [shareView showView];
}

- (instancetype)initWithTitle:(NSString *)title
                  description:(NSString *)description
                     imageUrl:(NSString *)imageUrl
                          url:(NSString *)url
                shareFromPage:(ShareFromPage)shareFromPage
                  sharedParam:(NSDictionary *)sharedParam
                 onlyShareUrl:(BOOL)onlyShareUrl {
    return [self initWithTitle:title description:description imageUrl:imageUrl url:url shareFromPage:shareFromPage sharedParam:sharedParam onlyShareUrl:onlyShareUrl shareCompleteBlock:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                  description:(NSString *)description
                     imageUrl:(NSString *)imageUrl
                          url:(NSString *)url
                shareFromPage:(ShareFromPage)shareFromPage
                  sharedParam:(NSDictionary *)sharedParam
                 onlyShareUrl:(BOOL)onlyShareUrl
           shareCompleteBlock:(nullable void(^)(BOOL isSuccess))shareCompleteBlock {
    if (self = [super init]) {
        _title = title;
        _descriptionStr = description;
        _imageUrl = imageUrl;
        _url = url;
        _shareFromPage = shareFromPage;
        _sharedParam = sharedParam;
        _onlyShareUrl = onlyShareUrl;
        _shareCompleteBlock = shareCompleteBlock;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.frame = [UIScreen mainScreen].bounds;
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.backgroundView];
    [self addSubview:self.contentView];

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.cancelLabel];
    [self.contentView addSubview:self.QQView];
    [self.contentView addSubview:self.wechatView];
    [self.contentView addSubview:self.cycleView];
    [self addMasonry];
    [self setContentValue];
}

- (void)addMasonry {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.right.mas_equalTo(self.contentView);
    }];

    NSArray *array = @[ self.QQView, self.wechatView, self.cycleView ];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:30 tailSpacing:30];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(100);
    }];
}

- (void)setContentValue {
    ShareInfoModel *model1 = [ShareInfoModel new];
    model1.itemImageName = @"icon_social_qq";
    model1.itemTitle = @"QQ";

    ShareInfoModel *model2 = [ShareInfoModel new];
    model2.itemImageName = @"icon_social_wechat";
    model2.itemTitle = @"微信";

    ShareInfoModel *model3 = [ShareInfoModel new];
    model3.itemImageName = @"icon_social_cycle";
    model3.itemTitle = @"朋友圈";

    self.QQView.shareInfoModel = model1;
    self.wechatView.shareInfoModel = model2;
    self.cycleView.shareInfoModel = model3;
}

#pragma mark-- show and dismiss view
- (void)showView {
    UIWindow *window = [UIWindow getKeyWindow];
    [window addSubview:self];

    CGRect rect = self.contentView.frame;
    rect.origin.y = SCREEN_HEIGHT;
    self.contentView.frame = rect;

    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect rect = self.contentView.frame;
                         rect.origin.y -= (SHARE_VIEW_HEIGHT + SafeAreaInsetsConstantForDeviceWithNotch.bottom);
                         self.contentView.frame = rect;
                     }];
}

- (void)dismissView {
    [UIView animateWithDuration:0.5
        animations:^{
            CGRect rect = self.contentView.frame;
            rect.origin.y += (SHARE_VIEW_HEIGHT + SafeAreaInsetsConstantForDeviceWithNotch.bottom);
            self.contentView.frame = rect;
            self.backgroundView.alpha = 0;
        }
        completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

#pragma mark-- click actions
- (void)didTapBackgroundView:(UITapGestureRecognizer *)tap {
    [self dismissView];
}

- (NSString *)getSharedUrl {
    NSString *sharedUrl = @"";

    if (self.onlyShareUrl) {
        if (self.shareFromPage == ShareFromPageBannerUrl) {
            sharedUrl = NSStringTransformEmpty(self.url);
        } else {
            sharedUrl = NSStringTransformEmpty(self.url);
            sharedUrl = [NSString stringWithFormat:@"%@&shareType=%zd&openInApp=0", sharedUrl, (NSInteger)self.shareFromPage];
        }
    } else {
        sharedUrl = [@"http://www.changxianggu.com/index/index/shareVideo/shareVideo.html?flashUrl=" stringByAppendingString:self.url];
        NSInteger flash_id = [self.sharedParam[@"flash_id"] integerValue];
        sharedUrl = [NSString stringWithFormat:@"%@&flash_id=%zd", sharedUrl, flash_id];
        
        FromPageType fromPageType = (FromPageType)[self.sharedParam[@"fromPageType"] integerValue];
        sharedUrl = [NSString stringWithFormat:@"%@&fromPageType=%zd", sharedUrl, fromPageType];
        
        NSInteger current_page = [self.sharedParam[@"current_page"] integerValue];
        sharedUrl = [NSString stringWithFormat:@"%@&current_page=%zd", sharedUrl, current_page];
        
        NSInteger current_item = [self.sharedParam[@"current_item"] integerValue];
        sharedUrl = [NSString stringWithFormat:@"%@&current_item=%zd", sharedUrl, current_item];
        
        NSInteger sort_type = [self.sharedParam[@"sort_type"] integerValue];
        sharedUrl = [NSString stringWithFormat:@"%@&sort_type=%zd", sharedUrl, sort_type];
        
        NSInteger press_id = [self.sharedParam[@"press_id"] integerValue];
        sharedUrl = [NSString stringWithFormat:@"%@&press_id=%zd", sharedUrl, press_id];
        
        NSString *searchKey = [NSString stringWithFormat:@"%@", self.sharedParam[@"searchKey"]];
        sharedUrl = [NSString stringWithFormat:@"%@&searchKey=%@", sharedUrl, searchKey];
        
        NSString *isbn = @"";
        if ([self.sharedParam.allKeys containsObject:@"isbn"]) {
            isbn = self.sharedParam[@"isbn"];
        }
        
        if (self.shareFromPage == ShareFromPageDouyinLike) {
            [self addFlashShareNumFlashId:flash_id pressId:press_id isbn:isbn];
        }
        
        sharedUrl = [NSString stringWithFormat:@"%@&shareType=%d", sharedUrl, self.shareFromPage == ShareFromPageDouyinLike ? 1 : 0];
        if (self.shareFromPage == ShareFromPageBookDetail) {
            NSInteger link_type = [self.sharedParam[@"link_type"] integerValue];
            NSString *link_uuid = self.sharedParam[@"link_uuid"];
            NSInteger detailPageType = [self.sharedParam[@"detailPageType"] integerValue];
            sharedUrl = [NSString stringWithFormat:@"%@&link_type=%zd", sharedUrl, link_type];
            sharedUrl = [NSString stringWithFormat:@"%@&link_uuid=%@", sharedUrl, link_uuid];
            sharedUrl = [NSString stringWithFormat:@"%@&book_type=%zd", sharedUrl, detailPageType];
            sharedUrl = [NSString stringWithFormat:@"%@&openInApp=0", sharedUrl];
        } else if (self.shareFromPage == ShareFromPageEbookDetail) {
            sharedUrl = [NSString stringWithFormat:@"%@&openInApp=0", sharedUrl];
        }
    }
    
    if (self.shareFromPage == ShareFromPageActivity) {
        [self addActivityShareNum];
    }

    return sharedUrl;
}

- (void)addFlashShareNumFlashId:(NSInteger)flashId pressId:(NSInteger)pressId isbn:(NSString *)isbn {
#warning -gg 0.0.1 屏蔽
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"flash_id"] = @(flashId);
//    param[@"press_id"] = @(pressId);
//    param[@"ISBN"] = NSStringTransformEmpty(isbn);
//
//    [FlashNetwork addFlashVideoShareNumWithParam:param
//                                        success:^(ResponseStatus responseStatus, NSInteger code, NSString *_Nonnull message, id _Nonnull responseObject) {
//                                        }
//                                        failure:^(NSError *_Nonnull error){
//                                        }];
}
//
- (void)addActivityShareNum {
#warning -gg 0.0.1 屏蔽
//    [CXGActivityNetwork shareActivityWithParam:@{} success:^(ResponseStatus responseStatus, NSInteger code, NSString * _Nonnull message, id  _Nonnull responseObject) {
//    } failure:^(NSError * _Nonnull error) {
//    }];
}

- (void)qqShareAction {
    @ggweakify(self);
    [[QQSharedManager sharedManager] shareWebWithURL:[self getSharedUrl]
                                               title:self.title
                                         description:self.descriptionStr
                                       thumbImageURL:self.imageUrl
                                           shareType:QQShareType_QQ
                                       shareDestType:QQShareDestType_QQ
                                             showHUD:NO
                                     completionBlock:^(BOOL isSuccess){
                                        @ggstrongify(self);
                                        if (self.shareCompleteBlock) {
                                            self.shareCompleteBlock(isSuccess);
                                        }
                                     }];
    [self dismissView];
}

- (void)wechatShareAction {
    @ggweakify(self);
    [[WechatSharedManager sharedManager] shareWebWithURL:[self getSharedUrl]
                                                   title:self.title
                                             description:self.descriptionStr
                                              thumbImage:[UIImage imageNamed:@"appShareIcon"]
                                               shareType:WechatShareType_Session
                                                 showHUD:NO
                                         completionBlock:^(BOOL isSuccess){
                                            @ggstrongify(self);
                                            if (self.shareCompleteBlock) {
                                                self.shareCompleteBlock(isSuccess);
                                            }
                                         }];
    [self dismissView];
}

- (void)cycleShareAction {
    @ggweakify(self);
    [[WechatSharedManager sharedManager] shareWebWithURL:[self getSharedUrl]
                                                   title:self.title
                                             description:self.descriptionStr
                                              thumbImage:[UIImage imageNamed:@"appShareIcon"]
                                               shareType:WechatShareType_Timeline
                                                 showHUD:NO
                                         completionBlock:^(BOOL isSuccess){
                                            @ggstrongify(self);
                                            if (self.shareCompleteBlock) {
                                                self.shareCompleteBlock(isSuccess);
                                            }
                                         }];
    [self dismissView];
}

#pragma mark-- lazy
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2f];
        // 设置子视图的大小随着父视图变化
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:myTap];
    }
    return _backgroundView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SHARE_VIEW_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom, SCREEN_WIDTH, SHARE_VIEW_HEIGHT + SafeAreaInsetsConstantForDeviceWithNotch.bottom)];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _contentView.userInteractionEnabled = YES;
        _contentView.backgroundColor = TableViewBackgroundColor;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.text = @"选择要分享到的平台";
    }
    return _titleLabel;
}

- (UILabel *)cancelLabel {
    if (!_cancelLabel) {
        _cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SHARE_VIEW_HEIGHT - 50, SCREEN_WIDTH, 50)];
        _cancelLabel.font = [UIFont systemFontOfSize:16.f];
        _cancelLabel.textAlignment = NSTextAlignmentCenter;
        _cancelLabel.textColor = [UIColor darkGrayColor];
        _cancelLabel.backgroundColor = [UIColor whiteColor];
        _cancelLabel.text = @"取消分享";
        _cancelLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        [_cancelLabel addGestureRecognizer:tap];
    }
    return _cancelLabel;
}

- (ShareItemView *)QQView {
    if (!_QQView) {
        _QQView = [[ShareItemView alloc] init];
        _QQView.backgroundColor = TableViewBackgroundColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qqShareAction)];
        _QQView.userInteractionEnabled = YES;
        [_QQView addGestureRecognizer:tap];
    }
    return _QQView;
}

- (ShareItemView *)wechatView {
    if (!_wechatView) {
        _wechatView = [[ShareItemView alloc] init];
        _wechatView.backgroundColor = TableViewBackgroundColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wechatShareAction)];
        _wechatView.userInteractionEnabled = YES;
        [_wechatView addGestureRecognizer:tap];
    }
    return _wechatView;
}

- (ShareItemView *)cycleView {
    if (!_cycleView) {
        _cycleView = [[ShareItemView alloc] init];
        _cycleView.backgroundColor = TableViewBackgroundColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cycleShareAction)];
        _cycleView.userInteractionEnabled = YES;
        [_cycleView addGestureRecognizer:tap];
    }
    return _cycleView;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
