//
//  NewsItem.h
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *newsTitle;
@property (nonatomic, strong) NSString *newsSubTitle;
@property (nonatomic, strong) NSString *newsBody;
@property (nonatomic, strong) NSURL *newsImageUrl;

- (instancetype) initWithNewsDictionary:(NSDictionary *)newsDictionary;
@end
