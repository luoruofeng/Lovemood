//
//  ItemViewController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-15.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemViewController : UIViewController

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;

-(IBAction)cancel:(id)sender;

@end
