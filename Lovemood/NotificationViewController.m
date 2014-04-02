//
//  NotificationViewController.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-18.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotifactionDetailViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title =[NSString stringWithFormat:@"%@宝典", _name,nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowNotificationDetail"])
    {
        NotifactionDetailViewController *destinationVC = (NotifactionDetailViewController *)segue.destinationViewController;
        destinationVC.name = ((UIButton *)sender).titleLabel.text;
    }
}

@end
