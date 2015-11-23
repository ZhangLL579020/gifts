//
//  ListCategory.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "ListCategory.h"

@implementation ListCategory
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    
    self = [[ListCategory alloc] init];
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}
@end
