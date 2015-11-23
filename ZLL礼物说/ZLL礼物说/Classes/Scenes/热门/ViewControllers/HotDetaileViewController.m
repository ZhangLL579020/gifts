//
//  HotDetaileViewController.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "HotDetaileViewController.h"
#import "DataManager.h"
@interface HotDetaileViewController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HotDetaileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"热门" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self showWebView];
    
    
}
- (void)goBack{
    if ([self.webView canGoBack]) {
        
        [self.webView goBack];
        
    }else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


- (void) showWebView{
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    NSURL *url = [NSURL URLWithString:self.model.purchase_url];
    
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:requset];
    
    [self.view addSubview:_webView];
    
    
    
}
@end
