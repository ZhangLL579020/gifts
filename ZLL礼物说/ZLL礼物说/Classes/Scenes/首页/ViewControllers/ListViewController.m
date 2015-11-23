//
//  ListViewController.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "ListViewController.h"
#import "DataManager.h"
#import "DataMessage.h"
#import "ListViewCell.h"
#import "ListTableViewHead.h"
#import "ShowViewController.h"
#import "TableViewHead.h"
@interface ListViewController ()

@end

@implementation ListViewController

- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ListViewCell" bundle:nil] forCellReuseIdentifier:@"1"];
    //设置头视图
    if ([self.title isEqualToString:@"精品"]) {
//        ListTableViewHead *headView = [[ListTableViewHead alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
//        self.tableView.tableHeaderView = headView;
        
        TableViewHead *headView = [[TableViewHead alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
        self.tableView.tableHeaderView = headView;


    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 156;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
    
    [self kindOfContextWithCell:cell indexPath:indexPath];
    
    
    return cell;
}

- (void) kindOfContextWithCell:(ListViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.title isEqualToString:@"精品"]) {
        
        DataMessage *model = self.array[indexPath.row];
        cell.model =  model;
        
    }else if ([self.title isEqualToString:@"礼物"]){
        DataMessage *model = self.array[indexPath.row];
        cell.model =  model;

        
    }else if ([self.title isEqualToString:@"海淘"]){
        DataMessage *model = self.array[indexPath.row];
        cell.model =  model;

        
    }else if ([self.title isEqualToString:@"美食"]){
        DataMessage *model = self.array[indexPath.row];
        cell.model =  model;

        

    }else if ([self.title isEqualToString:@"数码"]){
        DataMessage *model = self.array[indexPath.row];
        cell.model =  model;

        
    }else if ([self.title isEqualToString:@"运动"]){
        DataMessage *model = self.array[indexPath.row];
        cell.model =  model;

        
    }else if ([self.title isEqualToString:@"涨姿势"]){
        DataMessage *model = self.array[indexPath.row];
        cell.model =  model;

        
    }
}

#pragma mark -- 点击事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    ShowViewController *showVC = [[ShowViewController alloc] init];
//    
    self.nav =[[UINavigationController alloc] initWithRootViewController:showVC];
    
    self.nav.navigationBar.translucent = NO;
    
    DataMessage *model = self.array[indexPath.row];
    
    showVC.model  =  model;

    [self showDetailViewController:self.nav sender:nil];

    
}





@end


