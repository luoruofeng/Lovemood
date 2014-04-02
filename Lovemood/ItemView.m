//
//  ItemView.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-25.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLabel:)];
        pan.delegate = self;
        
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void) moveLabel: (UIPanGestureRecognizer *)gestureRecognizer{
    
    switch ([gestureRecognizer state]) {
        case UIGestureRecognizerStateBegan:
            [self panBegan:gestureRecognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self panMoved:gestureRecognizer];
            break;
        case UIGestureRecognizerStateEnded:
            [self panEnded:gestureRecognizer];
            break;
        default:
            break;
    }
}

- (void)panBegan: (UIPanGestureRecognizer *)gestureRecognizer
{
    self.centerInfScroll = [self center];
    
}


- (void)panMoved: (UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer translationInView:self.scroll];
    
    float newX = gestureRecognizer.view.center.x + point.x;
    
    gestureRecognizer.view.center = CGPointMake(newX,self.centerInfScroll.y);
    [gestureRecognizer setTranslation:CGPointZero inView:self.scroll];
    
    [self setAlpha:(SCREEN_WIDTH/2)/newX];
}


- (void)panEnded: (UIPanGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.view.center.x <= SCREEN_WIDTH*0.0)
    {
        [UIView animateWithDuration:0.2 animations:^(){
            gestureRecognizer.view.center = self.centerInfScroll;
            [gestureRecognizer setTranslation:CGPointZero inView:self.scroll];
            [self setAlpha:1];
        } completion:^(BOOL done){
            
        }];

        [self.delegate itemViewToLeftWithArticle:self.article];
    }
    else if (gestureRecognizer.view.center.x >= SCREEN_WIDTH*1)
    {
        [self.delegate itemViewToRightWithArticle:self.article  withCurrentHeight:self.currentHeight];
        [self removeFromSuperview];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^(){
            gestureRecognizer.view.center = self.centerInfScroll;
            [gestureRecognizer setTranslation:CGPointZero inView:self.scroll];
            [self setAlpha:1];
        } completion:^(BOOL done){
            
        }];
    }
}

bool isVertical = true;

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
		return YES;
	
	CGPoint translation = [(UIPanGestureRecognizer*)gestureRecognizer translationInView:self];
    isVertical = fabs(translation.y) > fabs(translation.x);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return isVertical;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
