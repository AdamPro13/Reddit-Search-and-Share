//
//  RSSSubredditRequestHandler.h
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSBaseRequestHandler.h"

@interface RSSSubredditRequestHandler : RSSBaseRequestHandler

+ (RSSSubredditRequestHandler *)handlerForSender:(NSObject <RSSRequestDelegate> *)sender;

- (void)setUpRequestForSubreddit:(NSString *)subreddit;

@end
