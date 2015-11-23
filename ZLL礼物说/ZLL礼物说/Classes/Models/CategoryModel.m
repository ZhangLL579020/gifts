//
//  CategoryModel.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
}

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    
    self = [[CategoryModel alloc] init];
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

@end
