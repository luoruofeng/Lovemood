//
//  MenuViewController.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-13.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "MenuFirstViewController.h"
#import "ItemViewController.h"
#import "NotificationViewController.h"

@interface MenuFirstViewController ()

@end

@implementation MenuFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#define beginContentOffsetX 80
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navItem.title = _name;
    
    int cornerRadius = 14;

    [self.itemButton.layer setCornerRadius:cornerRadius];
    [self.notifactionButton.layer setCornerRadius:cornerRadius];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}




- (IBAction)showNotification:(id)sender
{
    UINavigationController *nav = self.navigationController;
    
    NSString *storyboardId = nil;
    
    if([_name isEqualToString:@"相识"])
    {
        storyboardId = @"FirstNotification";
    }
    else if([_name isEqualToString:@"相恋"])
    {
        storyboardId = @"SecondNotification";
    }
    else if([_name isEqualToString:@"婚姻"])
    {
        storyboardId = @"ThirdNotification";
    }
    else if([_name isEqualToString:@"婚礼"])
    {
        storyboardId = @"FourthNotification";
    }
    
    NotificationViewController *destinationVC = (NotificationViewController *)[self.storyboard instantiateViewControllerWithIdentifier:storyboardId];
    destinationVC.name = _name;
    [nav pushViewController:destinationVC animated:YES];
}

- (IBAction)showItem:(id)sender
{
    UINavigationController *nav = self.navigationController;
    
    NSString *storyboardId = nil;
    
    if([_name isEqualToString:@"相识"])
    {
        storyboardId = @"ItemFirst";
    }
    else if([_name isEqualToString:@"相恋"])
    {
        storyboardId = @"ItemSecond";
    }
    else if([_name isEqualToString:@"婚姻"])
    {
        storyboardId = @"ItemThird";
    }
    else if([_name isEqualToString:@"婚礼"])
    {
        storyboardId = @"ItemFourth";
    }
    
    ItemViewController *destinationVC = (ItemViewController *)[self.storyboard instantiateViewControllerWithIdentifier:storyboardId];
    destinationVC.name = _name;
    [nav pushViewController:destinationVC animated:YES];
}

@end
