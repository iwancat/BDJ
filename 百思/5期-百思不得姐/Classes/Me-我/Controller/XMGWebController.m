//
//  XMGWebController.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/21.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGWebController.h"

@interface XMGWebController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *frowardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation XMGWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 监听点击
- (IBAction)backClick:(id)sender {
    [self.webView goBack];
}
- (IBAction)forwardClick:(id)sender {
    [self.webView goForward];
}
- (IBAction)refreshItem:(id)sender {
    [self.webView reload];
}
#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    self.frowardItem.enabled = webView.canGoForward;
}
@end
