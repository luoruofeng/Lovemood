//
//  EditPageViewController.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-21.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "EditPageViewController.h"
#import "ImagePickerViewController.h"
#import "Article.h"
#import "CameraViewController.h"

@interface EditPageViewController ()
@property (nonatomic, retain) UIImage *placeHoderImage;
@property (nonatomic, retain) UIActionSheet *imageActionSheet;
@property (nonatomic, assign) NSInteger numberOfImage;
@property (nonatomic, retain) UIView *accessoryView;
@property (nonatomic, retain) NSString *oldImage;
@property (nonatomic, retain) NSString *oldImage2;
@property (nonatomic, retain) NSString *oldImage3;

//当前页面存储相片

@property (nonatomic, retain) UIImage *image2;
@property (nonatomic, retain) UIImage *image3;


@end

@implementation EditPageViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    [self.textview.layer setCornerRadius:14];
    [self.textview.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.textview.layer setBorderWidth:1.5];
    
    self.placeHoderImage =[UIImage imageNamed:@"addImage"];
    
    if(self.updateArticle != nil && self.updateArticle.text != nil)
    {
        [self.textview setText:self.updateArticle.text];
        [self.placeHoderLabel setHidden:YES];
    }
    
    if(self.updateArticle != nil && self.updateArticle.image != nil  && ![self.updateArticle.image isEqualToString:@""])
    {
        self.oldImage = self.updateArticle.image;
    }
    if(self.updateArticle != nil && self.updateArticle.image2 != nil  && ![self.updateArticle.image2 isEqualToString:@""])
    {
        self.oldImage2 = self.updateArticle.image2;
    }
    if(self.updateArticle != nil && self.updateArticle.image3 != nil  && ![self.updateArticle.image3 isEqualToString:@""])
    {
        self.oldImage3 = self.updateArticle.image3;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    [self.textview becomeFirstResponder];

    if(self.imageView.image == nil)
    {
        if(self.updateArticle != nil && self.updateArticle.image != nil)
        {
            NSData *imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:self.updateArticle.image] stringByAppendingPathExtension:@"png"]];
            UIImage *image = [UIImage imageWithData:imageData];
            [self.imageView setImage:image];
            self.image = image;
        }
        else
        {
            [self.imageView setImage:self.placeHoderImage];
        }
    }
    if(self.imageView2.image == nil)
    {
        if(self.updateArticle != nil && self.updateArticle.image2 != nil)
        {
            NSData *imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:self.updateArticle.image2] stringByAppendingPathExtension:@"png"]];
            UIImage *image = [UIImage imageWithData:imageData];
            [self.imageView2 setImage:image];
            self.image2 = image;
        }
        else
        {
            [self.imageView2 setImage:self.placeHoderImage];
        }
    }
    if(self.imageView3.image == nil)
    {
        if(self.updateArticle != nil && self.updateArticle.image3 != nil)
        {
            NSData *imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:self.updateArticle.image3] stringByAppendingPathExtension:@"png"]];
            UIImage *image = [UIImage imageWithData:imageData];
            [self.imageView3 setImage:image];
            self.image3 = image;
        }
        else
        {
            [self.imageView3 setImage:self.placeHoderImage];
        }
    }
    
    if(self.accessoryView == nil)
    {
//        self.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//        self.accessoryView.layer.borderColor = [UIColor blackColor].CGColor;
//        self.accessoryView.layer.borderWidth = 1.5;
//        self.accessoryView.backgroundColor = [UIColor whiteColor];
        
//        UIButton *pengyouquan = [UIButton buttonWithType:UIButtonTypeCustom];
//        [pengyouquan addTarget:self action:@selector(pengyouquan) forControlEvents:UIControlEventTouchUpInside];
//        [pengyouquan setTitle:@"朋友圈" forState:UIControlStateNormal];
//        [pengyouquan setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//        [pengyouquan setTitleColor:[UIColor colorWithString:PINK_COLOR] forState:UIControlStateNormal];
//        
//        [pengyouquan setFrame:CGRectMake(0, 0, 100, 40)];
//        
//        [self.accessoryView addSubview:pengyouquan];
//
//        UIButton *weixin = [UIButton buttonWithType:UIButtonTypeCustom];
//        [weixin addTarget:self action:@selector(weixin) forControlEvents:UIControlEventTouchUpInside];
//        [weixin setTitle:@"微信好友" forState:UIControlStateNormal];
//        [weixin setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//        [weixin setTitleColor:[UIColor colorWithString:PINK_COLOR] forState:UIControlStateNormal];
//        [weixin setFrame:CGRectMake((SCREEN_WIDTH-100)/2, 0, 100, 40)];
//
//        [self.accessoryView addSubview:weixin];
        
        
//        UIButton *done = [UIButton buttonWithType:UIButtonTypeCustom];
//        [done addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
//        [done setTitle:@"完成" forState:UIControlStateNormal];
//        [done setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//        [done setTitleColor:[UIColor colorWithString:PINK_COLOR] forState:UIControlStateNormal];
//        [done setFrame:CGRectMake(SCREEN_WIDTH-100, 0, 100, 40)];
//        
//        [self.accessoryView addSubview:done];
//        
//        self.textview.inputAccessoryView = self.accessoryView;
    }
}

#pragma mark - Responding to keyboard events

- (void)textChanged:(NSNotification *)notification
{
    
    if([self.textview.text length] == 0)
    {
        [self.placeHoderLabel setHidden:NO];
    }
    else
    {
        [self.placeHoderLabel setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---  button
- (IBAction)tapImage:(id)sender
{
    if(self.imageView.image != self.placeHoderImage)
    {
        return;
    }
    self.numberOfImage = 1;
    [self showActionSheet];
}

- (IBAction)tapImage2:(id)sender
{
    if(self.imageView2.image != self.placeHoderImage)
    {
        return;
    }

    self.numberOfImage = 2;
    
    [self showActionSheet];
}

- (IBAction)tapImage3:(id)sender
{
    if(self.imageView3.image != self.placeHoderImage)
    {
        return;
    }
    
    self.numberOfImage = 3;
    
    [self showActionSheet];
}

- (IBAction)deleteImage:(id)sender
{
    [self.imageView setImage:self.placeHoderImage];
    self.image = nil;
}

- (IBAction)deleteImage2:(id)sender
{
    [self.imageView2 setImage:self.placeHoderImage];
    self.image2 = nil;
}

- (IBAction)deleteImage3:(id)sender
{
    [self.imageView3 setImage:self.placeHoderImage];
    self.image3 = nil;
}

- (void)showActionSheet
{
    if(self.imageActionSheet == nil)
    {
        self.imageActionSheet = [[UIActionSheet alloc] initWithTitle:@"增加照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相",@"从相册选取", nil];
    }
    [self.imageActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark ----  action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet == self.imageActionSheet)
    {
        if(buttonIndex == 0)
        {
            [self.textview resignFirstResponder];
            CameraViewController *cameraViewController = [[CameraViewController alloc] init];
            cameraViewController.delegate = self;
            [self.navigationController pushViewController:cameraViewController animated:YES];
            
        }
        else if(buttonIndex == 1)
        {
            ImagePickerViewController *imagePicker = [[ImagePickerViewController alloc] init];
            imagePicker.delegate = self;
            [self.navigationController pushViewController:imagePicker animated:YES];
        }
    }
}

#pragma mark image pick delegate
-(void)selectedImageFinish:(UIImage *)image
{
    if(self.numberOfImage == 1)
    {
        [self.imageView setImage:image];
        self.image = image;
    }
    else if(self.numberOfImage == 2)
    {
        [self.imageView2 setImage:image];
        self.image2 = image;
    }
    else if(self.numberOfImage == 3)
    {
        [self.imageView3 setImage:image];
        self.image3 = image;
    }
    
}

#pragma mark ---- 按钮
- (void)pengyouquan
{

}

- (void)weixin
{
    
}

- (IBAction)done:(id)sender
{
    [self addObjectWithImage:self.image withImage2:self.image2 withImage3:self.image3 withText:self.textview.text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---- core data
- (Article *) addObjectWithImage:(UIImage *)image withImage2:(UIImage *)image2 withImage3:(UIImage *)image3 withText:(NSString *)text
{
    
    if(image == nil && image2 == nil && image3 == nil && (text == nil  || [text isEqualToString:@""]))
    {
        
        return nil;
    }
    
    NSString *filename = nil;
    NSString *filename2 = nil;
    NSString *filename3 = nil;
    
    if(image)
    {
        filename = [self saveImage:image];
    }
    if(image2)
    {
        filename2 = [self saveImage:image2];
    }
    if(image3)
    {
        filename3 = [self saveImage:image3];
    }
    
    Article *article = nil;
    if(self.updateArticle == nil)
    {
        article = (Article *)[NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:self.context];
        [article setImage:filename];
        [article setImage2:filename2];
        [article setImage3:filename3];
        [article setTime:[NSDate date]];
        [article setText:text];
    }
    else
    {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        if(self.oldImage)
        {
            [fileMgr removeItemAtPath:[[documentsDirectory stringByAppendingPathComponent:self.oldImage] stringByAppendingPathExtension:@"png"] error:nil];
        }
        if(self.oldImage2)
        {
            [fileMgr removeItemAtPath:[[documentsDirectory stringByAppendingPathComponent:self.oldImage2] stringByAppendingPathExtension:@"png"] error:nil];
        }
        if(self.oldImage3)
        {
            [fileMgr removeItemAtPath:[[documentsDirectory stringByAppendingPathComponent:self.oldImage3] stringByAppendingPathExtension:@"png"] error:nil];
        }
        
        article = self.updateArticle;
        [article setImage:filename];
        [article setImage2:filename2];
        [article setImage3:filename3];
        [article setTime:article.time];
        [article setText:text];
    }
    
    // Save the data
	NSError *error;
	if (![self.context save:&error])
    {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    else
    {
        return article;
    }
    return  nil;
}

- (NSString *)saveImage:(UIImage *)image
{
    //create name
    NSString *filename = [NSString stringWithFormat:@"%ld", (long)[NSDate date]];
    NSString *savename = [NSString stringWithFormat:@"Documents/%@.png", filename];
    // Create paths to output images
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:savename];
    // Write image to PNG
    
    [UIImagePNGRepresentation([self scaleAndRotateImage:image]) writeToFile:pngPath atomically:YES];
    
    return filename;
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

@end
