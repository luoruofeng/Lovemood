//
//  ConfigUtil.h
//  Suitcase
//
//  Created by 罗若峰 on 13-11-8.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigUtil : NSObject

+ (id)shareConfigUtil;
- (void)createDict;
- (NSString *)getValueWithKey:(NSString *)key;

@end
