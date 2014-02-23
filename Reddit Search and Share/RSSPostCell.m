//
//  RSSPostCell.m
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSPostCell.h"
#import "RSSRedditPost.h"

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
    [self setFontsForLabels];
    self.titleLabel.text = post.title;
    self.authorLabel.text = post.author;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)post.score];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        UIImage *thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:post.imageUrl]]];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            self.thumbnailImage.image = thumbnail;
        });
    });
    
//    NSLog(@"Image Size: x:%f y:%f w:%f h:%f", self.thumbnailImage.frame.origin.x, self.thumbnailImage.frame.origin.y, self.thumbnailImage.frame.size.width, self.thumbnailImage.frame.size.height);
}

- (void)setFontsForLabels
{
    self.titleLabel.font = [UIFont fontWithName:@"bebasneue" size:22];
    self.authorLabel.font = [UIFont fontWithName:@"bebasneue" size:14];
    self.scoreLabel.font = [UIFont fontWithName:@"bebasneue" size:12];
}

@end
