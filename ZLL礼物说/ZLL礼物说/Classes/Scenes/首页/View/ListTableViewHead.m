//
//  ListTableViewHead.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "ListTableViewHead.h"
#import "DataManager.h"
#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation ListTableViewHead
 int a = 0;
- (instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 180)];
        
        self.scrollView.pagingEnabled = YES;
        
        self.scrollView.delegate = self;
        
        [[DataManager sharedManage] sharedData:kURL_2 block:^(id block) {
            
            NSDictionary *dic =[(NSMutableDictionary *)block objectForKey:@"data"];

            NSArray *array = [[NSArray alloc]initWithArray:dic[@"banners"]];
        
            for (NSDictionary *dic in array) {
                
                NSString *str = dic[@"image_url"];
//                NSLog(@"%@",str);
                [self.imgArray addObject:str];
            }
            NSLog(@"%ld",self.imgArray.count);
            self.scrollView.contentSize = CGSizeMake(self.imgArray.count * kWidth, 180);
            
            for (int i = 0; i < self.imgArray.count; i ++) {
                

                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, 180)];
             
                
                [imgView sd_setImageWithURL:[NSURL URLWithString:self.imgArray[i]]];
                
                [self.scrollView addSubview:imgView];
            }
            
            //负一张
            UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(-kWidth, 0, kWidth, 180)];
            [imgView1 sd_setImageWithURL:[NSURL URLWithString:self.imgArray[0]]];
            [_scrollView addSubview:imgView1];
            //正多一张
            UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * self.imgArray.count , 0, kWidth, 180)];
            [imgView2 sd_setImageWithURL:[NSURL URLWithString:self.imgArray[0]]];
            [_scrollView addSubview:imgView2];

            [self addSubview:self.scrollView];
            
         
//            [self start];
            
#pragma mark -- UiPageControl
            
            self.pageControl.numberOfPages = self.imgArray.count;
            
            self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
            
            self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
            
            [self.pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
            
            [self addSubview:_pageControl];
            
             self.timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(click) userInfo:nil repeats:YES];
          
        }];
    }
    return self;
}

- (void)pageAction:(UIPageControl *)page
{
    [_scrollView setContentOffset:CGPointMake(page.currentPage * self.scrollView.bounds.size.width, 0) animated:YES];
}
//- (void)start{
//     self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(click) userInfo:nil repeats:YES];
//}
- (void)click{
    NSInteger page = _pageControl.currentPage;
    page ++;
    if (page == self.imgArray.count) {
        page =0;
    }
    _pageControl.currentPage = page;
    
    [self.scrollView setContentOffset:CGPointMake(kWidth  * page, 10) animated:NO];
    
    if (a > _imgArray.count) {
        a = 0;
    }
    CATransition *transition = [CATransition animation];
    
    //持续时间
    transition.duration = 2;
    //设置过度效果
    transition.type = @"cube";
  
    //设置过度方向
    transition.subtype = @"fromRight";
    
    CGPoint point = CGPointMake(kWidth * (a + 1), 0);
    a++;
    [_scrollView setContentOffset:point animated:NO];
    [_scrollView.layer addAnimation:transition forKey:@"transition"];
    
    if (a == _imgArray.count + 1) {
        _scrollView.contentOffset = CGPointMake(-kWidth, 0);
       
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger number = self.scrollView.contentOffset.x/kWidth;
    
    _pageControl.currentPage = number;
//    [self.timer invalidate];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
//  [self.timer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    [self start];
}

#pragma mark -- lazy Load
-(NSMutableArray *)imgArray{
    if (!_imgArray) {
        _imgArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _imgArray;
}

-(UIImageView *)imgView{
    
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 180)];
    }
    return _imgView;
}

- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
       
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(277, 160, 100, 30)];
    }
    return _pageControl;
}
@end
