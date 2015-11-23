//
//  HotModel.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
  
}

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    
    self = [[HotModel alloc] init];
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}
@end
