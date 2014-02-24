//
//  RSSPostCell.h
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

@class RSSRedditPost;

@interface RSSPostCell : UITableViewCell

@property BOOL isFavorited;
@property (nonatomic, strong) RSSRedditPost *post;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIImageView *favoriteStarImage;

- (void)setCellForRedditPost:(RSSRedditPost *)post;
- (void)favoriteCell;
- (void)unfavoriteCell;

@end
