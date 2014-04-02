//
//  NotebookView.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-21.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "NotebookView.h"

@implementation NotebookView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGMutablePathRef path=CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 100, 0);
    CGPathAddLineToPoint(path, NULL, 100,SCREEN_HEIGHT);
    
    CGPathCloseSubpath(path);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path);
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.4);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithString:@"eeeeee"].CGColor);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
}


@end
