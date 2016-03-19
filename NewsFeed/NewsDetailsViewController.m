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

@interface NewsDetailsViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UITextView *bodyTextView;
@end

@implementation NewsDetailsViewController
#pragma mark - Update UI
- (void) updateUI {
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    self.subtitleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    self.iconImageView.layer.cornerRadius = CGRectGetWidth(self.iconImageView.frame)/2.0f;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.iconImageView.layer.borderWidth = 3.0f;
    
    if(self.newsItem) {
        self.title = self.newsItem.newsSubTitle;
        [self.iconImageView setImageWithURL:self.newsItem.newsImageUrl placeholderImage:[UIImage imageNamed:@"news.png"]];
        self.titleLabel.text = self.newsItem.newsTitle;
        self.subtitleLabel.text = self.newsItem.newsSubTitle;
        self.bodyTextView.text = self.newsItem.newsBody;
    }
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end