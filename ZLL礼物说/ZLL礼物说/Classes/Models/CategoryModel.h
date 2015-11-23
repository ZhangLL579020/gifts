//
//  CategoryModel.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, retain) NSString *group_id;
@property (nonatomic, retain) NSString *icon_url;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *items_count;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *order;
@property (nonatomic, retain) NSString *status;
- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
