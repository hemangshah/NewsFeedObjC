//
//  NFHTTPClient.m
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import "NFHTTPClient.h"

static NSString * const kBaseUrl = @"https://api.myjson.com/bins/vfpj";

@interface NFHTTPClient()
@end

@implementation NFHTTPClient
static NFHTTPClient *sharedInstance = nil;
+ (NFHTTPClient *) sharedInstance {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if(!sharedInstance) {
                sharedInstance = [[NFHTTPClient alloc] init];
            }
        });
    return sharedInstance;
}

- (instancetype) init {
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
    if(self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        self.requestSerializer.timeoutInterval = 10.0f;
    }
    return self;
}
@end