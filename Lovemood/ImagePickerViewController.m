//
//  ImagePickerViewController.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-21.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "ImagePickerViewController.h"
#import "EditPageViewController.h"

@interface ImagePickerViewController ()

@end

@implementation ImagePickerViewController
UIImagePickerController *imagePickerController;
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
	// Do any additional setup after loading the view.
    [self pickImage:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --- image picker
// Update image and for iPhone, dismiss the controller
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];

    [self.delegate selectedImageFinish:image];
    
    [imagePickerController dismissViewControllerAnimated:YES completion:^(){}];
    [self.navigationController popViewControllerAnimated:YES];
}

// Dismiss picker
- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [imagePickerController dismissViewControllerAnimated:YES completion:^(){}];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) pickImage: (id) sender
{
	// Create an initialize the picker
	imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePickerController setAllowsEditing:NO];
	[imagePickerController setDelegate:self];
    [self presentViewController:imagePickerController animated:NO completion:^(){}];
}


@end
