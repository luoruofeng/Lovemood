//
//  NSDate+DateUtil.h
//  MyDebt
//
//  Created by 罗若峰 on 13-8-8.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateUtil)
+ (NSDate*)dateWithString:(NSString*)str format:(NSString*)formating;
+ (NSDate*)isoDateFromString:(NSString*)str;
+ (NSString*)toStringWithDate:(NSDate*)date format:(NSString*)formating;
@end
