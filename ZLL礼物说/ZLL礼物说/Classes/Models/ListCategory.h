//
//  ListCategory.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListCategory : NSObject

@property (nonatomic, retain) NSString *content_url;
@property (nonatomic, retain) NSString *cover_image_url;
@property (nonatomic, retain) NSString *likes_count;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *url;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
