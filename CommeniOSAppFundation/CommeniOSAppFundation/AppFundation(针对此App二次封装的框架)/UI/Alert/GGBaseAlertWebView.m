//
//  GGBaseAlertWebView.m
//  ChangXiangGrain
//
//  Created by GG on 2023/6/14.
//  Copyright © 2023 ChangXiangCloud. All rights reserved.
//

#import "GGBaseAlertWebView.h"

#import "GGBaseWebViewController.h"

//#import "CXGWebModuleManager.h"

/// 整个背景view宽度
#define GGBaseAlertWebViewContainerWidth (SCREEN_WIDTH - 20.f * 2)

/// webView 宽度
#define GGBaseAlertWebViewWebViewWidth (GGBaseAlertWebViewContainerWidth - 20.f * 2)

/// webView 高度
#define GGBaseAlertWebViewWebViewHeight Scale(GGBaseAlertWebViewWebViewWidth, 250.f, 295.f)

/// 整个背景view高度
#define GGBaseAlertWebViewContainerHeight (GGBaseAlertWebViewWebViewHeight + 65.f * 2)

@interface GGBaseAlertWebView ()

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, strong) NSArray *bottomButtonTitleArray;

@property (nonatomic, strong) NSArray *bottomButtonTitleColorArray;

@property (nonatomic, strong) UIViewController *webController;

@property (nonatomic, strong) NSMutableArray<UIButton *> *bottomButtonsArray;
@property (nonatomic, strong) QMUIGridView *bottomButtonsGridView;

@property (nonatomic, copy) GGBaseAlertWebViewBottomButtonClickBlock bottomButtonClickBlock;

@property (nonatomic, assign) NSInteger dismissButtonTag;

@property (nonatomic, assign) BOOL needCloseButton;

@property (nonatomic, weak) UIView *alertInView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GGBaseAlertWebView

#pragma mark ------------------------- Cycle -------------------------
- (void)dealloc {
    NSLog(@"\n\n\n----------------%@释放了----------------\n\n\n", NSStringFromClass([self class]));
}

#pragma mark ------------------------- Interface -------------------------
+ (instancetype)alertViewWithTitle:(NSString *)title
                              link:(NSString *)link
                   needCloseButton:(BOOL)needCloseButton
                        leftCancelButtonTitle:(NSString *)leftCancelButtonTitle
                          rightDownButtonTitle:(NSString *)rightDownButtonTitle
                                        inView:(UIView *)view
                             block:(GGBaseAlertWebViewBottomButtonClickBlock)block {
    NSMutableArray *marr_title = @[].mutableCopy;
    
    if (leftCancelButtonTitle) {
        [marr_title addObject:leftCancelButtonTitle];
    }
    
    if (rightDownButtonTitle) {
        [marr_title addObject:rightDownButtonTitle];
    }
    
    NSMutableArray *marr_color = @[].mutableCopy;
    
    if (leftCancelButtonTitle) {
        [marr_color addObject:[UIColorMakeWithHex(@"#000000") colorWithAlphaComponent:0.6]];
    }
    
    if (rightDownButtonTitle) {
        [marr_color addObject:UIColor.qd_tintColor];
    }
    
    GGBaseAlertWebView *webView = [[GGBaseAlertWebView alloc] init];
    
    webView.title = title;
    webView.link = link;
    webView.bottomButtonTitleArray = marr_title;
    webView.bottomButtonTitleColorArray = marr_color;
    webView.bottomButtonClickBlock = block;
    webView.dismissButtonTag = 0;
    webView.needCloseButton = needCloseButton;
    webView.alertInView = view;
    
    webView.bottomButtonsArray = @[].mutableCopy;
    
    [webView configContentView];
    
    [webView showInView:view completion:nil];
    
    return webView;
}

#pragma mark ------------------------- UI -------------------------
- (void)configContentView {
    UIView *view = self;
//    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, GGBaseAlertWebViewContainerWidth, GGBaseAlertWebViewContainerHeight);
    view.backgroundColor = UIColorWhite;
    view.layer.cornerRadius = 8;
    
    if (_needCloseButton) {
        CGSize buttonSize = CGSizeMake(50, 50);
        
        UIButton *button = [UIButton ba_buttonWithFrame:CGRectZero title:nil titleColor:nil titleFont:nil image:UIImageMake(@"closeComment") backgroundColor:nil];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(view);
            make.size.mas_equalTo(buttonSize);
        }];
        @ggweakify(self)
        button.qmui_tapBlock = ^(__kindof UIControl *sender) {
            @ggstrongify(self)
            [self closeButtonClick];
        };
    }
    
    /// 标题
    CGFloat spaceH_titleLabel = self.needCloseButton ? (50.f + 6.f) : 20.f;
    _titleLabel = [UILabel labelWithSuperView:view withContent:_title withBackgroundColor:nil withTextColor:[UIColorMakeWithHex(@"#000000") colorWithAlphaComponent:0.8] withFont:UIFontMediumMake(16)];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(view);
        make.top.equalTo(view);
        make.left.mas_equalTo(spaceH_titleLabel);
        make.right.mas_equalTo(- spaceH_titleLabel);
        make.height.mas_equalTo(65.f);
    }];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    
//    UIView *lineView = [UIView new];
//    [view addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleLabel.mas_bottom);
//        make.left.right.equalTo(view);
//        make.height.mas_equalTo(1.f);
//    }];
//    lineView.backgroundColor = UIColorSeparator;
    
    /// webView
    if ([_link hasPrefix:@"http"]) {
        // 链接
#warning -gg 完善
        _webController = [[GGBaseWebViewController alloc] initWithURLString:NSStringTransformEmpty(_link)];
        _webController.title = NSStringTransformEmpty(_title);
//        _webController = [MGJRouter gg_objectForURL:URL_GetANewWebPage withUserInfo:@{
//            @"title": NSStringTransformEmpty(_title),
//            @"url": NSStringTransformEmpty(_link),
//            @"hideNavigationBar": @(YES),
//        }];
    } else {
        // 标签
#warning -gg 完善
        _webController = [[GGBaseWebViewController alloc] initWithHTMLString:NSStringTransformEmpty(_link)];
        _webController.title = NSStringTransformEmpty(_title);
//        _webController = [MGJRouter gg_objectForURL:URL_GetANewWebPage withUserInfo:@{
//            @"title": NSStringTransformEmpty(_title),
////            @"url": NSStringTransformEmpty(_link),
//            @"hideNavigationBar": @(YES),
//            @"HTMLString": NSStringTransformEmpty(_link),
//        }];
    }
    [self addSubview:_webController.view];
    _webController.view.frame = CGRectMake(20.f, 65.f, GGBaseAlertWebViewWebViewWidth, GGBaseAlertWebViewWebViewHeight);
//    [_webController.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(65.f, 20.f, 65.f, 20.f));
//    }];
    _webController.view.backgroundColor = UIColorMakeWithHex(@"#F7F8FB");
    _webController.view.layer.cornerRadius = 4.f;
    _webController.view.layer.borderColor = UIColorSeparator.CGColor;
    _webController.view.layer.borderWidth = 1.f;
    _webController.view.clipsToBounds = YES;
    
    /// 底部按钮
    UIView *lastView = _webController.view;
    CGFloat bottomButtonTopSpace = 12.5f;
    
    if (_bottomButtonTitleArray.count > 1) {
        UIView *topView = lastView;
        
        CGFloat topSpace = bottomButtonTopSpace;
        
        _bottomButtonsGridView = [[QMUIGridView alloc] initWithColumn:_bottomButtonTitleArray.count rowHeight:40.f];
        [view addSubview:_bottomButtonsGridView];
        [_bottomButtonsGridView mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([lastView isEqual:view]) {
                make.top.mas_equalTo(topSpace);
            } else {
                make.top.equalTo(topView.mas_bottom).mas_equalTo(topSpace);
            }
            make.left.right.equalTo(view);
            make.height.mas_equalTo(40.f);
        }];
        
        lastView = _bottomButtonsGridView;
        
//        CGSize bottomButtonSize = CGSizeMake(view.width / _bottomButtonTitleArray.count, 48.0);
        
        NSString *btnTitle = nil;
        
        UIColor *btnTitleColor = nil;
        
        for (NSInteger i = 0; i < _bottomButtonTitleArray.count; i++) {
            btnTitle = [_bottomButtonTitleArray gg_safeObjectAtIndex:i];
            btnTitleColor = [_bottomButtonTitleColorArray gg_safeObjectAtIndex:i];
            
//            CGRectMake(bottomButtonSize.width * i, 0, bottomButtonSize.width, bottomButtonSize.height)
            
            QMUIButton *button = [QMUIButton gg_buttonWithFrame:CGRectZero title:btnTitle titleColor:btnTitleColor titleFont:UIFontMake(16) image:nil backgroundColor:[UIColorMakeWithHex(@"#000000") colorWithAlphaComponent:0.02]];
            [_bottomButtonsGridView addSubview:button];
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(topView.mas_bottom).mas_equalTo(topSpace);
//                make.left.mas_equalTo(button.frame.origin.x);
//                make.size.mas_equalTo(button.size);
//            }];
            
            [self.bottomButtonsArray addObject:button];
            
            button.tag = 1000 + i;
            
            @weakify(self)
            button.qmui_tapBlock = ^(__kindof UIButton *sender) {
                @strongify(self)
                [self bottomButtonClick:sender];
            };
            
//            if (i == 0) {
//                lastView = button;
//            }
        }
    } else if (_bottomButtonTitleArray.count == 1) {
        NSString *btnTitle = _bottomButtonTitleArray.firstObject;
        UIColor *btnTitleColor = UIColorForBackground;
        UIColor *btnBackGroundColor = UIColor.qd_tintColor;
        
        QMUIButton *button = [QMUIButton gg_buttonWithFrame:CGRectZero title:btnTitle titleColor:btnTitleColor titleFont:UIFontMake(16) image:nil backgroundColor:btnBackGroundColor];
        [view addSubview:button];
        button.cornerRadius = 20.f;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView.mas_bottom).mas_equalTo(bottomButtonTopSpace);
            make.left.right.equalTo(self.webController.view);
            make.height.mas_equalTo(40.f);
        }];
        
        [self.bottomButtonsArray addObject:button];
        
        lastView = button;
        
        button.tag = 1000;
        
        @weakify(self)
        button.qmui_tapBlock = ^(__kindof UIButton *sender) {
            @strongify(self)
            [self bottomButtonClick:sender];
        };
    }
    
    [view layoutIfNeeded];
    
    /// 计算排版后总高度
    if (self.bottomButtonsArray.count) {
        /// 底部有按钮
        view.qmui_height = lastView.qmui_bottom;
    } else {
        /// 底部没有按钮
        view.qmui_height = lastView.qmui_bottom + 17.f;
    }
}

#pragma mark ------------------------- Actions -------------------------
#pragma mark --- 点击关闭按钮回调
- (void)closeButtonClick {
    [self dismissView];
}

#pragma mark --- 底部按钮点击回调
- (void)bottomButtonClick:(UIButton *)button {
    BOOL autoHideAlertView = (button.tag - 1000 == _dismissButtonTag) && (_dismissButtonTag >= 0) && (_dismissButtonTag < _bottomButtonsArray.count);
    
    if (autoHideAlertView) {
        [self dismissView];
    }
    
    if (_bottomButtonClickBlock) {
        __weak typeof(self) weakSelf = self;
        _bottomButtonClickBlock(button.tag - 1000, weakSelf);
    }
}

@end
