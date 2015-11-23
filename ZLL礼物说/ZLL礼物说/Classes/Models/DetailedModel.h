//
//  DeatledModel.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailedModel : NSObject

@property (nonatomic, retain) NSString *content_url; //web
@property (nonatomic, retain) NSString *cover_image_url; //head image
@property (nonatomic, retain) NSString *title; 
@property (nonatomic, retain) NSString *likes_count;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
