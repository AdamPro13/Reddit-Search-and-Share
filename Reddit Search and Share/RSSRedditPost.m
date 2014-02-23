//
//  RSSRedditPost.m
//  
//
//  Created by Adam Proschek on 2/22/14.
//
//

#import "RSSRedditPost.h"

@implementation RSSRedditPost

- (id)initWithDictionary:(NSDictionary *)postInfo
{
    self = [RSSRedditPost alloc];
    self.author = [postInfo valueForKey:@"author"];
    self.title = [postInfo valueForKey:@"title"];
    self.imageUrl = [postInfo valueForKey:@"thumbnail"];
    self.score = [[postInfo valueForKey:@"score"] integerValue];
    self.postId = [postInfo valueForKey:@"id"];
    
    return self;
}

@end
