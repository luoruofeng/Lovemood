//
//  BaseModelController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-13.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseDataViewController;

@interface BaseModelController : NSObject <UIPageViewControllerDataSource>

- (BaseDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(BaseDataViewController *)viewController;

@end
