//
//  GTMBase64+AppFundation.m
//  CXGLNewStudentApp
//
//  Created by GG on 2023/2/2.
//

#import "GTMBase64+AppFundation.h"

@implementation GTMBase64 (AppFundation)

+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

@end
