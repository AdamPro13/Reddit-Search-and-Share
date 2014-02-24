//
//  RSSFavoritePostCell.h
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/23/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RedditPost.h"

@interface RSSFavoritePostCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) RedditPost *post;

- (void)setUpCellForPost:(RedditPost *)post;

@end
