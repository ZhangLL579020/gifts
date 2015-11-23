//
//  DataManage.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "DataManager.h"

static DataManager *dataManage = nil;

@implementation DataManager

//创建单例
+ (instancetype) sharedManage{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataManage = [DataManager new];
        
        
    });
    return dataManage;
    
}

-(void)sharedData:(NSString *)url block:(Block)block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        block(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(nil);
        
    }];
}

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}







@end
