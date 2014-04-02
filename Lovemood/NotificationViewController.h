//
//  NotificationViewController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-18.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, strong) IBOutlet UIScrollView *scroll;

-(IBAction)cancel:(id)sender;
@end
