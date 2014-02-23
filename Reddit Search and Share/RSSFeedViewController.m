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

@interface RSSFeedViewController ()

@property (nonatomic, strong) NSArray *posts;
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
    self.edgesForExtendedLayout = UIRectEdgeTop;
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
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RSSPostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[RSSPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    [cell setCellForRedditPost:[self.posts objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
