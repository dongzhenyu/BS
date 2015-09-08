//
//  DZYWebViewController.m
//  BS
//
//  Created by dzy on 15/9/8.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYWebViewController.h"
#import "DZYSquare.h"

@interface DZYWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;

@end

@implementation DZYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.square.name;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]]];
    
    self.webView.backgroundColor = DZYCommonBgColor;
//    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
}

- (IBAction)back {
    [self.webView goBack];
}

- (IBAction)forward {
    [self.webView goForward];
}

- (IBAction)refresh {
    [self.webView reload];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
}

@end
