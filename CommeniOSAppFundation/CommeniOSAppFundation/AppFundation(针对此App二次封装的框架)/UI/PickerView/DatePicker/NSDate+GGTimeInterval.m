//
//  NSDate+GGTimeInterval.m
//  CXGLNewStudentApp
//
//  Created by GG on 2024/2/2.
//

#import "NSDate+GGTimeInterval.h"

@implementation NSDate (GGTimeInterval)

+ (instancetype)dateWithDate:(NSDate *)date {
    NSDate *cDate = [NSDate dateWithTimeIntervalSince1970:date.timeIntervalSince1970];
    
    return cDate;
}

@end
