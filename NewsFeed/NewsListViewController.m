//
//  NewsListViewController.m
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsDetailsViewController.h"

#import <UIScrollView+EmptyDataSet.h>
#import <AFNetworkReachabilityManager.h>

#import "NFHTTPClient.h"

#import "NewsItem.h"
#import "NewsFeedTableViewCell.h"

static NSString * const kNewsItemResponse = @"items";

@interface NewsListViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    NSMutableArray *newsItems;
}
@property (nonatomic, weak) IBOutlet UITableView *listTableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation NewsListViewController
#pragma mark - Update UI
- (void) updateUI {
    self.title = @"News Feeds";
    self.listTableView.tableFooterView = [UIView new];
    self.listTableView.emptyDataSetSource = self;
    self.listTableView.emptyDataSetDelegate = self;
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

#pragma mark - EmptyDataSet Datasource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = ([AFNetworkReachabilityManager sharedManager].reachable) ? @"No Feeds" : @"No Internet";
    return [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0f]}];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *description = ([AFNetworkReachabilityManager sharedManager].reachable) ? @"Please come back later. We'll surely have some great news for you." : @"It seems that you're not connected to the Internet. Please try again.";
    return [[NSAttributedString alloc] initWithString:description attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"news.png"];
}

#pragma mark - EmptyDataSet Delegate
- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    //If we found that, our array was initiazed only then we'll show empty data set.
    if(newsItems) {
        return YES;
    } else {
        return NO;
    }
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
        [self hideIndicator];
        [self initialization];
        [self.listTableView reloadEmptyDataSet];
    }];
}

#pragma mark - Initialization
- (void) initialization {
    if(!newsItems) {
        newsItems = [NSMutableArray array];
    } else {
        [newsItems removeAllObjects];
    }
}

#pragma mark - Parse Result
- (void) parseResult:(id)responseObject {
    if(responseObject) {
        //Update newsItems before adding new NewsItem.
        [self initialization];
        //Fetch array of items from the response
        NSArray *items = [NSArray arrayWithArray:[responseObject objectForKey:kNewsItemResponse]];
        if(items) {
            //Loop through each item and get a dictionary, later it will become NewsItem.
            for(NSDictionary *newsDictionary in items) {
                //Convert dictionary to NewsItem object.
                //Add into newsItems.
                [newsItems addObject:[[NewsItem alloc] initWithNewsDictionary:newsDictionary]];
            }
        }

        //Hide indicator
        [self hideIndicator];
        
        if(newsItems.count) {
            //If we'll have some data, we then reload the table.
            [self.listTableView reloadData];
        } else {
            //If we'll not have anything, we then reload the table empty dataset.
            [self.listTableView reloadEmptyDataSet];
        }
    }
}

#pragma mark - UITableView Datasource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return newsItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsFeedTableViewCell *cell = (NewsFeedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsFeedTableViewCell"];
    NewsItem *item = [newsItems objectAtIndex:indexPath.row];
    [cell configureCellWithNewsItem:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Deselect Row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //Pass on selected NewsItem to NewsDetailsViewController.
    NewsItem *item = [newsItems objectAtIndex:indexPath.row];
    NewsDetailsViewController *newsDetailsVC = (NewsDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"NewsDetailsViewController"];
    [newsDetailsVC setSelectedNewsItem:item];
    [self.navigationController pushViewController:newsDetailsVC animated:YES];
}
@end