//
//  NewsListViewController.m
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import "NewsListViewController.h"

#import <UIImageView+AFNetworking.h>

#import "NFHTTPClient.h"

#import "NewsItem.h"

#import "NewsFeedTableViewCell.h"

static NSString * const kNewsItemResponse = @"items";

@interface NewsListViewController () {
    NSMutableArray *arrayNewsItems;
}
@property (nonatomic, weak) IBOutlet UITableView *tblViewList;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation NewsListViewController
#pragma mark - Update UI
- (void) updateUI {
    self.title = @"News Feeds";
    self.tblViewList.tableFooterView = [UIView new];
}

- (void) showIndicator {
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
}

- (void) hideIndicator {
    [self.activityIndicator stopAnimating];
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
    [self requestNewsFeeds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Requests
- (void) requestNewsFeeds {
    [self showIndicator];
    
    //We've subclassed AFHTTPRequestOperationManager (AFNetworking) to handle following GET request.
    //The reason for subclassing is to have a singleton object for requests.
    [[NFHTTPClient sharedInstance] GET:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Yeaah! we got some response.
        [self parseResult:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Ummm. There's some error.
        NSLog(@"%@", error);
    }];
}

#pragma mark - Parse Result
- (void) parseResult:(id)responseObject {
    if(responseObject) {
        //Update arrayNewsItems before adding new NewsItem.
        if(!arrayNewsItems) {
            arrayNewsItems = [NSMutableArray array];
        } else {
            [arrayNewsItems removeAllObjects];
        }
        //Fetch array of items from the response
        NSArray *items = [NSArray arrayWithArray:[responseObject objectForKey:kNewsItemResponse]];
        if(items) {
            //Loop through each item and get a dictionary, later it will become NewsItem.
            for(NSDictionary *newsDictionary in items) {
                //Convert dictionary to NewsItem object.
                //Add into arrayNewsItems.
                [arrayNewsItems addObject:[[NewsItem alloc] initWithNewsDictionary:newsDictionary]];
            }
        }
        
        //If we'll have some data, we then reload the table.
        if([arrayNewsItems count]) {
            [self.tblViewList reloadData];
        }
        
        [self hideIndicator];
    }
}

#pragma mark - UITableView Datasource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayNewsItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsFeedTableViewCell *cell = (NewsFeedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsFeedTableViewCell"];
    [self configureNewsFeedCell:cell forIndexPath:indexPath];
    return cell;
}

- (void) configureNewsFeedCell:(NewsFeedTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    NewsItem *item = [arrayNewsItems objectAtIndex:indexPath.row];
    cell.lblTitle.text = item.newsTitle;
    cell.lblSubtitle.text = item.newsSubTitle;
    [cell.imgViewIcon setImageWithURL:item.newsImageUrl placeholderImage:[UIImage imageNamed:@"news.png"]];
}
@end