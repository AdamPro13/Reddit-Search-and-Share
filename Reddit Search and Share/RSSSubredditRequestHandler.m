//
//  RSSSubredditRequestHandler.m
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSSubredditRequestHandler.h"
#import "RSSRedditPost.h"

@implementation RSSSubredditRequestHandler

+ (RSSSubredditRequestHandler *)handlerForSender:(NSObject <RSSRequestDelegate> *)sender
{
    RSSSubredditRequestHandler *handler = [RSSSubredditRequestHandler alloc];
    handler.delegate = sender;
    handler.requestString = [NSString stringWithFormat:@"%@%@/.json", [RSSSubredditRequestHandler baseUrl], @"funny"];
    
    return handler;
}

- (void)setUpRequestForSubreddit:(NSString *)subreddit
{
    self.requestString = [NSString stringWithFormat:@"%@%@/.json", [RSSSubredditRequestHandler baseUrl], subreddit];
}

- (void)requestDidFinishWithData:(id)data
{
    NSDictionary *root = [data valueForKey:@"data"];
    NSArray *posts = [root valueForKey:@"children"];
    
    NSMutableArray *postsToReturn = [[NSMutableArray alloc] initWithCapacity:[posts count]];
    
    for (NSDictionary *postHeader in posts)
    {
        NSDictionary *postInfo = [postHeader valueForKey:@"data"];
        RSSRedditPost *post = [[RSSRedditPost alloc] initWithDictionary:postInfo];
        
        [postsToReturn addObject:post];
    }
    
    [self.delegate requestEndedWithData:postsToReturn forRequest:self.requestString];
}

- (void)sendRequest
{
    [self sendRequestWithString:self.requestString];
}

@end
