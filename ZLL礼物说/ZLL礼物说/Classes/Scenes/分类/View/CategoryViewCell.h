//
//  CategoryViewCell.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryModel;
@interface CategoryViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;

@property (nonatomic, retain) CategoryModel *categoryModel;
@end
