//
//  ShowViewController.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "ShowViewController.h"
#import "DataManager.h"
#import "DetailedModel.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width

#define kHeight [UIScreen mainScreen].bounds.size.height


@interface ShowViewController () <MBProgressHUDDelegate,UIScrollViewDelegate>
@property (nonatomic, retain) DetailedModel *detaModel;
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"礼物说" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self requestData];
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];

    
    self.hud.customView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dengru.png"]];
    
    self.hud.labelText = @"正在加载";
    
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    
    self.hud.color = [UIColor redColor];
    [_hud show:YES];
    
    [self.view addSubview:self.hud];

    
    
    
}


- (void)goBack{
    if ([self.webView canGoBack]) {
        
        [self.webView goBack];
        
    }else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void) requestData{
    
    NSString *str = [NSString stringWithFormat:@"%@?",self.model.ID];
    NSString *url = [kURL_SY stringByAppendingString:str];
    
    [[DataManager sharedManage] sharedData:url block:^(id block) {
        
        NSDictionary *dic = block[@"data"];
        
        self.detaModel = [[DetailedModel alloc] initWithDictionary:dic];
        
//        NSLog(@"%@",_detaModel.content_url);
        
        [self showWebView];
        
    }];

}

- (void) showWebView{

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight )];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(kWidth, kHeight + 200);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth,230)];
    
    imgView.image = [UIImage imageNamed:@"100"];
    
    [_scrollView addSubview:imgView];
    
//    [self.view addSubview:_scrollView];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight )];
//      self.webView.scrollView.scrollEnabled = NO;
    
    NSURL *url = [NSURL URLWithString:_detaModel.content_url];
    
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:requset];
    
    [self.hud hide:YES];
    
    
    [self.view addSubview:_webView];
    
}
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    if (self.webView.scrollView == scrollView) {
//        self.webView.scrollView.scrollEnabled = NO;
//        
//    }
//
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f", scrollView.contentOffset.y);
    if (scrollView.contentOffset.y >= 200) {
        self.webView.scrollView.scrollEnabled = YES;
//        self.scrollView.scrollEnabled = NO;
    }else {
        self.webView.scrollView.scrollEnabled = NO;
    }

}

@end
