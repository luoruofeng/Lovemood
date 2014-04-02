//
//  NotebookViewController.m
//  Lovemood
//
//  Created by 罗若峰 on 13-11-21.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import "NotebookViewController.h"
#import<CoreData/CoreData.h>
#import "Article.h"
#import "ImagePickerViewController.h"
#import "EditPageViewController.h"
#import "ItemView.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WeiboSDK.h"

@interface NotebookViewController ()
@property (nonatomic,strong) NSMutableArray *viewArray;
@property (nonatomic,strong) ItemView *parentView;
@property (nonatomic,strong) Article *operationArticle;
@property (nonatomic,strong) UIView *blockView;
@end

@implementation NotebookViewController

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
    [self initCoreData];
    
    
    self.blockView = [[UIView alloc] initWithFrame:SCREEN_FRAME];
    [self.blockView setBackgroundColor:[UIColor clearColor]];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(9, 9, 32.0f, 32.0f)];
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [activity startAnimating];
    [self.blockView addSubview:activity];
    [self.view addSubview:self.blockView];
    [self.blockView setUserInteractionEnabled:YES];
    [self.view bringSubviewToFront:self.blockView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    
    [self loadData];
    [self contentDisplay];
    [self.blockView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}

- (IBAction)add:(id)sender
{
    
    EditPageViewController *edit = (EditPageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"EditPageViewController"];
    edit.context = self.context;
    [self.navigationController pushViewController:edit animated:YES];
}

#pragma mark --- action sheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet == self.addActionSheet)
    {
        if(PENG_YOU_QUAN == buttonIndex)
        {
            [self sendTextContent:WXSceneTimeline];
        }
        else if(WEI_XIN == buttonIndex)
        {
            [self sendTextContent:WXSceneSession];
        }
        else if(WEI_XIN_SHOU_CHANG == buttonIndex)
        {
            [self sendTextContent:WXSceneFavorite];
        }
        else if(WEI_BO == buttonIndex)
        {
            //            [self ssoButtonPressed];
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
            request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                 @"Other_Info_1": [NSNumber numberWithInt:123],
                                 @"Other_Info_2": @[@"obj1", @"obj2"],
                                 @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
            //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
            
            [WeiboSDK sendRequest:request];
        }
        else if(buttonIndex == 4)
        {
            EditPageViewController *edit = (EditPageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"EditPageViewController"];
            edit.context = self.context;
            edit.updateArticle = self.operationArticle;
            [self.navigationController pushViewController:edit animated:YES];
        }
    }
}



#pragma mark --- core data

#define STOREPATH [NSHomeDirectory() stringByAppendingString:@"/Documents/Model.sqlite"]


- (void) initCoreData
{
    if(!self.context)
    {
        NSError *error;
        NSURL *url = [NSURL fileURLWithPath:STOREPATH];
        
        // Init the model, coordinator, context
        NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error])
            NSLog(@"Error: %@", [error localizedDescription]);
        else
        {
            self.context = [[NSManagedObjectContext alloc] init];
            [self.context setPersistentStoreCoordinator:persistentStoreCoordinator];
        }
    }
}

- (NSDate *) dateFromString: (NSString *) aString
{
	// Return a date from a string
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"yyyy-MM-dd HH:mm";
	NSDate *date = [formatter dateFromString:aString];
	return date;
}

- (Article *) addObjectWithArticle:(Article *) suitcase withImage:(NSString *)image withText:(NSString *)text
{
	Article *article = (Article *)[NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:self.context];
    [article setImage:image];
    [article setTime:[NSData data]];
    [article setText:text];

    // Save the data
	NSError *error;
	if (![self.context save:&error])
    {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    else
    {
        [self loadData];
        return article;
    }
    return  nil;
}

- (void) fetchArticleObjects
{
	// Create a basic fetch request
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Article" inManagedObjectContext:self.context]];
	
	// Add a sort descriptor
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO selector:nil];
    
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
	[fetchRequest setSortDescriptors:descriptors];

	// Init the fetched results controller
	NSError *error;
	self.articles = nil;
	self.articles = [NSMutableArray arrayWithArray:[self.context executeFetchRequest:fetchRequest error:&error]];
	if (!self.articles)
        NSLog(@"Error: %@", [error localizedDescription]);
}

- (void) removeObject:(Article *)article
{
    
	NSError *error = nil;
	[self.context deleteObject:article];
	// save
	if (![self.context save:&error]) NSLog(@"Error: %@ (%@)", [error localizedDescription], [error userInfo]);

}


#pragma mark ---- 加载数据
- (void)loadData
{
    [self fetchArticleObjects];
}


#pragma mark --- view display

#define ARTICLE_SPACE 20
#define ARTICLE_SMALL_SPACE 5
#define TEXT_LEFT 15
#define TEXT_WIDTH (SCREEN_WIDTH-100 - (TEXT_LEFT*2))
#define POINT_HEIGHT 20
#define TIME_HEIGHT 20
#define TIME_WIDTH 70
#define IMAGE_LEFT 15
#define IMAGE_WIDTH (SCREEN_WIDTH - 100 - (IMAGE_LEFT*2))

- (void)contentDisplay
{
    int lastArticleBottom = 20;
    
    for(UIView *view in [self.scroll subviews])
    {
        [view removeFromSuperview];
    }
    self.viewArray = [[NSMutableArray alloc] init];
    for(Article *article in self.articles)
    {
        
        int parentHeight = 0;
        int parenY = lastArticleBottom;
        
        self.parentView = [[ItemView alloc] initWithFrame:CGRectMake(0, parenY, SCREEN_WIDTH, 10000)];
        [self.parentView setDelegate:self];
        [self.parentView setScroll:self.scroll];
        [self.parentView setArticle:article];
        [self.parentView setBackgroundColor:[UIColor clearColor]];
        [self.scroll addSubview:self.parentView];
        
        //point
        UIImageView *pointImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"point"]];
        
        [pointImageView setFrame:CGRectMake(100-(POINT_HEIGHT/2)-0.5, parentHeight, POINT_HEIGHT, POINT_HEIGHT)];
        [self.parentView addSubview:pointImageView];
        
        //time
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"  MM/dd HH:mm"];
        NSString *timeStr = [dateFormatter stringFromDate:article.time];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, parentHeight, TIME_WIDTH, TIME_HEIGHT)];
        [timeLabel setText:timeStr];
        [timeLabel setFont:[UIFont systemFontOfSize:10]];
        [timeLabel.layer setCornerRadius:14];
        [timeLabel setBackgroundColor:[UIColor colorWithString:@"eeeeee"]];
        [self.parentView addSubview:timeLabel];
        lastArticleBottom += (TIME_HEIGHT+ARTICLE_SMALL_SPACE);
        parentHeight += pointImageView.bounds.size.height;
        
        //text
        if(article.text && article.text != nil && ![article.text isEqualToString:@""])
        {
            CGSize constraint = CGSizeMake(TEXT_WIDTH, 10000);
            CGSize size = [article.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByTruncatingTail];
            
            UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(TEXT_LEFT+100, parentHeight, TEXT_WIDTH, size.height)];
            
            [text setUserInteractionEnabled:NO];
            [text.layer setBorderColor:[UIColor colorWithString:@"cccccc"].CGColor];
            [text.layer setBorderWidth:1];
            [text setFont:[UIFont systemFontOfSize:15]];
            [text setBackgroundColor:[UIColor colorWithString:@"eeeeee"]];
            [text.layer setCornerRadius:14];
            [text setText:article.text];
            if(IOS_VERSION >= 7.0)
                [text setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            else
            {
                [text setContentInset:UIEdgeInsetsMake(-8, 0, 0, 0)];
            }
            [self.parentView addSubview:text];
            lastArticleBottom += ( size.height+ARTICLE_SMALL_SPACE);
            
            parentHeight += ( size.height+ARTICLE_SMALL_SPACE);
        }
        
        if(article.image)
        {
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSData *imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:article.image] stringByAppendingPathExtension:@"png"]];
            
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            
            int imageHeight = imageView.bounds.size.height * (IMAGE_WIDTH/imageView.bounds.size.width);
            
            [imageView setFrame:CGRectMake(IMAGE_LEFT + 100, parentHeight, IMAGE_WIDTH, imageHeight)];
            [imageView.layer setCornerRadius:14];
            [imageView.layer setBorderWidth:2];
            [imageView.layer setBorderColor:[UIColor colorWithString:@"cccccc"].CGColor];
            [imageView setClipsToBounds:YES];
            [self.parentView addSubview:imageView];
            lastArticleBottom += ( imageView.bounds.size.height+ARTICLE_SMALL_SPACE);
            
            parentHeight += ( imageView.bounds.size.height+ARTICLE_SMALL_SPACE);
        }
        
        if(article.image2)
        {
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSData *imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:article.image2] stringByAppendingPathExtension:@"png"]];
            
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            
            int imageHeight = imageView.bounds.size.height * (IMAGE_WIDTH/imageView.bounds.size.width);
            
            [imageView setFrame:CGRectMake(IMAGE_LEFT + 100, parentHeight, IMAGE_WIDTH, imageHeight)];
            [imageView.layer setCornerRadius:14];
            [imageView.layer setBorderWidth:2];
            [imageView.layer setBorderColor:[UIColor colorWithString:@"cccccc"].CGColor];
            [imageView setClipsToBounds:YES];
            [self.parentView addSubview:imageView];
            lastArticleBottom += ( imageView.bounds.size.height+ARTICLE_SMALL_SPACE);
            parentHeight += ( imageView.bounds.size.height+ARTICLE_SMALL_SPACE);
        }
        
        if(article.image3)
        {
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSData *imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:article.image3] stringByAppendingPathExtension:@"png"]];
            
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            
            int imageHeight = imageView.bounds.size.height * (IMAGE_WIDTH/imageView.bounds.size.width);
            
            [imageView setFrame:CGRectMake(IMAGE_LEFT + 100, parentHeight, IMAGE_WIDTH, imageHeight)];
            [imageView.layer setCornerRadius:14];
            [imageView.layer setBorderWidth:2];
            [imageView.layer setBorderColor:[UIColor colorWithString:@"cccccc"].CGColor];
            [imageView setClipsToBounds:YES];
            [self.parentView addSubview:imageView];
            lastArticleBottom += ( imageView.bounds.size.height+ARTICLE_SMALL_SPACE);
            parentHeight += ( imageView.bounds.size.height+ARTICLE_SMALL_SPACE);
        }

        lastArticleBottom += ARTICLE_SPACE;
        [self.parentView setCurrentHeight:parentHeight+ARTICLE_SPACE];
        [self.parentView setFrame:CGRectMake(0, parenY, SCREEN_WIDTH, parentHeight)];
        [self.viewArray addObject:self.parentView];
    }
    [self.scroll setContentSize:CGSizeMake(SCREEN_WIDTH, lastArticleBottom)];
}

#pragma mark ----  ItemViewDelegate
- (void)itemViewToRightWithArticle:(Article *)article withCurrentHeight:(NSInteger) height
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    if(article.image)
    {
        [fileMgr removeItemAtPath:[[documentsDirectory stringByAppendingPathComponent:article.image] stringByAppendingPathExtension:@"png"] error:nil];
    }
    if(article.image2)
    {
        [fileMgr removeItemAtPath:[[documentsDirectory stringByAppendingPathComponent:article.image2] stringByAppendingPathExtension:@"png"] error:nil];
    }
    if(article.image3)
    {
        [fileMgr removeItemAtPath:[[documentsDirectory stringByAppendingPathComponent:article.image3] stringByAppendingPathExtension:@"png"] error:nil];
    }
    [self removeObject:article];
    NSInteger index = [self.articles indexOfObject:article];
    [self.articles removeObject:article];
    [self.viewArray removeObjectAtIndex:index];
    for(int i = index;i < self.articles.count;i++)
    {
        ItemView *currentItemView = (ItemView *)self.viewArray[i];
        [UIView animateWithDuration:0.2 animations:^(){
            [currentItemView setCenter:CGPointMake(SCREEN_WIDTH/2, ((ItemView *)self.viewArray[i]).center.y-height)];
        } completion:^(BOOL done){
            
        }];
    }
    [self.scroll setContentSize:CGSizeMake(SCREEN_WIDTH,self.scroll.contentSize.height - height)];
}

- (void)itemViewToLeftWithArticle:(Article *)article
{
    if(!self.addActionSheet)
    {
        self.addActionSheet = [[UIActionSheet alloc] initWithTitle:@"新增" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到朋友圈",@"分享给微信好友",@"微信收藏",@"微博晒幸福",@"修改",nil];
    }
    self.operationArticle = article;
    [self.addActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark --- weixin 

- (void) sendTextContent:(NSInteger) wXScene
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    if(self.operationArticle.text && ![self.operationArticle.text isEqualToString:@""])
    {
        req.text = self.operationArticle.text;
        req.bText = YES;
    }
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"恋爱心情";
    message.description = self.operationArticle.text;
    [message setThumbImage:[UIImage imageNamed:@"Icon-60.png"]];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    WXImageObject *ext = [WXImageObject object];
    if(self.operationArticle.image3 != nil)
    {
        ext.imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:self.operationArticle.image3] stringByAppendingPathExtension:@"png"]];
        UIImage* image = [UIImage imageWithData:ext.imageData];
        ext.imageData = UIImagePNGRepresentation(image);
        message.mediaObject = ext;
    }
    if(self.operationArticle.image2 != nil)
    {
        ext.imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:self.operationArticle.image2] stringByAppendingPathExtension:@"png"]];
        UIImage* image = [UIImage imageWithData:ext.imageData];
        ext.imageData = UIImagePNGRepresentation(image);
        message.mediaObject = ext;
    }
    if(self.operationArticle.image != nil)
    {
        ext.imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:self.operationArticle.image] stringByAppendingPathExtension:@"png"]];
        UIImage* image = [UIImage imageWithData:ext.imageData];
        ext.imageData = UIImagePNGRepresentation(image);
        message.mediaObject = ext;
    }
    message.mediaObject = ext;
    req.message = message;
    req.scene = wXScene;
    
    [WXApi sendReq:req];
}

#pragma mark --- weibo

- (void)didReceiveWeiboRequest:(WBBaseResponse *) response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
    }
}

- (void)shareWeiboButtonPressed
{
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    //文字
    if(self.operationArticle.text && ![self.operationArticle.text isEqualToString:@""])
    {
        message.text = [NSString stringWithFormat:@"%@ #恋爱心情#", self.operationArticle.text,nil];
    }
    else
    {
        message.text = @"#恋爱心情#";
    }
    //图片
    WBImageObject *image = [WBImageObject object];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    if(self.operationArticle.image3 != nil)
    {
        image.imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:self.operationArticle.image3] stringByAppendingPathExtension:@"png"]];
        message.imageObject = image;
    }
    if(self.operationArticle.image2 != nil)
    {
        image.imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:self.operationArticle.image2] stringByAppendingPathExtension:@"png"]];
        message.imageObject = image;
    }
    if(self.operationArticle.image != nil)
    {
        image.imageData = [fileMgr contentsAtPath:[[documentsDirectory stringByAppendingPathComponent:self.operationArticle.image] stringByAppendingPathExtension:@"png"]];
        message.imageObject = image;
    }
    return message;
}



@end
