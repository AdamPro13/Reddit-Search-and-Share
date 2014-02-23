//
//  RSSRequestDelegate.h
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

@protocol RSSRequestDelegate <NSObject>

- (void)requestEndedWithData:(id)data forRequest:(NSString *)requestUrl;

@end
