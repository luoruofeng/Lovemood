//
//  EditPageViewController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-21.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickerViewController.h"
#import "Article.h"


@interface EditPageViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate,ImagePickerViewControllerDelegate>


@property (nonatomic,strong) IBOutlet UIImage *image;
@property (nonatomic,strong) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) IBOutlet UIButton *addImageButton;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2;
@property (nonatomic,strong) IBOutlet UIButton *addImageButton2;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3;
@property (nonatomic,strong) IBOutlet UIButton *addImageButton3;
@property (nonatomic,strong) IBOutlet UITextView *textview;
@property (nonatomic,strong) IBOutlet UILabel *placeHoderLabel;
@property (nonatomic,strong) Article *updateArticle;
@property (nonatomic,strong) IBOutlet UIButton *deleteButton;
@property (nonatomic,strong) IBOutlet UIButton *deleteButton2;
@property (nonatomic,strong) IBOutlet UIButton *deleteButton3;


@property (nonatomic, retain) NSManagedObjectContext *context;

@end
