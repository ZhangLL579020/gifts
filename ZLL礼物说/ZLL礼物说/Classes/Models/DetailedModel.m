//
//  DeatledModel.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "DetailedModel.h"

@implementation DetailedModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    
    self = [[DetailedModel alloc] init];
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

@end
