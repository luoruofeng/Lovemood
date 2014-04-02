//
//  BaseDataViewController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-13.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) IBOutlet UIImageView *dataImage;

- (IBAction)viewTapped:(UIGestureRecognizer *)sender;

@end
