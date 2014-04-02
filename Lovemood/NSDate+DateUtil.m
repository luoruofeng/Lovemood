//
//  NSDate+DateUtil.m
//  MyDebt
//
//  Created by 罗若峰 on 13-8-8.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "NSDate+DateUtil.h"

@implementation NSDate (DateUtil)

+ (NSDate*)dateWithString:(NSString*)str format:(NSString*)formating {
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:formating];
	NSDate* date = [dateFormatter dateFromString:str];

	return date;
}

+ (NSString*)toStringWithDate:(NSDate*)date format:(NSString*)formating {
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:formating];
	return[dateFormatter stringFromDate:date];
}



+ (NSDate*)isoDateFromString:(NSString*)str {
	static NSDateFormatter* kISODateFormatter;
	if(!kISODateFormatter)
		kISODateFormatter = [[NSDateFormatter alloc] init];
	return [kISODateFormatter dateFromString:str];
}
@end
