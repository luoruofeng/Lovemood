//
//  NotifactionDetailViewController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-18.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifactionDetailViewController : UIViewController
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) UIBarButtonItem IBOutlet *cancelButton;
@property (nonatomic, strong) UITextView IBOutlet *textView;

@end
