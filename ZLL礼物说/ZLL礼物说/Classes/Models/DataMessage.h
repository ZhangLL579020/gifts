//
//  dataMessage.h
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataMessage : NSObject

@property (nonatomic, retain) NSString *content_url;
//图片网址
@property (nonatomic, retain) NSString *cover_image_url;
@property (nonatomic, retain) NSString *created_at;
@property (nonatomic, retain) NSString *editor_id;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *liked;
//喜欢的人数
@property (nonatomic, retain) NSString *likes_count;
@property (nonatomic, retain) NSString *published_at;
@property (nonatomic, retain) NSString *share_msg;
@property (nonatomic, retain) NSString *short_title;
//标题名字
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *updated_at;
@property (nonatomic, retain) NSString *url;

- (instancetype) initWithDictionary:(NSDictionary *)dic;
@end
