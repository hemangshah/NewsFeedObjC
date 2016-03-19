//
//  NewsDetailsViewController.m
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import "NewsDetailsViewController.h"

#import "NewsItem.h"

#import <UIImageView+AFNetworking.h>

@interface NewsDetailsViewController () {
    NewsItem *newsItem;
}
@property (nonatomic, weak) IBOutlet UIImageView *imgViewIcon;
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblSubtitle;
@property (nonatomic, weak) IBOutlet UITextView *txtViewBody;
@end

@implementation NewsDetailsViewController
#pragma mark - Update UI
- (void) updateUI {
    self.title = newsItem.newsSubTitle;
    
    self.lblTitle.font = [UIFont boldSystemFontOfSize:17.0f];
    self.lblSubtitle.font = [UIFont systemFontOfSize:14.0f];
    
    self.imgViewIcon.layer.cornerRadius = CGRectGetWidth(self.imgViewIcon.frame)/2.0f;
    self.imgViewIcon.layer.masksToBounds = YES;
    self.imgViewIcon.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.imgViewIcon.layer.borderWidth = 3.0f;
}

- (void) setNewsData {
    if(newsItem) {
        [self.imgViewIcon setImageWithURL:newsItem.newsImageUrl placeholderImage:[UIImage imageNamed:@"news.png"]];
        self.lblTitle.text = newsItem.newsTitle;
        self.lblSubtitle.text = newsItem.newsSubTitle;
        self.txtViewBody.text = newsItem.newsBody;
    }
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
    [self setNewsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Selected News Item
- (void) setSelectedNewsItem:(NewsItem *)selectedNewsItem {
    if(selectedNewsItem) {
        newsItem = selectedNewsItem;
    }
}
@end