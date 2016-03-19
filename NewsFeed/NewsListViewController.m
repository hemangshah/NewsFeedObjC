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

static NSString * const kNewsItemResponse = @"items";

@interface NewsListViewController () {
    NSMutableArray *arrayNewsItems;
}
@end

@implementation NewsListViewController
#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestNewsFeeds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Requests
- (void) requestNewsFeeds {
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
        NSLog(@"%@", arrayNewsItems);
    }
}
@end