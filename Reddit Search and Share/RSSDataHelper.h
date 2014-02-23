//
//  RSSPostDataHelper.h
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

@class RedditPost;
@class RSSRedditPost;

@interface RSSDataHelper : NSObject

+ (RedditPost *)createPostForRedditPost:(RSSRedditPost *)postToSave;
+ (RedditPost *)getPostForPostId:(NSString *)postId;
+ (void)deletePost:(RedditPost *)post;
+ (NSArray *)getFavoritePosts;

@end
