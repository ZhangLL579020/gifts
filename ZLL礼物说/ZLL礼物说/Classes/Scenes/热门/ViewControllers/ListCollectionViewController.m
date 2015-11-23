//
//  ListCollectionViewController.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "ListCollectionViewController.h"
#import "HotModel.h"
#import "DataManager.h"
#import "ListCollectionViewCell.h"
#import "HotDetaileViewController.h"
#define kWith [UIScreen mainScreen].bounds.size.width

@interface ListCollectionViewController ()
@property (nonatomic, retain)NSMutableArray *dataArray;
@end

@implementation ListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor colorWithRed:231/256.0 green:231/256.0 blue:231/256.0 alpha:1];
  
    //头视图
    [self.collectionView registerNib:[UINib nibWithNibName:@"ListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
   
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestData];
        
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self requestDataBottom];
    }];
    
    [self requestData];
    
}

- (void)requestData{
    
    [[DataManager sharedManage] sharedData:kURL_10 block:^(id block) {
        
        if (self.dataArray.count) {
            
            [self.dataArray removeAllObjects];
        }
        
        NSDictionary *dic = block[@"data"];
       
        NSArray *array = dic[@"items"];
//        NSLog(@"%ld",array.count);
    
        for (NSDictionary *dic in array) {
            
            HotModel *model = [[HotModel alloc] initWithDictionary:dic[@"data"]];
//            NSLog(@"%@",model.name);
            [self.dataArray addObject:model];
        }
        
        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
    }];
}

//上拉刷新数据请求
- (void)requestDataBottom{
    
    if (self.dataArray.count) {
        
        NSString * num = [NSString stringWithFormat:@"%ld",self.dataArray.count];
        
        NSString *urlStr = [kURL_H stringByAppendingString:num];
        
        [[DataManager sharedManage] sharedData:urlStr block:^(id block) {
            
            
            NSDictionary *dic = block[@"data"];
            
            NSArray *array = dic[@"items"];
            
            for (NSDictionary *dic in array) {
                
                HotModel *model = [[HotModel alloc] initWithDictionary:dic[@"data"]];
          
                [self.dataArray addObject:model];
            }
            
            [self.collectionView reloadData];
            
            [self.collectionView.mj_footer endRefreshing];
        }];

    }
    
}


#pragma mark <UICollectionViewDataSource>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HotDetaileViewController *hotVC = [[HotDetaileViewController alloc] init];
    
    self.nav =[[UINavigationController alloc] initWithRootViewController:hotVC];
    
    HotModel *model = self.dataArray[indexPath.row];
    
    hotVC.model  =  model;
    
    [self showDetailViewController:_nav sender:nil];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    HotModel *hot = self.dataArray[indexPath.row];

    cell.hot =  hot;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(160, 230);
    
    return CGSizeMake(kWith/2 - 20, kWith/2 + 20);
}

//设置item内间距大小(顺序是上左下右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

//设置最小列间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

@end
