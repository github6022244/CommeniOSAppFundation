//
//  GGTextFieldShareDelegate.h
//  RKZhiChengYun
//
//  Created by GG on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import "NSString+GGTextField.h"
#import "GGTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface GGTextFieldShareDelegate : NSObject<UITextFieldDelegate>

//+ (instancetype)share;

@property (nonatomic, assign) NSInteger maxCountLimit;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) GGTextFieldType ggType;

- (void)handleDelegateForTextField:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END
