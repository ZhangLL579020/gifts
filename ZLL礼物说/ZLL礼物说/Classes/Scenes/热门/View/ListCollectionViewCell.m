//
//  ListCollectionViewCell.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "ListCollectionViewCell.h"

@implementation ListCollectionViewCell

- (void)setHot:(HotModel *)hot{
    
    self.viewImage.layer.masksToBounds = YES;
    self.viewImage.layer.cornerRadius = 6;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:hot.cover_image_url]];
    
     self.nameLable.text = hot.name;
    
    self.moneyLable.text = hot.price;
    NSString *str = hot.favorites_count;
    self.likeLable.text = [NSString stringWithFormat:@"%@",str];
    
}

@end
