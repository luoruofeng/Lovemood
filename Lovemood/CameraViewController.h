//
//  CameraViewController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-24.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickerViewController.h"

@interface CameraViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, assign) id<ImagePickerViewControllerDelegate> delegate;
@end
