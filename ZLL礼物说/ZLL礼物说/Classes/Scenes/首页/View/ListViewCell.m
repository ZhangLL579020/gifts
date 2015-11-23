//
//  ListViewCell.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

- (void)setModel:(DataMessage *)model{
    self.viewImage.layer.masksToBounds = YES;
    self.viewImage.layer.cornerRadius = 5;
    
    self.imgeView.layer.masksToBounds = YES;
    self.imgeView.layer.cornerRadius = 5;
    
    [self.imgeView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    NSString *str = model.likes_count;
    self.sumberLable.text = [NSString stringWithFormat:@"%@",str];
   
    
    self.titleLable.text = model.title;

}


- (void)setListModel:(ListCategory *)listModel{
    
    self.viewImage.layer.masksToBounds = YES;
    self.viewImage.layer.cornerRadius = 5;
    
    self.imgeView.layer.masksToBounds = YES;
    self.imgeView.layer.cornerRadius = 5;
    
    [self.imgeView sd_setImageWithURL:[NSURL URLWithString:listModel.cover_image_url]];
    NSString *str = listModel.likes_count;
    self.sumberLable.text = [NSString stringWithFormat:@"%@",str];
    
    
    self.titleLable.text = listModel.title;
    
}
@end
