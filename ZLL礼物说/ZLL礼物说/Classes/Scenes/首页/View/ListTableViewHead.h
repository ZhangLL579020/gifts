//
//  ListTableViewHead.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewHead : UIView <UIScrollViewDelegate>

@property (nonatomic, retain)UIScrollView *scrollView;
@property (nonatomic, retain)UIPageControl *pageControl;
@property (nonatomic, retain)UIImageView *imgView;
@property (nonatomic, retain)NSTimer *timer;
@property (nonatomic, retain)NSMutableArray *imgArray;

@end
