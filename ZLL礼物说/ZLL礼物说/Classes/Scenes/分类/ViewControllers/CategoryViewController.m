//
//  CategoryViewController.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "CategoryViewController.h"
#import "ListCategory.h"
#import "DataManager.h"
#import "ListViewCell.h"
#import "DetaileCategoryViewController.h"
@interface CategoryViewController ()

@property (nonatomic, retain) NSMutableArray *dataArray;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"ListViewCell" bundle:nil] forCellReuseIdentifier:@"1"];
    
    [self requestData];
    
    //下拉
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestData];
    }];
    
    //上拉
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [self requestDataBottom];
    
    }];
    
}

- (void)requestData{
    if (self.dataArray.count) {
        
        [self.dataArray removeAllObjects];
        
    }
    NSString *urlStr = [NSString stringWithFormat:kURL_FL,self.model.ID,(NSInteger)0];
    NSLog(@"%@",urlStr);
   [[DataManager sharedManage] sharedData:urlStr block:^(id block) {
       
       NSDictionary *dic = block[@"data"];
       
       NSArray *array = dic[@"items"];
       
       for (NSDictionary *dictionary in array) {
           
           ListCategory *listModel = [[ListCategory alloc] initWithDictionary:dictionary];
           
           [self.dataArray addObject:listModel];
       }
       
       [self.tableView reloadData];
       
       [self.tableView.mj_header endRefreshing];
   }];
    
}

- (void)requestDataBottom{
    
    if (self.dataArray.count) {
        
        NSString *urlStr = [NSString stringWithFormat:kURL_FL,self.model.ID,self.dataArray.count];
//        NSLog(@"%@",urlStr);
        [[DataManager sharedManage] sharedData:urlStr block:^(id block) {
            
            NSDictionary *dic = block[@"data"];
            
            NSArray *array = dic[@"items"];
            
            for (NSDictionary *dictionary in array) {
                
                ListCategory *listModel = [[ListCategory alloc] initWithDictionary:dictionary];
                
                [self.dataArray addObject:listModel];
            }
            
            [self.tableView reloadData];
            
            [self.tableView.mj_footer endRefreshing];
        }];

        
        
    }
    
}

#pragma mark -- did select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetaileCategoryViewController *detaVC = [[DetaileCategoryViewController alloc] init];
    
    UINavigationController *nar = [[UINavigationController alloc] initWithRootViewController:detaVC];
    
    ListCategory *listModel= self.dataArray[indexPath.row];
    
    detaVC.listModel = listModel;
    
    [self showDetailViewController:nar sender:nil];
    
}


#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 156;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
    
    ListCategory *listModel= self.dataArray[indexPath.row];
    
    cell.listModel = listModel;
    
    return cell;
}


#pragma mark -- lazy load
- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

@end
