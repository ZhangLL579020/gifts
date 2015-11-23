//
//  DataManage.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Block)(id block);
@interface DataManager : NSObject

@property (nonatomic, retain)NSMutableArray *dataArray;

@property (nonatomic, copy)Block block;
//创建单例
+ (instancetype) sharedManage;

-(void)sharedData:(NSString *)url block:(Block)block;

@end
