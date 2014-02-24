//
//  RSSFavoritesViewController.m
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSFavoritesViewController.h"
#import "RSSDataHelper.h"
#import "RedditPost.h"
#import "RSSFavoritePostCell.h"

@interface RSSFavoritesViewController ()

@property (nonatomic, strong) NSArray *posts;

@end

@implementation RSSFavoritesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.posts = [RSSDataHelper getFavoritePosts];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.posts = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RSSFavoritePostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[RSSFavoritePostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    [cell setUpCellForPost:[self.posts objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSFavoritePostCell *cell = (RSSFavoritePostCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self presentActivityControllerForPost:cell];
    [cell setSelected:NO animated:YES];
}

- (void)setUpUI
{
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
}

- (void)presentActivityControllerForPost:(RSSFavoritePostCell *)postCell
{
    NSString *shareString = postCell.post.title;
    UIImage *shareImage = postCell.thumbnailImage.image;
    NSArray *activityItems = [NSArray arrayWithObjects:shareString, shareImage, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

@end
