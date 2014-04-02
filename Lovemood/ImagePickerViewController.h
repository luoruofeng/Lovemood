//
//  ImagePickerViewController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-21.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImagePickerViewControllerDelegate <NSObject>

@required
-(void)selectedImageFinish:(UIImage *)image;

@end

@interface ImagePickerViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) id<ImagePickerViewControllerDelegate> delegate;
@property (nonatomic, assign) NSInteger numberOfImage;

@end
