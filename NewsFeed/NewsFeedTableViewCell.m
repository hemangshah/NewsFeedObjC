//
//  NewsFeedTableViewCell.m
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import "NewsFeedTableViewCell.h"

@implementation NewsFeedTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.lblTitle.font = [UIFont boldSystemFontOfSize:16.0f];
    self.lblSubtitle.font = [UIFont systemFontOfSize:14.0f];
    self.imgViewIcon.layer.cornerRadius = 5.0f;
    self.imgViewIcon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end