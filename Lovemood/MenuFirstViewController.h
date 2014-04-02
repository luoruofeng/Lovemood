//
//  MenuViewController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-13.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuFirstViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *notifactionButton;
@property (nonatomic, strong) IBOutlet UIButton *itemButton;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;

- (IBAction)showItem:(id)sender;
- (IBAction)showNotification:(id)sender;

@end
