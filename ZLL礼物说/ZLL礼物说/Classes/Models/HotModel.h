//
//  HotModel.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject

@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *price;
@property (nonatomic, retain)NSString *favorites_count;
@property (nonatomic, retain)NSString *cover_image_url;
@property (nonatomic, retain)NSString *url;
@property (nonatomic, retain)NSString *purchase_url;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
