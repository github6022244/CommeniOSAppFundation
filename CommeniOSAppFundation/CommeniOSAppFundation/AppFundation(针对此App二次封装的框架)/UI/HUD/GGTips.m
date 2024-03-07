//
//  GGTips.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/12/22.
//

#import "GGTips.h"
#import <UIImage+GIF.h>
#import <QMUICore.h>
#import <QMUIToastContentView.h>
#import <QMUIToastBackgroundView.h>
#import <NSString+QMUI.h>
#import <Lottie.h>

const NSInteger GGTipsAutomaticallyHideToastSeconds = -1;

#define GGTipsLoadingGIFName @"icon_loading2"

@interface GGTips ()

@property(nonatomic, strong) UIView *contentCustomView;

@property (nonatomic, strong) UIImage *loadingImage;

@property (nonatomic, strong) UIImageView *loadingImageView;

@property (nonatomic, strong) LOTAnimationView *loadingAnimationView;

@end

@implementation GGTips

- (void)reconfigContentView {
    UIView *backGroundView = self.backgroundView;
    UIView *contentView = self.contentView;
    
    if ([backGroundView isKindOfClass:[QMUIToastBackgroundView class]] && [contentView isKindOfClass:[QMUIToastContentView class]]) {
        QMUIToastBackgroundView *bgView = (QMUIToastBackgroundView *)self.backgroundView;
        QMUIToastContentView *cView = (QMUIToastContentView *)self.contentView;
        
        BOOL isDark = bgView.styleColor.qmui_colorIsDark;
        
        UIColor *textColor = isDark ? UIColorForBackground : UIColor.qd_mainTextColor;
    
        UIColor *detailTextColor = isDark ? UIColorForBackground : UIColor.qd_descriptionTextColor;
            
        cView.textLabelAttributes = @{
            NSFontAttributeName: UIFontMediumMake(15),
            NSParagraphStyleAttributeName: [NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:22 lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentCenter],
            NSForegroundColorAttributeName: textColor,
        };
        cView.detailTextLabelAttributes = @{
            NSFontAttributeName: UIFontMediumMake(13),
            NSParagraphStyleAttributeName: [NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:18 lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentCenter],
            NSForegroundColorAttributeName: detailTextColor,
        };
    }
}

- (void)showLoading {
    [self showLoading:nil hideAfterDelay:0];
}

- (void)showLoadingHideAfterDelay:(NSTimeInterval)delay {
    [self showLoading:nil hideAfterDelay:delay];
}

- (void)showLoading:(NSString *)text {
    [self showLoading:text hideAfterDelay:0];
}

- (void)showLoading:(NSString *)text hideAfterDelay:(NSTimeInterval)delay {
    [self showLoading:text detailText:nil hideAfterDelay:delay];
}

- (void)showLoading:(NSString *)text detailText:(NSString *)detailText {
    [self showLoading:text detailText:detailText hideAfterDelay:0];
}

- (void)showLoading:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay {
    self.contentCustomView = nil;
    
    self.contentCustomView = self.loadingAnimationView;
    [self.loadingAnimationView play];
    
    [self showTipWithText:text detailText:detailText hideAfterDelay:delay];
}

- (void)showWithText:(NSString *)text {
    [self showWithText:text detailText:nil hideAfterDelay:0];
}

- (void)showWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delay {
    [self showWithText:text detailText:nil hideAfterDelay:delay];
}

- (void)showWithText:(NSString *)text detailText:(NSString *)detailText {
    [self showWithText:text detailText:detailText hideAfterDelay:0];
}

- (void)showWithText:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay {
    self.contentCustomView = nil;
    
    [self showTipWithText:text detailText:detailText hideAfterDelay:delay];
}

- (void)showSucceed:(NSString *)text {
    [self showSucceed:text detailText:nil hideAfterDelay:0];
}

- (void)showSucceed:(NSString *)text hideAfterDelay:(NSTimeInterval)delay {
    [self showSucceed:text detailText:nil hideAfterDelay:delay];
}

- (void)showSucceed:(NSString *)text detailText:(NSString *)detailText {
    [self showSucceed:text detailText:detailText hideAfterDelay:0];
}

- (void)showSucceed:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay {
    self.contentCustomView = nil;
    
    self.contentCustomView = [[UIImageView alloc] initWithImage:[[QMUIHelper imageWithName:@"QMUI_tips_done"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];

//    QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)self.backgroundView;
//    backgroundView.styleColor = GGAppThemeStyleIsDark ? UIColorForBackground : [UIColorBlack colorWithAlphaComponent:0.8];
    
    [self showTipWithText:text detailText:detailText hideAfterDelay:delay];
}

- (void)showError:(NSString *)text {
    [self showError:text detailText:nil hideAfterDelay:0];
}

- (void)showError:(NSString *)text hideAfterDelay:(NSTimeInterval)delay {
    [self showError:text detailText:nil hideAfterDelay:delay];
}

- (void)showError:(NSString *)text detailText:(NSString *)detailText {
    [self showError:text detailText:detailText hideAfterDelay:0];
}

- (void)showError:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay {
    self.contentCustomView = nil;
    
    self.contentCustomView = [[UIImageView alloc] initWithImage:[[QMUIHelper imageWithName:@"QMUI_tips_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self showTipWithText:text detailText:detailText hideAfterDelay:delay];
}

- (void)showInfo:(NSString *)text {
    [self showInfo:text detailText:nil hideAfterDelay:0];
}

- (void)showInfo:(NSString *)text hideAfterDelay:(NSTimeInterval)delay {
    [self showInfo:text detailText:nil hideAfterDelay:delay];
}

- (void)showInfo:(NSString *)text detailText:(NSString *)detailText {
    [self showInfo:text detailText:detailText hideAfterDelay:0];
}

- (void)showInfo:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay {
    self.contentCustomView = nil;
    
    self.contentCustomView = [[UIImageView alloc] initWithImage:[[QMUIHelper imageWithName:@"QMUI_tips_info"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self showTipWithText:text detailText:detailText hideAfterDelay:delay];
}

- (void)showTipWithText:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay {
    
    QMUIToastContentView *contentView = (QMUIToastContentView *)self.contentView;
    contentView.customView = self.contentCustomView;
    
    if ([self.backgroundView isKindOfClass:[QMUIToastBackgroundView class]]) {
        BOOL isShowLoading = [self.contentCustomView isEqual:self.loadingAnimationView];
        QMUIToastBackgroundView *bgView = (QMUIToastBackgroundView *)self.backgroundView;
        bgView.styleColor = (isShowLoading && !text.length && !detailText.length) ? UIColorClear : [UIColorBlack colorWithAlphaComponent:0.8];
        
        if (isShowLoading) {
            @ggweakify(self)
            self.didHideBlock = ^(UIView * _Nonnull hideInView, BOOL animated) {
                @ggstrongify(self)
                [self.loadingAnimationView stop];
            };
        }
    }
    
    contentView.textLabelText = text ?: @"";
    contentView.detailTextLabelText = detailText ?: @"";
    
    [self reconfigContentView];
    
    [self showAnimated:YES];
    
    if (delay == GGTipsAutomaticallyHideToastSeconds) {
        [self hideAnimated:YES afterDelay:[GGTips smartDelaySecondsForTipsText:text]];
    } else if (delay > 0) {
        [self hideAnimated:YES afterDelay:delay];
    }
    
    [self postAccessibilityAnnouncement:text detailText:detailText];
}

- (void)postAccessibilityAnnouncement:(NSString *)text detailText:(NSString *)detailText {
    NSString *announcementString = nil;
    if (text) {
        announcementString = text;
    }
    if (detailText) {
        announcementString = announcementString ? [text stringByAppendingFormat:@", %@", detailText] : detailText;
    }
    if (announcementString) {
        // 发送一个让VoiceOver播报的Announcement，帮助视障用户获取toast内的信息，但是这个播报会被即时打断而不生效，所以在这里延时1秒发送此通知。
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcementString);
        });
    }
}

+ (NSTimeInterval)smartDelaySecondsForTipsText:(NSString *)text {
    NSUInteger length = text.qmui_lengthWhenCountingNonASCIICharacterAsTwo;
    if (length <= 20) {
        return 1.5;
    } else if (length <= 40) {
        return 2.0;
    } else if (length <= 50) {
        return 2.5;
    } else {
        return 3.0;
    }
}

+ (GGTips *)showLoadingInView:(UIView *)view {
    return [self showLoading:nil detailText:nil inView:view hideAfterDelay:0];
}

+ (GGTips *)showLoading:(NSString *)text inView:(UIView *)view {
    return [self showLoading:text detailText:nil inView:view hideAfterDelay:0];
}

+ (GGTips *)showLoadingInView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showLoading:nil detailText:nil inView:view hideAfterDelay:delay];
}

+ (GGTips *)showLoading:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showLoading:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (GGTips *)showLoading:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showLoading:text detailText:detailText inView:view hideAfterDelay:0];
}

+ (GGTips *)showLoading:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    GGTips *tips = [self createTipsToView:view];
    [tips showLoading:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (GGTips *)showWithText:(nullable NSString *)text {
    return [self showWithText:text detailText:nil inView:GGDefaultTipsParentView hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText {
    return [self showWithText:text detailText:detailText inView:GGDefaultTipsParentView hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showWithText:(NSString *)text inView:(UIView *)view {
    return [self showWithText:text detailText:nil inView:view hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showWithText:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showWithText:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (GGTips *)showWithText:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showWithText:text detailText:detailText inView:view hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showWithText:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    GGTips *tips = [self createTipsToView:view];
    [tips showWithText:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (GGTips *)showSucceed:(nullable NSString *)text {
    return [self showSucceed:text detailText:nil inView:GGDefaultTipsParentView hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText {
    return [self showSucceed:text detailText:detailText inView:GGDefaultTipsParentView hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showSucceed:(NSString *)text inView:(UIView *)view {
    return [self showSucceed:text detailText:nil inView:view hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showSucceed:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showSucceed:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (GGTips *)showSucceed:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showSucceed:text detailText:detailText inView:view hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showSucceed:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    GGTips *tips = [self createTipsToView:view];
    [tips showSucceed:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (GGTips *)showError:(nullable NSString *)text {
    return [self showError:text detailText:nil inView:GGDefaultTipsParentView hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText {
    return [self showError:text detailText:detailText inView:GGDefaultTipsParentView hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showError:(NSString *)text inView:(UIView *)view {
    return [self showError:text detailText:nil inView:view hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showError:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showError:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (GGTips *)showError:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showError:text detailText:detailText inView:view hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showError:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    GGTips *tips = [self createTipsToView:view];
    [tips showError:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (GGTips *)showInfo:(nullable NSString *)text {
    return [self showInfo:text detailText:nil inView:GGDefaultTipsParentView hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText {
    return [self showInfo:text detailText:detailText inView:GGDefaultTipsParentView hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showInfo:(NSString *)text inView:(UIView *)view {
    return [self showInfo:text detailText:nil inView:view hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showInfo:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showInfo:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (GGTips *)showInfo:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showInfo:text detailText:detailText inView:view hideAfterDelay:GGTipsAutomaticallyHideToastSeconds];
}

+ (GGTips *)showInfo:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    GGTips *tips = [self createTipsToView:view];
    [tips showInfo:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (GGTips *)createTipsToView:(UIView *)view {
    GGTips *tips = [[GGTips alloc] initWithView:view];
    [view addSubview:tips];
    tips.removeFromSuperViewWhenHide = YES;
    return tips;
}

+ (void)hideAllTipsInView:(UIView *)view {
    [self hideAllToastInView:view animated:NO];
}

+ (void)hideAllTips {
    [self hideAllToastInView:nil animated:NO];
}

#pragma mark ------------------------- set / get -------------------------
- (UIImage *)loadingImage {
    if (!_loadingImage) {
        // 获取main bundle
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        // 放在app mainBundle中的自定义Test.bundle
        NSString *path = [mainBundle pathForResource:GGTipsLoadingGIFName ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage sd_imageWithGIFData:data];
        
        _loadingImage = image;
    }
    
    return _loadingImage;
}

- (UIImageView *)loadingImageView {
    if (!_loadingImageView) {
        _loadingImageView = [UIImageView new];
        _loadingImageView.clipsToBounds = YES;
        _loadingImageView.contentMode = UIViewContentModeScaleAspectFit;
        _loadingImageView.qmui_size = CGSizeMake(52.f, 52.f);
    }
    
    return _loadingImageView;
}

- (LOTAnimationView *)loadingAnimationView {
    if (!_loadingAnimationView) {
        _loadingAnimationView = [LOTAnimationView animationNamed:@"json_loading1"];
        _loadingAnimationView.loopAnimation = YES;
        _loadingAnimationView.qmui_size = CGSizeMake(52.f, 52.f);
    }
    
    return _loadingAnimationView;
}

@end









