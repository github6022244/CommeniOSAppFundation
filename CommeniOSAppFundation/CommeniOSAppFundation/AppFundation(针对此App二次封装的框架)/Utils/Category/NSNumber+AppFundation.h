//
//  NSNumber+AppFundation.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (AppFundation)

/// 转换为价格 string
- (NSString *)formatPriceString;

+ (NSString *)formatPriceString:(NSNumber *)number;

/// 数字转汉字
- (NSString *)transformHanString;

@end

NS_ASSUME_NONNULL_END
