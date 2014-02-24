//
//  RSSPostDataHelper.m
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSDataHelper.h"
#import "CoreData+MagicalRecord.h"
#import "RedditPost.h"
#import "PreviousSubredditSearch.h"
#import "RSSRedditPost.h"

@implementation RSSDataHelper

+ (RedditPost *)createPostForRedditPost:(RSSRedditPost *)postToSave
{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    RedditPost *post = [RedditPost MR_createInContext:context];
    post.title = postToSave.title;
    post.author = postToSave.author;
    post.imageUrl = postToSave.imageUrl;
    post.postId = postToSave.postId;
    post.createdDate = [NSDate date];
    
    [context MR_saveToPersistentStoreAndWait];
    
    return post;
}

+ (RedditPost *)getPostForPostId:(NSString *)postId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"postId == %@", postId];
    NSArray *posts = [RedditPost MR_findAllWithPredicate:predicate];
    
    if (posts == nil || [posts count] == 0)
    {
        return nil;
    }
    else
    {
        return [posts lastObject];
    }
}

+ (void)deletePost:(RedditPost *)post
{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    [post MR_deleteInContext:context];
    
    [context MR_saveToPersistentStoreAndWait];
}

+ (NSArray *)getFavoritePosts
{
    NSArray *posts = [RedditPost MR_findAllSortedBy:@"createdDate" ascending:YES];
    
    return posts;
}

+ (NSArray *)getPreviousSearches
{
    NSArray *searches = [PreviousSubredditSearch MR_findAllSortedBy:@"name" ascending:YES];
    
    return searches;
}

+ (PreviousSubredditSearch *)saveSearch:(NSString *)searchString
{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    PreviousSubredditSearch *search = [PreviousSubredditSearch MR_createInContext:context];
    search.name = searchString;
    
    [context MR_saveToPersistentStoreAndWait];
    
    return search;
}

@end
