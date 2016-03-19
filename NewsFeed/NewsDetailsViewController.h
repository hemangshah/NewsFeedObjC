//
//  NewsDetailsViewController.h
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsItem;

@interface NewsDetailsViewController : UIViewController
- (void) setSelectedNewsItem:(NewsItem *)selectedNewsItem;
@end