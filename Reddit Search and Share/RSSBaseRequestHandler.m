//
//  RSSBaseRequestHandler.m
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSBaseRequestHandler.h"
#import "AFNetworking.h"

@interface RSSBaseRequestHandler ()

@end

@implementation RSSBaseRequestHandler

+ (NSString *)baseUrl
{
    return @"http://www.reddit.com/r/";
}

- (void)requestDidFinishWithData:(id)results
{
    //    Empty - Define for children
}

- (void)sendRequest
{
    //    Empty - Define for children
}

- (void)sendRequestWithString:(NSString *)requestUrlString
{
    NSURL *requestURL  = [NSURL URLWithString:requestUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:requestURL];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestDidFinishWithData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request Failure");
    }];
    [operation start];
}

@end
