//
//  ItemView.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-25.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@protocol ItemViewDelegate <NSObject>

- (void)itemViewToRightWithArticle:(Article *)article withCurrentHeight:(NSInteger) height;
- (void)itemViewToLeftWithArticle:(Article *)article;

@end

@interface ItemView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger currentHeight;

@property (nonatomic,assign) id<ItemViewDelegate> delegate;
@property (nonatomic,retain) Article *article;
@property (nonatomic,assign) CGPoint centerInfScroll;
@property (nonatomic,assign) UIScrollView *scroll;
@end