//
//  NewsFeedTableViewCell.h
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsItem;

@interface NewsFeedTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *subtitleLabel;

- (void) configureCellWithNewsItem:(NewsItem *)newsItem;
@end