//
//  RSSFeedViewController.h
//  Reddit Search and Share
//
//  Created by Adam Proschek on 2/22/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "RSSRequestDelegate.h"

@interface RSSFeedViewController : UITableViewController <RSSRequestDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableArray *searchData;
    UISearchBar *subredditSearchBar;
    UISearchDisplayController *searchDisplayController;
}

@end
