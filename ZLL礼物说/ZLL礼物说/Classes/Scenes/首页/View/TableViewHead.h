//
//  TableViewHead.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewHead : UIView<UIScrollViewDelegate>
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic, retain)NSTimer *timer;
@property (nonatomic, retain)NSMutableArray *imgArray;
@property (nonatomic,retain) NSMutableArray *image;

@end
