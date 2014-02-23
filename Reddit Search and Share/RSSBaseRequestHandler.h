//
//  RSSBaseRequestHandler.h
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSRequestDelegate.h"

@interface RSSBaseRequestHandler : NSObject

@property (nonatomic, weak) NSObject<RSSRequestDelegate> *delegate;
@property (nonatomic, strong) NSString *requestString;

+ (NSString *)baseUrl;
- (void)requestDidFinishWithData:(id)data;
- (void)sendRequest;
- (void)sendRequestWithString:(NSString *)requestUrlString;

@end
