
//  DZWebBrowser.m
//  SimpleWebBrowser
//
//  Created by Ignacio Romero Zurbuchen on 5/25/12.
//  Copyright (c) 2011 DZen Interaktiv.
//  Licence: MIT-Licence
//

#import "DZWebBrowser.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#define kWebLoadingTimout 10.0
#define kDefaultControlsBundleName @"default-controls"

#define kImageTypeKey @"image"
#define kLinkTypeKey @"link"
#define kTypeKey @"type"
#define kTitleKey @"title"
#define kUrlKey @"url"

#define TXT_LOADING NSLocalizedString(@"TXT_LOADING",nil)
#define TXT_CLOSE NSLocalizedString(@"TXT_CLOSE",nil)
#define TXT_CANCEL NSLocalizedString(@"TXT_CANCEL",nil)
#define TXT_ACTIONSHEET_TWITTER NSLocalizedString(@"TXT_ACTIONSHEET_TWITTER",nil)
#define TXT_ACTIONSHEET_FACEBOOK NSLocalizedString(@"TXT_ACTIONSHEET_FACEBOOK",nil)
#define TXT_ACTIONSHEET_COPYLINK NSLocalizedString(@"TXT_ACTIONSHEET_COPYLINK",nil)
#define TXT_ACTIONSHEET_MAIL NSLocalizedString(@"TXT_ACTIONSHEET_MAIL",nil)
#define TXT_ACTIONSHEET_SAFARI NSLocalizedString(@"TXT_ACTIONSHEET_SAFARI",nil)
#define TXT_ACTIONSHEET_COPYIMG NSLocalizedString(@"TXT_ACTIONSHEET_COPYIMG",nil)
#define TXT_ACTIONSHEET_SAVEIMG NSLocalizedString(@"TXT_ACTIONSHEET_SAVEIMG",nil)
#define TXT_ALERT_NO_INTERNET NSLocalizedString(@"TXT_ALERT_NO_INTERNET",nil)
#define TXT_ALERT_NO_INTERNET_MESSAGE NSLocalizedString(@"TXT_ALERT_NO_INTERNET_MESSAGE",nil)
#define TXT_ALERT_NO_MAIL NSLocalizedString(@"TXT_ALERT_NO_MAIL",nil)
#define TXT_ALERT_NO_MAIL_MESSAGE NSLocalizedString(@"TXT_ALERT_NO_MAIL_MESSAGE",nil)
#define TXT_ALERT_OK NSLocalizedString(@"TXT_ALERT_OK",nil)

#define textForKey(key) [_resourceBundle localizedStringForKey:(key) value:@"" table:nil]


@interface UIActionSheet (Attachment)
@property (nonatomic, retain) NSMutableDictionary *userInfo;
@end
NSString * const kNewAttachmentKey = @"kNewAttachmentKey";
@implementation UIActionSheet (Attachment)
@dynamic userInfo;
- (void)setUserInfo:(NSMutableDictionary *)userInfo {
    objc_setAssociatedObject(self, (__bridge const void *)(kNewAttachmentKey),userInfo,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableDictionary *)userInfo {
    return objc_getAssociatedObject(self, (__bridge const void *)(kNewAttachmentKey));
}
@end

@interface DZWebBrowser ()
{
    UIBarButtonItem *_stopButton;
	UIBarButtonItem *_previousButton;
	UIBarButtonItem *_nextButton;
    UIBarButtonItem *_shareButton;
    
    UILabel *_titleLabel;
    UILabel *_urlLabel;
    
    UIActivityIndicatorView *_activityIndicator;
    
    NSBundle *_resourceBundle;
}
/**  */
@property(nonatomic, strong) UIImage *navBarBkgdImage;
/**  */
@property(nonatomic, strong) UIImage *toolBarBkgdImage;
/**  */

@end

@implementation DZWebBrowser
@synthesize webView = _webView;
@synthesize navBarBkgdImage = _navBarBkgdImage;
@synthesize toolBarBkgdImage = _toolBarBkgdImage;
@synthesize currentURL = _currentURL;

- (id)initWebBrowserWithURL:(NSURL *)URL
{
    self = [super init];
    if (self)
    {
        _currentURL = URL;
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithString:PINK_COLOR]];
    [self.navigationController.toolbar setTintColor:[UIColor colorWithString:PINK_COLOR]];
    [self setToolbarItems:self.items animated:NO];
    
    if ([self isPushed]) {
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
    else {
        [self.navigationItem setLeftBarButtonItem:self.closeButton animated:NO];
        [self.navigationController setToolbarHidden:NO animated:NO];
    }
    
    UIBarButtonItem *indicatorButton = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    [self.navigationItem setRightBarButtonItem:indicatorButton animated:NO];
    
    _previousButton.enabled = NO;
	_nextButton.enabled = NO;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadWebView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.toolbar setHidden:NO];
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    if ([self isPushed]) {
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
}


#pragma mark - Getter Methods

- (NSString *)title
{
    return [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (NSString *)url
{
    return [_webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
}

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.suppressesIncrementalRendering = YES;
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;

        [self.view addSubview:_webView];
    }
    return _webView;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator)
    {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicator.color = [UIColor whiteColor];
        _activityIndicator.hidesWhenStopped = YES;
    }
    return _activityIndicator;
}

- (UIView *)titleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self titleWidth], 44.0)];
    [titleView addSubview:self.titleLabel];
    [titleView addSubview:self.urlLabel];
    return titleView;
}

- (CGFloat)titleWidth
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 632.0 : 188.0;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2.0, [self titleWidth], 20.0)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _titleLabel.minimumScaleFactor = 3;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.75];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

- (UILabel *)urlLabel
{
    if (!_urlLabel)
    {
        _urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22.0, [self titleWidth], 20.0)];
        _urlLabel.backgroundColor = [UIColor clearColor];
        _urlLabel.font = [UIFont systemFontOfSize:14.0];
        _urlLabel.textColor = [UIColor whiteColor];
        _urlLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.75];
        _urlLabel.shadowOffset = CGSizeMake(0, -1);
        _urlLabel.textAlignment = NSTextAlignmentCenter;
        _urlLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _urlLabel;
}
- (UIBarButtonItem *)closeButton
{
    return [[UIBarButtonItem alloc] initWithTitle:textForKey(TXT_CLOSE) style:UIBarButtonItemStyleDone target:self action:@selector(closeAction:)];
}

- (NSArray *)items
{
    if (!_resourceBundleName) {
        [self setResourceBundleName:kDefaultControlsBundleName];
    }
    
    UIBarButtonItem *flexibleMargin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *margin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    margin.width = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 50.0 : 15.0;
    
    UIImage *stopImg = [self imageNamed:@"stopButton" forBundleNamed:_resourceBundleName];
    UIImage *nextImg = [self imageNamed:@"nextButton" forBundleNamed:_resourceBundleName];
    UIImage *previousdImg = [self imageNamed:@"previousButton" forBundleNamed:_resourceBundleName];
    
    _stopButton = [[UIBarButtonItem alloc] initWithImage:stopImg style:UIBarButtonItemStylePlain target:self action:@selector(stopWebView)];

    _previousButton = [[UIBarButtonItem alloc] initWithImage:previousdImg style:UIBarButtonItemStylePlain target:self action:@selector(backWebView)];
    _nextButton = [[UIBarButtonItem alloc] initWithImage:nextImg style:UIBarButtonItemStylePlain target:self action:@selector(forwardWebView)];
    
    NSMutableArray *items = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? [NSMutableArray arrayWithObjects:margin, _stopButton, flexibleMargin, _previousButton, flexibleMargin, _nextButton, nil] : [NSMutableArray arrayWithObjects:margin, _stopButton, flexibleMargin, _previousButton, flexibleMargin, _nextButton, nil];
    
//    if (_allowSharing) {
//        [items addObject:flexibleMargin];
//        _shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
//        [items addObject:_shareButton];
//        [items addObject:margin];
//    }
//    else {
//        [items addObject:flexibleMargin];
//        [items addObject:flexibleMargin];
//    }
    [items addObject:flexibleMargin];
    [items addObject:flexibleMargin];
    return items;
}

- (CGSize)windowSize
{
    CGSize size;
    size.width = [[_webView stringByEvaluatingJavaScriptFromString:@"window.innerWidth"] integerValue];
    size.height = [[_webView stringByEvaluatingJavaScriptFromString:@"window.innerHeight"] integerValue];
    return size;
}

- (UIImage *)imageNamed:(NSString *)imgName forBundleNamed:(NSString *)bundleName
{
    NSString *path = [NSString stringWithFormat:@"%@.bundle/images/%@",bundleName,imgName];
    return [UIImage imageNamed:path];
}

#pragma mark - Setter Methods

- (void)setNavBarBkgdImage:(UIImage *)image
{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)setToolBarBkgdImage:(UIImage *)image
{
    [self.navigationController.toolbar setBackgroundImage:image forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
}

- (void)setResourceBundleName:(NSString *)name
{
    _resourceBundleName = name;
    
    if (!_resourceBundle) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:_resourceBundleName ofType:@"bundle"];
        _resourceBundle = [NSBundle bundleWithPath:bundlePath];
    }
}

- (void)setLoadingTitle
{
    _titleLabel.text = textForKey(TXT_LOADING);
    
    CGRect rect = _titleLabel.frame;
    rect.origin.y = 12.0;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _titleLabel.frame = rect;
                         _urlLabel.alpha = 0;
                     }
                     completion:NULL];
}

- (void)setDocumentTitle
{
    _titleLabel.text = [self title];
    _urlLabel.text = [self url];
    
    CGRect rect = _titleLabel.frame;
    rect.origin.y = 2.0;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _titleLabel.frame = rect;
                         _urlLabel.alpha = 1.0;
                     }
                     completion:NULL];
}

- (void)showLoadingIndicator:(BOOL)show
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = show;
}


#pragma mark - WebViewController Methods

- (void)stopWebView
{
    [_webView stopLoading];
    [self showLoadingIndicator:NO];
    self.activityBlockView = nil;
//    [self dismissViewControllerAnimated:YES completion:^(){}];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.toolbar setHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];

    //罗若峰
}

- (void)backWebView
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (void)forwardWebView
{
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (void)loadWebView
{
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:_currentURL]];
}

- (void)reloadWebView
{
    [self.webView reload];
}

- (void)closeAction:(id)sender
{
    [self browserWillClose];
//    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController.toolbar setHidden:YES];
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)browserWillClose
{
    [self showLoadingIndicator:NO];
    
    [_webView stopLoading];
    _webView.delegate = nil;
    _webView = nil;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    self.currentURL = request.URL;

    
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webview
{
    if(self.activityBlockView)
    {
        [self.activityBlockView setAlpha:0.7];
    }
    else
    {
        
        //activity indicator View
        self.activityBlockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self.activityBlockView setCenter:self.webView.center];
        [self.activityBlockView setBackgroundColor:[UIColor blackColor]];
        [self.activityBlockView setAlpha:0.7];
        [self.activityBlockView.layer setCornerRadius:7];
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(9, 9, 32.0f, 32.0f)];
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
        [activity startAnimating];
        [self.activityBlockView addSubview:activity];
        [self.view addSubview:self.activityBlockView];
        [self.activityBlockView setUserInteractionEnabled:YES];
    }
    
	[self showLoadingIndicator:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webview
{
    
    _previousButton.enabled = [webview canGoBack];
    _nextButton.enabled = [webview canGoForward];
    
    [self.activityBlockView setAlpha:0.0];
    
    [self showLoadingIndicator:NO];
}

- (void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error
{
	[self webViewDidFinishLoad:webview];
    [self showLoadingIndicator:NO];
}
#pragma mark - View lifeterm

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    _currentURL = [NSURL URLWithString:[self url]];
    
    [_webView removeFromSuperview];
    [self setWebView:nil];
    
    [self loadWebView];
}
- (void)dealloc
{
    [self setWebView:nil];
    [self setCurrentURL:nil];
    [self setResourceBundleName:nil];
    [self setNavBarBkgdImage:nil];
    [self setToolBarBkgdImage:nil];
}

@end
