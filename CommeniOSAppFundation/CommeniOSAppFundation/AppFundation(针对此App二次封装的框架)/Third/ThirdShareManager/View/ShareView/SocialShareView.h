//
//  SocialShareView.h
//  CXGrainStudentApp
//
//  Created by User on 2020/10/13.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ShareFromPage) {
    ShareFromPageNone,
    /// 快闪页面
    ShareFromPageDouyinLike,
    /// 保险
    ShareFromPageInfurance,
    /// 活动页
    ShareFromPageActivity,
    /// 教材选用榜单
    ShareFromPageTextbookSelectList,
    /// banner跳转的网页
    ShareFromPageBannerUrl,
    /// 第二次活动页面
    ShareFromPageSecondActivity,
    /// 教材详情页面 7
    ShareFromPageBookDetail,
    /// 电子书详情页面
    ShareFromPageEbookDetail,
    /// 电子书权益邀请新用户
    ShareFromPageEbookInviteUser,
    /// 第二次教材巡展
    ShareFromPageTextbookShow
};

@interface SocialShareView : UIView

+ (void)showShareViewWithTitle:(NSString *)title
                   description:(NSString *)description
                      imageUrl:(NSString *)imageUrl
                           url:(NSString *)url
                 shareFromPage:(ShareFromPage)shareFromPage
                   sharedParam:(NSDictionary *)sharedParam
                  onlyShareUrl:(BOOL)onlyShareUrl;

+ (void)showShareViewWithTitle:(NSString *)title
                   description:(NSString *)description
                      imageUrl:(NSString *)imageUrl
                           url:(NSString *)url
                 shareFromPage:(ShareFromPage)shareFromPage
                   sharedParam:(NSDictionary *)sharedParam
                  onlyShareUrl:(BOOL)onlyShareUrl
            shareCompleteBlock:(void(^)(BOOL isSuccess))shareCompleteBlock;

- (instancetype)initWithTitle:(NSString *)title
                  description:(NSString *)description
                     imageUrl:(NSString *)imageUrl
                          url:(NSString *)url
                shareFromPage:(ShareFromPage)shareFromPage
                  sharedParam:(NSDictionary *)sharedParam
                 onlyShareUrl:(BOOL)onlyShareUrl
           shareCompleteBlock:(nullable void(^)(BOOL isSuccess))shareCompleteBlock;

- (void)showView;

- (void)dismissView;

@end

NS_ASSUME_NONNULL_END
