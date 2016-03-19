//
//  NFHTTPClient.h
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NFHTTPClient : AFHTTPRequestOperationManager
+ (NFHTTPClient *) sharedInstance;
@end
