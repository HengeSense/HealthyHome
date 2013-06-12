//
//  FindThoughtViewController.h
//  Natural Thoughts Manager
//
//  Created by Mark O'Flynn on 12/08/11.
//  Copyright 2011 Thales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindInfoViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {

    NSMutableArray *_tableData;

}

    @property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
    @property(nonatomic, strong) NSMutableArray *tableData;
    @property(nonatomic, strong) IBOutlet UISearchBar *searchBar;
    @property(nonatomic, strong) IBOutlet UITableView *tableView;
    @property(nonatomic, strong) UINib *cellNib;

    - (id)initWithTabBar;

@end
