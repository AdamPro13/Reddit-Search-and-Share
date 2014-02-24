//
//  RSSFeedViewController.m
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSFeedViewController.h"
#import "RSSSubredditRequestHandler.h"
#import "RSSPostCell.h"
#import "RSSRedditPost.h"
#import "RSSDataHelper.h"

@interface RSSFeedViewController ()

@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) NSArray *previousSearches;
@property (nonatomic, strong) RSSSubredditRequestHandler *handler;

@end

@implementation RSSFeedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    if (self)
    {
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        searchBar.delegate = self;
        searchBar.showsScopeBar= YES;
        searchBar.placeholder = @"Search for a Subreddit here...";
        searchBar.searchBarStyle = UISearchBarStyleDefault;
        searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        
        searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        searchDisplayController.delegate = self;
        searchDisplayController.searchResultsDataSource = self;
        searchDisplayController.searchResultsDelegate = self;
        searchDisplayController.searchResultsTableView.rowHeight = 70;
        
        searchDisplayController.searchResultsTableView.backgroundColor = [UIColor whiteColor];
        
        self.tableView.tableHeaderView = searchBar;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.handler = [RSSSubredditRequestHandler handlerForSender:self];
    [self.handler sendRequest];
    [self setUpUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.previousSearches = [RSSDataHelper getPreviousSearches];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request handler delegate

- (void)requestEndedWithData:(id)data forRequest:(NSString *)requestUrl
{
    self.posts = data;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return [self.posts count];
    }
    else
    {
        return [searchData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RSSPostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[RSSPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (tableView == self.tableView)
    {
        [cell setCellForRedditPost:[self.posts objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.textLabel.text = [[searchData objectAtIndex:indexPath.row] name];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSPostCell *cell = (RSSPostCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.tableView)
    {
        if (cell.isFavorited)
        {
            [cell unfavoriteCell];
            [RSSDataHelper deletePost:cell.post.savedPost];
        }
        else
        {
            [cell favoriteCell];
            cell.post.savedPost = [RSSDataHelper createPostForRedditPost:cell.post];
        }
    }
    else
    {
        [self searchForSubreddit:cell.textLabel.text];
    }
    
    [cell setSelected:NO animated:YES];
}

#pragma mark - Search delegate

- (void)filterContentForSearchText:(NSString *)searchText
{
    [searchData removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
    searchData = [NSMutableArray arrayWithArray:[self.previousSearches filteredArrayUsingPredicate:predicate]];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchForSubreddit:searchBar.text];
}

- (void)searchForSubreddit:(NSString *)subredditName
{
    [RSSDataHelper saveSearch:subredditName];
    [self.handler setUpRequestForSubreddit:subredditName];
    [self.handler sendRequest];
    [searchDisplayController setActive:NO animated:YES];
}

#pragma mark - Helper methods

- (void)setUpUI
{
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
}

@end
