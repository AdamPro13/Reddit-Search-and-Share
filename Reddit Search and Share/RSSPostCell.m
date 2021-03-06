//
//  RSSPostCell.m
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSPostCell.h"
#import "RSSRedditPost.h"
#import "RedditPost.h"
#import "RSSDataHelper.h"

@implementation RSSPostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellForRedditPost:(RSSRedditPost *)post
{
    [self setUpUI];
    self.titleLabel.text = post.title;
    self.authorLabel.text = post.author;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)post.score];
    self.post = post;
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 65)];
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    shareButton.titleLabel.text = @"Share";
    shareButton.backgroundColor = [UIColor blueColor];
    shareView.backgroundColor = [UIColor blackColor];
    
    [shareView addSubview:shareButton];
    [self setEditingAccessoryView:shareView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        UIImage *thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:post.imageUrl]]];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            self.thumbnailImage.image = thumbnail;
        });
    });
    
    RedditPost *postInMemory = [RSSDataHelper getPostForPostId:post.postId];
    
    if (postInMemory != nil)
    {
        [self favoriteCell];
    }
    else
    {
        [self unfavoriteCell];
    }
}

- (void)favoriteCell
{
    self.isFavorited = YES;
    self.favoriteStarImage.image = [UIImage imageNamed:@"starhighlighted"];
}

- (void)unfavoriteCell
{
    self.isFavorited = NO;
    self.favoriteStarImage.image = [UIImage imageNamed:@"star"];
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont fontWithName:@"bebasneue" size:22];
    self.authorLabel.font = [UIFont fontWithName:@"bebasneue" size:14];
    self.scoreLabel.font = [UIFont fontWithName:@"bebasneue" size:12];
    
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.authorLabel.textColor = [UIColor lightGrayColor];
    self.scoreLabel.textColor = [UIColor lightGrayColor];
}

@end
