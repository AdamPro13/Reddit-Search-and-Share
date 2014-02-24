//
//  RSSFavoritePostCell.m
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/23/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSFavoritePostCell.h"

@implementation RSSFavoritePostCell

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

- (void)setUpCellForPost:(RedditPost *)post
{
    [self setUpUI];
    self.titleLabel.text = post.title;
    self.authorLabel.text = post.author;
    self.post = post;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        UIImage *thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:post.imageUrl]]];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            self.thumbnailImage.image = thumbnail;
        });
    });
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont fontWithName:@"bebasneue" size:22];
    self.authorLabel.font = [UIFont fontWithName:@"bebasneue" size:14];
    
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.authorLabel.textColor = [UIColor lightGrayColor];
}

@end
