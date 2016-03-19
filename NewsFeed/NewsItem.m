//
//  NewsItem.m
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import "NewsItem.h"

static NSString * const kNewsItemKeyTitle = @"title";
static NSString * const kNewsItemKeySubTitle = @"subtitle";
static NSString * const kNewsItemKeyBody = @"body";
static NSString * const kNewsItemKeyImage = @"image";

@interface NewsItem ()

@end

@implementation NewsItem
- (instancetype) initWithNewsDictionary:(NSDictionary *)newsDictionary {
    self = [super init];
    if(self) {
        _newsTitle = [self objectIfKey:kNewsItemKeyTitle inDictionary:newsDictionary];
        _newsSubTitle = [self objectIfKey:kNewsItemKeySubTitle inDictionary:newsDictionary];
        _newsBody = [self objectIfKey:kNewsItemKeyBody inDictionary:newsDictionary];
        _newsImageUrl = [NSURL URLWithString:[self objectIfKey:kNewsItemKeyImage inDictionary:newsDictionary]];
    }
    return self;
}

- (NSString *) objectIfKey:(NSString *)key inDictionary:(NSDictionary *)dictionary {
    return (([dictionary objectForKey:key] && [dictionary objectForKey:key] != [NSNull null]) ? [dictionary objectForKey:key] : @"");
}
@end