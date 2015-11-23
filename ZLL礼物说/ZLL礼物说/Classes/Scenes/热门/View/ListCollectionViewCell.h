//
//  ListCollectionViewCell.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
@interface ListCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UIImageView *viewImage;
@property (strong, nonatomic) IBOutlet UILabel *moneyLable;
@property (strong, nonatomic) IBOutlet UILabel *likeLable;

@property (nonatomic, retain)HotModel *hot;
@end
