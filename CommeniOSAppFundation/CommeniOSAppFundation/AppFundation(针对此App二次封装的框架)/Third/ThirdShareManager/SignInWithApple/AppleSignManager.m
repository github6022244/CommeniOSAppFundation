//
//  AppleSignManager.m
//  CXGrainStudentApp
//
//  Created by User on 2020/8/17.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import "AppleSignManager.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "UIWindow+GG.h"
#import <QMUIKit.h>

@interface AppleSignManager () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, copy) void(^getCompletionBlock)(BOOL isSuccess, NSString *message, NSString *userID);

@property (nonatomic, strong) QMUITips *tips;

@end

@implementation AppleSignManager

static AppleSignManager *instance = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[super allocWithZone:nil] init];
        }
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [AppleSignManager sharedManager];
}

- (void)signInWithAppleClickActionWithLoading:(BOOL)loading completionBlock:(void(^_Nullable)(BOOL isSuccess, NSString *message, NSString *userID))completionBlock API_AVAILABLE(ios(13.0)) {
    self.getCompletionBlock = completionBlock;
    
    if (loading) {
        [self.tips showLoading];
    }
    
    ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc] init];
    ASAuthorizationAppleIDRequest *request = [provider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    
    ASAuthorizationController *vc = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    vc.delegate = self;
    vc.presentationContextProvider = self;
    [vc performRequests];
}

- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    return [UIWindow getKeyWindow];
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    [self.tips hideAnimated:YES];
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        
        NSString *state = credential.state;
        NSString *userID = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        
        self.userID = userID;
        self.fullName = fullName;
        self.email = email;
        
//        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]; // refresh token
//        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding]; // access token
//        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
//
//        QMUILog(nil, @"state: %@", state);
//        QMUILog(nil, @"userID: %@", userID);
//        QMUILog(nil, @"fullName: %@", fullName);
//        QMUILog(nil, @"email: %@", email);
//        QMUILog(nil, @"authorizationCode: %@", authorizationCode);
//        QMUILog(nil, @"identityToken: %@", identityToken);
//        QMUILog(nil, @"realUserStatus: %@", @(realUserStatus));
        
        if (self.getCompletionBlock) {
            self.getCompletionBlock(YES, @"获取成功", userID);
        }
    } else {
        if (self.getCompletionBlock) {
            self.getCompletionBlock(NO, @"获取成功", @"");
        }
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    [self.tips hideAnimated:YES];
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
    }
//    [ProgressHUD showMessage:errorMsg];
    QMUILog(nil, @"%@", errorMsg);
    if (self.getCompletionBlock) {
        self.getCompletionBlock(NO, errorMsg, @"");
    }
}

- (QMUITips *)tips {
    if (!_tips) {
        _tips = [QMUITips createTipsToView:[UIWindow getKeyWindow]];
    }
    
    return _tips;
}

@end
