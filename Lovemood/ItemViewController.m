//
//  ItemViewController.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-15.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "ItemViewController.h"

@interface ItemViewController ()
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;
@end

@implementation ItemViewController

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
    self.navigationItem.title = [NSString stringWithFormat:@"%@礼物", _name,nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showWebBrowser"])
    {
        NSString *urlString = [[ConfigUtil shareConfigUtil] getValueWithKey:((UIButton *)sender).titleLabel.text];
        NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *URL = [NSURL URLWithString:webStringURL];
        
        DZWebBrowser *destinationVC = (DZWebBrowser *)segue.destinationViewController;
        destinationVC.currentURL = URL;
        destinationVC.showProgress = YES;
        destinationVC.allowSharing = YES;
    }
}

-(IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
