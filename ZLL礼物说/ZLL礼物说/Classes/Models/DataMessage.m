//
//  dataMessage.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "dataMessage.h"

@implementation DataMessage

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
        self.ID = value;
    }
}

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    
    self = [[DataMessage alloc] init];
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

@end
