//
//  CategoryCollectionVC.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "CategoryCollectionVC.h"
#import "CategoryModel.h"
#import "DataManager.h"
#import "CategoryViewCell.h"
#import "CategoryReusableView.h"
#import "CategoryViewController.h"
#define kWith [UIScreen mainScreen].bounds.size.width
@interface CategoryCollectionVC ()
@property (nonatomic, retain) NSMutableArray *dataArray;
@end

@implementation CategoryCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.collectionView registerNib:[UINib nibWithNibName:@"CategoryViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //headView
    [self.collectionView registerNib:[UINib nibWithNibName:@"CategoryReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"1"];
    
    //footView
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"2"];
    
    [self parseData];
}

- (void)parseData{
    
    [[[DataManager alloc] init] sharedData:CLASSIFYURL block:^(id block) {
        
        NSDictionary *dictionary = block[@"data"];
        
        NSArray *array = dictionary[@"channel_groups"];
        
        for (NSDictionary *dic in array) {
            
            NSArray *arr = dic[@"channels"];
            NSMutableArray *arrayM = [NSMutableArray array];
            for (NSDictionary *dic1 in arr) {
                
                CategoryModel *cateModel = [[CategoryModel alloc] initWithDictionary:dic1];
                [arrayM addObject:cateModel];
            }
            
            [self.dataArray addObject:arrayM];
        }
        
        [self.collectionView reloadData];
    }];
}


#pragma mark <UICollectionViewDataSource>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = @[@"品类",@"对象",@"场合",@"风格"];
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        CategoryReusableView *reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"1" forIndexPath:indexPath];
        
        reuseableView.nameLable.text = array[indexPath.section];
        
        return reuseableView;
    }else{
        
        UICollectionReusableView *footerReuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"2" forIndexPath:indexPath];
        
        footerReuseView.backgroundColor = [UIColor colorWithRed:231/256.0 green:231/256.0 blue:231/256.0 alpha:1];
        
        return footerReuseView;
    }

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *array = self.dataArray[section];
    
    return array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSMutableArray *array = self.dataArray[indexPath.section];
    
    CategoryModel *model = array[indexPath.row];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    
    cell.nameLable.text = model.name;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWith/4 - 10,kWith/4 + 35);
}
//设置foot区域的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(20, 15);
}
//设置最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 50;
}

//设置item内间距大小(顺序是上左下右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(20, 35);
}


-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark -- did select
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    NSMutableArray *array = self.dataArray[indexPath.section];
    
    CategoryModel *model = array[indexPath.row];
    
    CategoryViewController *cate = [[CategoryViewController alloc] init];

    cate.model =  model;
    
    [self.navigationController pushViewController:cate animated:YES];
    
}

@end
