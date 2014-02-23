//
//  RSSRedditPost.h
//  
//
//  Created by Adam Proschek on 2/22/14.
//
//

@class RedditPost;

@interface RSSRedditPost : NSObject

@property (nonatomic, strong) NSString *postId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *imageUrl;
@property NSInteger score;
@property (nonatomic, weak) RedditPost *savedPost;

- (id)initWithDictionary:(NSDictionary *)postInfo;

@end
