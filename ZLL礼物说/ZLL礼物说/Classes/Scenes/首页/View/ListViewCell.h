//
//  ListViewCell.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataMessage.h"
#import "ListViewCell.h"
#import "ListCategory.h"
@interface ListViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgeView;
@property (strong, nonatomic) IBOutlet UILabel *titleLable;

@property (strong, nonatomic) IBOutlet UILabel *sumberLable;
@property (strong, nonatomic) IBOutlet UIImageView *viewImage;

@property (nonatomic, retain)DataMessage *model;

@property (nonatomic, retain)ListCategory *listModel;
@end
