//
//  ViewController.m
//  UIWebViewExample
//
//  Created by Erez Mizrahi on 28/10/2019.
//  Copyright © 2019 Erez Mizrahi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation ViewController


typedef enum urls {
    google,
    facebook,
} urls;




- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.navigationDelegate = self;
    //    [self loadURLMethod:@"https://www.google.com"];
    [self activityInidicator];
    
}

- (void)loadURLMethod: (NSString *) urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requset];
}

- (IBAction)loadURL:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"https://www.google.com"];
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requset];
    
    
}
- (IBAction)loadHTMLFile:(id)sender {
    NSString *html = @"<HTML><HEAD><TITLE>Your Title Here</TITLE></HEAD><BODY BGCOLOR='FFFFFF'><CENTER><IMG SRC='clouds.jpg' ALIGN='BOTTOM'> </CENTER><HR><a href='http://somegreatsite.com'>Link Name</a>is a link to another nifty site<H1>This is a Header</H1><H2>This is a Medium Header</H2>Send me mail at <a href='mailto:support@yourcompany.com'>support@yourcompany.com</a>.<P> This is a new paragraph!<P> <B>This is a new paragraph!</B><BR> <B><I>This is a new sentence without a paragraph break, in bold italics.</I></B><HR></BODY></HTML>";
    [_webView loadHTMLString:html baseURL:nil];
}

- (IBAction)switchPage:(UISegmentedControl *)sender {
    NSString *path = nil;
    switch ([sender selectedSegmentIndex]) {
        case 0:
            path = [self convertToString:google];
            [self loadURLMethod:path];
            break;
            
        case 1:
            path = [self convertToString:facebook];
            [self loadURLMethod:path];
        default:
            break;
    }
}



- (IBAction)webViewForward:(id)sender {
    [_webView goForward];
}


- (IBAction)webViewBackwards:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    } else {
        NSLog(@"cannot preform back action");
    }
}


- (IBAction)webViewReload:(id)sender {
    [_webView reload];
    NSLog(@"page realod");
}



- (IBAction)webViewStop:(id)sender {
    [_webView stopLoading];
    NSLog(@"page stop loading");
}



-(void)addWebViewProgromatclly {
    
    CGFloat x = self.view.frame.origin.x;
    CGFloat y = self.view.frame.origin.y;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    WKWebView *myWebView = [[WKWebView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    [self.view addSubview:myWebView];
    
}


-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //To avoid link clicking.
    if(navigationAction.navigationType == UIWebViewNavigationTypeLinkClicked){
        decisionHandler(NO);
        return;
    }
    
    
    //To avoid loading all the google ads.
    
    if([navigationAction.request.URL.absoluteString rangeOfString:@"googleads"].location != NSNotFound) {
        decisionHandler(NO);
        return;
    }
    
    decisionHandler(YES);
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [self startIndicator];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self stopIndicator];
}

-(NSString*)convertToString: (urls) urls {
    NSString *result = nil;
    
    switch (urls) {
        case google:
            result = @"https://www.google.com";
            break;
        case facebook:
            result = @"https://www.facebook.com";
            
        default:
            break;
    }
    
    return result;
}


-(void)activityInidicator {
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleLarge];
    [_indicator setCenter:self.view.center];
    [self.view addSubview:_indicator];
    
    
}

-(void)startIndicator {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_indicator startAnimating];
        });
    });
}

-(void)stopIndicator {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_indicator stopAnimating];
    });
}


@end
