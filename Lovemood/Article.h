//
//  Article.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-22.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Article : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * image2;
@property (nonatomic, retain) NSString * image3;

@end
