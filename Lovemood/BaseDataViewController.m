//
//  BaseDataViewController.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-13.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "BaseDataViewController.h"
#import "MenuFirstViewController.h"
#import "NotebookViewController.h"

@interface BaseDataViewController ()

@end

@implementation BaseDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
    [self.dataImage setImage:self.image];
}

#pragma mark - Misc

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"showMenu"])
//    {
//        MenuFirstViewController *destinationVC = (MenuFirstViewController *)segue.destinationViewController;
//        destinationVC.name = self.dataLabel.text;
//    }

    
}


- (IBAction)viewTapped:(UIGestureRecognizer *)sender
{

    if([self.dataLabel.text isEqualToString:@"笔记"])
    {
        
        
        UINavigationController *destinationVC = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"NotebookNav"];
        [self presentViewController:destinationVC animated:YES completion:^(){}];
    }
    else
    {
        UINavigationController *nav = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"menuNav"];
        
        MenuFirstViewController *destinationVC = (MenuFirstViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
        destinationVC.name = self.dataLabel.text;
        
        [nav setViewControllers:[NSArray arrayWithObject:destinationVC]];
        
        [self presentViewController:nav animated:YES completion:^(){}];
    }
}

@end
