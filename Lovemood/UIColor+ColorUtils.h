//
//  UIColor+ColorUtils.h
//  MyDebt
//
//  Created by 罗若峰 on 13-6-29.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorUtils)

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;

+ (UIColor *)colorWithString:(NSString *)string;
- (UIColor *)initWithString:(NSString *)string;
- (UIColor *)initWithRGBValue:(int32_t)rgb;
- (UIColor *)initWithRGBAValue:(uint32_t)rgba;

- (int32_t)RGBValue;
- (uint32_t)RGBAValue;
- (NSString *)stringValue;

- (BOOL)isMonochromeOrRGB;
- (BOOL)isEquivalent:(id)object;
- (BOOL)isEquivalentToColor:(UIColor *)color;

@end
