//
//  ConfigUtil.m
//  Suitcase
//
//  Created by 罗若峰 on 13-11-8.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "ConfigUtil.h"

@implementation ConfigUtil

static ConfigUtil *configUtil = nil;
static NSMutableDictionary *dict = nil;
static NSString *FILE_PATH = nil;
#define FILE_NAME @"Websites"

+ (id)shareConfigUtil
{
    @synchronized(self)
    {
        if(!configUtil)
        {
            configUtil = [[ConfigUtil alloc] init];
        }
        return configUtil;
    }
}

- (void)createDict
{
    if(!dict)
    {
        FILE_PATH = [[NSBundle mainBundle] pathForResource:FILE_NAME ofType:@"plist"];
        BOOL isDocumentFileExists = [[NSFileManager defaultManager] fileExistsAtPath:FILE_PATH];
        
        if (!isDocumentFileExists) {
            NSString *file = [[NSBundle mainBundle] pathForResource:FILE_NAME ofType:@"plist"];
            NSError *error;
            [[NSFileManager defaultManager] copyItemAtPath:file toPath:FILE_PATH error:&error];
        }
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:FILE_PATH];
    }
}

- (NSString *)getValueWithKey:(NSString *)key
{
    [self createDict];
    return (NSString *)[dict objectForKey:key];
}

@end
