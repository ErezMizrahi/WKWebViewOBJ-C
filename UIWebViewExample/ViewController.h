//
//  ViewController.h
//  UIWebViewExample
//
//  Created by Erez Mizrahi on 28/10/2019.
//  Copyright © 2019 Erez Mizrahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController <WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

