//
//  FindThoughtViewController.m
//  Natural Thoughts Manager
//
//  Created by Mark O'Flynn on 12/08/11.
//  Copyright 2011 Thales. All rights reserved.
//
// some search code from:
// http://jduff.github.com/2010/03/01/building-a-searchview-with-uisearchbar-and-uitableview/
// and
// http://www.raywenderlich.com/999/core-data-tutorial-how-to-use-nsfetchedresultscontroller
//

#import "FindInfoViewController.h"

@interface FindInfoViewController ()
    - (void)searchBar:(UISearchBar *)theSearchBar activate:(BOOL)active;

    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

    - (void)searchTextDidChange:(NSString *)searchText;
@end

@implementation FindInfoViewController
    @synthesize searchBar;
    @synthesize tableView;
    @synthesize managedObjectContext;
    @synthesize tableData = _tableData;
    @synthesize cellNib;

    - (id)initWithTabBar {
        if ([self init]) {

            NSLog(@"%s", __FUNCTION__);

            self.title = @"Remember";

            self.tabBarItem.image = [UIImage imageNamed:@"search.png"];

            self.navigationItem.title = self.title;

            self.tableData = [[NSMutableArray alloc] init];

        }

        return self;

    }

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)didReceiveMemoryWarning {
        // Releases the view if it doesn't have a superview.
        [super didReceiveMemoryWarning];

        // Release any cached data, images, etc that aren't in use.
    }

#pragma mark - View lifecycle

    - (void)viewDidLoad {
        [super viewDidLoad];
        [self searchTextDidChange:@""];

    }

    - (void)viewDidAppear:(BOOL)animated {
        [self.searchBar becomeFirstResponder];
        [super viewDidAppear:animated];
    }

    - (void)viewDidUnload {
        [self setSearchBar:nil];
        [self setTableView:nil];
        [super viewDidUnload];

    }

    - (void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
        [theSearchBar setShowsCancelButton:YES animated:YES];
    }

    - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
        [self searchTextDidChange:searchText];
    }

    - (void)searchTextDidChange:(NSString *)searchText {
        NSPredicate *predicate = nil;
        NSString *sc = [NSString stringWithFormat:@"%@", searchText];

        if ([sc isEqualToString:@""]) {
            //[self.fetchedResultsController.fetchRequest setPredicate:nil];
        }
        else {
            predicate = [NSPredicate predicateWithFormat:@"(thought contains[cd] %@)", sc];
            //[self.fetchedResultsController.fetchRequest setPredicate:predicate];
        }

        NSError *error = nil;
        //[NSFetchedResultsController deleteCacheWithName:nil];

//    if (![[self fetchedResultsController] performFetch:&error]) {
//        // Handle error
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        exit(-1);  // Fail
//    }           

        [self.tableView reloadData];
    }

    - (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar {
        theSearchBar.text = @"";

        [theSearchBar setShowsCancelButton:NO animated:YES];
        [theSearchBar resignFirstResponder];
        self.tableView.allowsSelection = YES;
        self.tableView.scrollEnabled = YES;
    }

    - (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
        [self searchBar:theSearchBar activate:NO];
    }

    - (void)searchBar:(UISearchBar *)theSearchBar activate:(BOOL)active {
        self.tableView.allowsSelection = !active;
        self.tableView.scrollEnabled = !active;
        if (!active) {
            //[disableViewOverlay removeFromSuperview];
            [theSearchBar resignFirstResponder];
        } else {
            //self.disableViewOverlay.alpha = 0;
            //[self.view addSubview:self.disableViewOverlay];

            [UIView beginAnimations:@"FadeIn" context:nil];
            [UIView setAnimationDuration:0.5];
            //self.disableViewOverlay.alpha = 0.6;
            [UIView commitAnimations];

            // probably not needed if you have a details view since you
            // will go there on selection
            NSIndexPath *selected = [self.tableView
                    indexPathForSelectedRow];
            if (selected) {
                [self.tableView deselectRowAtIndexPath:selected
                                              animated:NO];
            }
        }
        [theSearchBar setShowsCancelButton:active animated:YES];
    }

//- (void)configureCell:(FindThoughtResultCellView *)cell atIndexPath:(NSIndexPath *)indexPath {
//    Thought *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    [cell configureCellWithThought:info];
//}

    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
        return 45.0;
    }

    - (NSInteger)tableView:(UITableView *)thisTableView numberOfRowsInSection:(NSInteger)section {
        //id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return 0;//[sectionInfo numberOfObjects];
    }

    - (UITableViewCell *)tableView:(UITableView *)thisTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    FindThoughtResultCellView *cell = [FindThoughtResultCellView cellForTableView:tableView fromNib:self.cellNib];
//    [self configureCell:cell atIndexPath:indexPath];
//    
//    return cell;

    }

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DisplayThoughtViewController *detailViewController = [[DisplayThoughtViewController alloc] init];
//    Thought *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    [detailViewController configureViewWithThought:info];
//    [self.navigationController pushViewController:detailViewController animated:YES];
    }

#pragma mark - TableView Editing

    - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
        return UITableViewCellEditingStyleDelete;
    }

    - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
        return YES;
    }

#pragma mark - Accessors

    - (UINib *)cellNib {
        if (cellNib == nil) {
            //self.cellNib = [FindThoughtResultCellView nib];
        }
        return cellNib;
    }

@end
