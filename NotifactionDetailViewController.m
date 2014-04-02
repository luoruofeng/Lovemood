//
//  NotifactionDetailViewController.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-18.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "NotifactionDetailViewController.h"


@interface NotifactionDetailViewController ()

@end

@implementation NotifactionDetailViewController

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
    self.navigationItem.title = _name;
    
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *path = [[NSBundle mainBundle] pathForResource:_name ofType:@"txt"];
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:encode error:&error];
    if(content == nil)
    {
         NSLog(@"We got an error, as expected; it says:\n\"%@\"", [error localizedDescription]);
    }
    [_textView setText:content];
    [_textView setEditable:NO];
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

@end
