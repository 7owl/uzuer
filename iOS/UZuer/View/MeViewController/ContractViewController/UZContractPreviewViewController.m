//
//  UZContractPreviewViewController.m
//  UZuer
//
//  Created by xiaofeishen on 15/9/22.
//  Copyright © 2015年 CaydenK. All rights reserved.
//

#import "UZContractPreviewViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface UZContractPreviewViewController ()
<UIWebViewDelegate,
UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation UZContractPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预览合同";
    // Do any additional setup after loading the view from its nib.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.contractUrl]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
