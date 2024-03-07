//
//  AppleSignManager.h
//  CXGrainStudentApp
//
//  Created by User on 2020/8/17.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleSignManager : NSObject

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, strong) NSPersonNameComponents *fullName;

@property (nonatomic, copy) NSString *email;


+ (instancetype)sharedManager;

- (void)signInWithAppleClickActionWithLoading:(BOOL)loading completionBlock:(void(^_Nullable)(BOOL isSuccess, NSString *message, NSString *userID))completionBlock;

@end

NS_ASSUME_NONNULL_END
