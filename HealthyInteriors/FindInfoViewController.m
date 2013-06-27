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

#import "HIViewController.h"
#import "FindInfoViewController.h"
#import "HIQuestionCell.h"
#import "HISearchResultsCell.h"
#import "NSString+HTML.h"
#import "HIQuestionInfoViewController.h"
#import "Favourites.h"

@interface FindInfoViewController ()
    @property(nonatomic, strong) NSArray *resultsQuestionsData;
    @property(nonatomic, strong) NSArray *resultsTipsData;
    @property(nonatomic, strong) IBOutlet UISearchBar *searchBar;
    @property(nonatomic, strong) IBOutlet UITableView *tableView;
    @property(nonatomic, strong) HICheckListQuestionModel *selectedQuestion;

    - (void)searchBar:(UISearchBar *)theSearchBar activate:(BOOL)active;

    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

    - (void)searchTextDidChange:(NSString *)searchText;
@end

@implementation FindInfoViewController {

}
    @synthesize searchBar;
    @synthesize tableView;
    @synthesize managedObjectContext;
    @synthesize resultsQuestionsData = _resultsQuestionsData;

    - (id)initWithTabBar {
        if (self = [super init]) {

            NSLog(@"%s", __FUNCTION__);

            self.title = @"Search Tips";

            self.tabBarItem.image = [UIImage imageNamed:@"search.png"];

            self.navigationItem.title = self.title;

            self.resultsQuestionsData = [[NSArray alloc] init];
            self.resultsTipsData = [[NSArray alloc] init];

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

    - (void) viewWillDisappear:(BOOL)animated {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
        [super viewWillDisappear:animated];
    }

    - (void)viewDidAppear:(BOOL)animated {
        //[self.searchBar becomeFirstResponder];
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
        //NSPredicate *predicate = nil;
        NSString *sc = [NSString stringWithFormat:@"%@", searchText];

        if ([sc isEqualToString:@""]) {

            self.resultsQuestionsData = [self.templateDelegate searchQuestionsForText:sc];
            self.resultsTipsData = [self.templateDelegate searchInfoForText:sc];
            [self.tableView reloadData];

        } else {

            self.resultsQuestionsData = [self.templateDelegate searchQuestionsForText:sc];
            self.resultsTipsData = [self.templateDelegate searchInfoForText:sc];
            [self.tableView reloadData];
            //predicate = [NSPredicate predicateWithFormat:@"(thought contains[cd] %@)", sc];
            //[self.fetchedResultsController.fetchRequest setPredicate:predicate];
        }

        //NSError *error = nil;
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

    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

//        HICheckListQuestionModel *question = [self.resultsQuestionsData objectAtIndex:indexPath.row];
//        cell.textLabel.text = question.text;
//        return cell;

    }

    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
        return 100.0;
    }

/*
    - (NSString *)tableView:(UITableView *)tableView1 titleForHeaderInSection:(NSInteger)section {
        //return (section == 0) ? @"Tips" : @"Questions";
    }
*/



    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
    }

    - (NSInteger)tableView:(UITableView *)thisTableView numberOfRowsInSection:(NSInteger)section {
        return (section == 0) ? self.resultsTipsData.count : self.resultsQuestionsData.count;
    }

    - (UITableViewCell *)tableView:(UITableView *)thisTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        static NSString *CellIdentifier = @"Cell";
        HISearchResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell == nil) {
            cell = [[HISearchResultsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        if (indexPath.section == 0) {
            HICheckListQuestionModel *question = [self.resultsTipsData objectAtIndex:indexPath.row];
            cell.titleLabel.text = question.infoTitle;
            cell.descriptionLabel.text =  [[[question.information stringByStrippingTags] stringByRemovingNewLinesAndWhitespace] stringByDecodingHTMLEntities];
        } else {
            HICheckListQuestionModel *question = [self.resultsQuestionsData objectAtIndex:indexPath.row];
            cell.titleLabel.text = question.categoryModel.name;
            cell.descriptionLabel.text = question.text;
        }

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        return cell;

    }

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

        if (indexPath.section == 0) {
            HIQuestionInfoViewController *vc = [[HIQuestionInfoViewController alloc] init];
            self.selectedQuestion = [self.resultsTipsData objectAtIndex:indexPath.row];

            vc.questionModel = self.selectedQuestion;
            vc.delegate = self;
            vc.isModal = YES;

            //[self.navigationController pushViewController:vc animated:YES];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nc animated:YES completion:nil];

        }
    }

    - (void)scrollViewWillBeginDragging:(UIScrollView *)activeScrollView {

        [self dismissKeyboard];

    }

    - (void)dismissKeyboard {

        NSLog(@"dismissKeyboard");

        [self.searchBar setShowsCancelButton:NO animated:YES];
        [self.searchBar resignFirstResponder];
        self.tableView.allowsSelection = YES;
        self.tableView.scrollEnabled = YES;

    }

    - (BOOL)doContextSave {

        BOOL result = YES;
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {

            /*
             Replace this implementation with code to handle the error appropriately.

             abort() causes the application to generate a crash log and terminate.
             You should not use this function in a shipping application, although it may be useful during development.
             If it is not possible to recover from the error,
             display an alert panel that instructs the user to quit the application by pressing the Home button.
             */


            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            result = NO;
        }

        [self.tableView reloadData];
        return result;

    }

    - (BOOL)addFavourite {
        Favourites *favourite = [NSEntityDescription insertNewObjectForEntityForName:@"Favourites" inManagedObjectContext:self.managedObjectContext];
        favourite.questionID = self.selectedQuestion.key;
        BOOL itemAdded = [self doContextSave];
        return itemAdded;
    }

    - (BOOL)removeFavourite {

        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionID = %@", self.selectedQuestion.key];
        [request setPredicate:predicate];

        //get the object
        NSError *error = nil;
        NSArray *records = [self.managedObjectContext executeFetchRequest:request error:&error];
        BOOL itemRemoved = NO;
        for (Favourites *item in records) {
            [self.managedObjectContext deleteObject:item];
            itemRemoved = YES;
        }

        return itemRemoved;

    }

    - (BOOL)isFavourite {

        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionID = %@", self.selectedQuestion.key];
        [request setPredicate:predicate];

        NSError *error = nil;
        NSUInteger count = 0;
        count = [self.managedObjectContext countForFetchRequest:request error:&error];

        return count > 0;

    }

@end
