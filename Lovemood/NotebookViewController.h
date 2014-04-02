//
//  NotebookViewController.h
//  Lovemood
//
//  Created by 罗若峰 on 13-11-21.
//  Copyright (c) 2013年 若峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemView.h"

@interface NotebookViewController : UIViewController<UIActionSheetDelegate,ItemViewDelegate>


@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *add;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) UIActionSheet *addActionSheet;
@property (strong, nonatomic) IBOutlet UIImageView *addImageView;

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSMutableArray *articles;
- (IBAction)cancel:(id)sender;
- (IBAction)add:(id)sender;

@end
