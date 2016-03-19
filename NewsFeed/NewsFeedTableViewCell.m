//
//  NewsFeedTableViewCell.m
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import "NewsFeedTableViewCell.h"

#import "NewsItem.h"

#import <UIImageView+AFNetworking.h>

@implementation NewsFeedTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.subtitleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.iconImageView.layer.cornerRadius = 5.0f;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void) configureCellWithNewsItem:(NewsItem *)newsItem {
    self.titleLabel.text = newsItem.newsTitle;
    self.subtitleLabel.text = newsItem.newsSubTitle;
    [self.iconImageView setImageWithURL:newsItem.newsImageUrl placeholderImage:[UIImage imageNamed:@"news.png"]];
}
@end