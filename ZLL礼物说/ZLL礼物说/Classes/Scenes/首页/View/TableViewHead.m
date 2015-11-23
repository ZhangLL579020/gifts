//
//  TableViewHead.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "TableViewHead.h"
#import "DataManager.h"

#define Screen_Width self.bounds.size.width
#define Screen_Height self.bounds.size.height
@implementation TableViewHead

- (instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];

    if (self) {

        self.imgArray = [NSMutableArray array];
        [[DataManager sharedManage] sharedData:kURL_2 block:^(id block) {
            
            NSDictionary *dic =[(NSMutableDictionary *)block objectForKey:@"data"];
            
            NSArray *array = [[NSArray alloc]initWithArray:dic[@"banners"]];
            
            for (NSDictionary *dic in array) {
                
                NSString *str = dic[@"image_url"];
                                NSLog(@"%@",str);
                [self.imgArray addObject:str];
            }
            NSLog(@"%ld",self.imgArray.count);
            
            
             self.image = [NSMutableArray array];
       
            for (int i = 0; i < self.imgArray.count; i ++) {
                
                
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, Screen_Width, 180)];
                
                
                [imgView sd_setImageWithURL:[NSURL URLWithString:self.imgArray[i]]];
                
                [_image addObject:imgView];
            }
//            负一张
       UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, Screen_Width, 180)];
            [imgView1 sd_setImageWithURL:[NSURL URLWithString:self.imgArray[0]]];
            
            [self.image addObject:imgView1];
               //正多一张
           UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, Screen_Width, 180)];
            [imgView2 sd_setImageWithURL:[NSURL URLWithString:[self.imgArray lastObject]]];
            [self.image insertObject:imgView2 atIndex:0];

            
            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width , 180)];
            _scrollView.pagingEnabled = YES;
            _scrollView.contentSize = CGSizeMake(self.frame.size.width * [self.image count], 180);
            _scrollView.showsHorizontalScrollIndicator = NO;
            _scrollView.delegate = self;
            [self addSubview:_scrollView];
            self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
            
            for (int index = 0; index < self.image.count; index++) {
                UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(self.frame.size.width * index, 0, Screen_Width, 180)];
             
                [_scrollView addSubview:scroll];
           
               
                [scroll addSubview:self.image[index]];
    
                
            }
            
            _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(30, Screen_Height - 30, Screen_Width - 60, 30)];
            //    _pageControl = [[UIPageControl alloc] init];
            _pageControl.numberOfPages = [self.image count] - 2;
            _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
            _pageControl.pageIndicatorTintColor = [UIColor blackColor];
            [self addSubview:_pageControl];
            [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
            [self one];
        }];
    }
    return self;
}
- (void) one {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:9 target:self selector:@selector(click) userInfo:nil repeats:YES];
}
- (void)click{
    NSInteger page = _pageControl.currentPage;
    page ++;
    if (page == self.imgArray.count ) {
        page =0;
    }
    _pageControl.currentPage = page;
    
    [_scrollView setContentOffset:CGPointMake((page + 1)* self.scrollView.bounds.size.width, 0) animated:NO];
    
    CATransition *transition = [CATransition animation];
    
    //持续时间
    transition.duration = 3;
    //设置过度效果
    transition.type = @"cube";
    
    //设置过度方向
    transition.subtype = @"fromRight";
    
    [_scrollView.layer addAnimation:transition forKey:@"transition"];

}
- (void)pageAction:(UIPageControl *)page
{
    [_scrollView setContentOffset:CGPointMake((page.currentPage + 1)* self.scrollView.bounds.size.width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        int i = scrollView.frame.size.width / 2;
        //        _pageControl.currentPage = (scrollView.contentOffset.x - _scrollView.bounds.size.width - i) / (scrollView.frame.size.width) + 1;
        _pageControl.currentPage = (scrollView.contentOffset.x - _scrollView.bounds.size.width + i) / (scrollView.frame.size.width)  ;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollView == scrollView) {
        if (_scrollView.contentOffset.x >= _scrollView.bounds.size.width * (self.image.count - 1)) {
            [_scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0) animated:NO];
        }
        
        if (_scrollView.contentOffset.x <= 0) {
            [_scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * (self.image.count - 2), 0) animated:NO];
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
      [self.timer invalidate];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;{
    
    [self one];
}
@end
