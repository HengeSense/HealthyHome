//
//  HIViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListsTableViewController.h"
#import "HICheckListCategoriesViewController.h"

@interface HICheckListsTableViewController ()
    @property(nonatomic, strong) UIBarButtonItem *createListButton;
    @property(nonatomic, strong) CMPopTipView *hintPopup;

    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

    - (void)pushDetailView:(HICheckListModel *)checkListModel answers:(CheckListAnswers *)answers;
@end

@implementation HICheckListsTableViewController

    - (id)initWithStyle:(UITableViewStyle)style {
        self = [super initWithStyle:style];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];
        self.navigationItem.title = @"My Checklists";

        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;

        self.createListButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showNewCheckList)];

        self.navigationItem.rightBarButtonItem = self.createListButton;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }

    - (void)viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:animated];

    }

    - (void)viewDidAppear:(BOOL)animated {
        [super viewDidAppear:animated];
        int sections = [[self.fetchedResultsController sections] count];
/*
        if (sections == 0) {
            [self showPopTipView];
        }
*/

    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

#pragma mark - New Checklist

    - (void)showNewCheckList {

        HICheckListModel *model = [self.templateDelegate checkListWithIndex:0];

        HINewCheckListDetailViewController *detailViewController = [[HINewCheckListDetailViewController alloc] init];
        detailViewController.delegate = self;
        detailViewController.model = model;
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:detailViewController];
        [self presentViewController:nc animated:YES completion:nil];

/* temporary deletion until in app purchases are enabled
        HINewCheckListViewController *newc = [[HINewCheckListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newc];
        newc.delegate = self;
        newc.templateManagerDelegate = self.templateDelegate;

        [self presentViewController:nc animated:YES completion:nil];
*/
    }

#pragma mark - Fetched results controller

    - (NSFetchedResultsController *)fetchedResultsController {
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController;
        }

        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CheckListAnswers" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];

        // Set the batch size to a suitable number.
        [fetchRequest setFetchBatchSize:20];

        // Edit the sort key as appropriate.
        NSSortDescriptor *sortListIDDescriptor = [[NSSortDescriptor alloc] initWithKey:@"checkListID" ascending:NO];
        NSSortDescriptor *sortDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sortListIDDescriptor, sortDateDescriptor, nil];

        [fetchRequest setSortDescriptors:sortDescriptors];

        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"checkListID" cacheName:@"Master"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;

        NSError *error = nil;
        if (![self.fetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

        return _fetchedResultsController;
    }

    - (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
        [self.tableView beginUpdates];
    }

    - (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
               atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
        switch (type) {
            case NSFetchedResultsChangeInsert:
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
                break;

            case NSFetchedResultsChangeDelete:
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
                break;
        }
    }

    - (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
           atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
          newIndexPath:(NSIndexPath *)newIndexPath {
        UITableView *tableView = self.tableView;

        switch (type) {
            case NSFetchedResultsChangeInsert:
                [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;

            case NSFetchedResultsChangeDelete:
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;

            case NSFetchedResultsChangeUpdate:
                [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
                break;

            case NSFetchedResultsChangeMove:
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
        }
    }

    - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
        [self.tableView endUpdates];
    }

    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

        CheckListAnswers *answers = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"Configuring Cell in Section %d for CheckList Answers: %@", indexPath.section, answers.checkListID);

        NSString *address = @"Unknown";
        if (![answers.address isEqualToString:@""]) {
            address = answers.address;
        }
        cell.textLabel.text = address;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:answers.creationDate
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];

        cell.detailTextLabel.text = dateString;
    }

#pragma mark - Table view data source

    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        int count = [[self.fetchedResultsController sections] count];
        NSLog(@"Number of sections:%d", count);
        return count;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        int numberOfItems = [sectionInfo numberOfObjects];
        return numberOfItems;
    }

    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        if ([[self.fetchedResultsController sections] count] > section) {
            id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
            HICheckListModel *template = [self.templateDelegate checkListWithID:[sectionInfo name]];
            return template.name;
        }

        return @"";
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }

        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }

    - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
        return YES;
    }

    - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
            [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];

            NSError *error = nil;
            if (![context save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }

    - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
        return NO;
    }

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

#pragma mark - Table view delegate

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        CheckListAnswers *answers = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [self pushDetailView:[self.templateDelegate checkListWithID:answers.checkListID] answers:answers];

//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//	    if (!self.detailViewController) {
//	        self.detailViewController = [[HIDetailViewController alloc] initWithNibName:@"HIDetailViewController_iPhone" bundle:nil];
//	    }
//        self.detailViewController.detailItem = object;
//        [self.navigationController pushViewController:self.detailViewController animated:YES];
//    } else {
//        self.detailViewController.detailItem = object;
//    }
    }

    - (void)requestCreationOfCheckList:(HICheckListModel *)checkListModel withAddress:(NSString *)address {
        //[self dismissPopTipView];

        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
        CheckListAnswers *answers = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];

        answers.creationDate = [NSDate date];
        answers.checkListID = checkListModel.key;
        if (address != nil) {
            answers.address = address;
        }

        NSError *error = nil;
        if (![context save:&error]) {

            /*
             Replace this implementation with code to handle the error appropriately.

             abort() causes the application to generate a crash log and terminate.
             You should not use this function in a shipping application, although it may be useful during development.
             If it is not possible to recover from the error,
             display an alert panel that instructs the user to quit the application by pressing the Home button.
             */

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [self pushDetailView:checkListModel answers:answers];
    }

    - (void)pushDetailView:(HICheckListModel *)checkListModel answers:(CheckListAnswers *)answers {
        HICheckListCategoriesViewController *vc = [[HICheckListCategoriesViewController alloc] initWithStyle:UITableViewStyleGrouped];
        vc.managedObjectContext = self.managedObjectContext;
        vc.checkListModel = checkListModel;
        vc.checkListAnswers = answers;
        [self.navigationController pushViewController:vc animated:YES];
    }

/*
    - (void)showPopTipView {
        NSString *message = @"Press + to create a new Healthy Home Checklist.";
        CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:message];
        popTipView.delegate = self;
        popTipView.dismissTapAnywhere = YES;
        //[popTipView autoDismissAnimated:YES atTimeInterval:5.0];
        [popTipView presentPointingAtBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];

        self.hintPopup = popTipView;
    }

    - (void)dismissPopTipView {
        if (self.hintPopup != nil) {
            [self.hintPopup dismissAnimated:NO];
            self.hintPopup = nil;
        }
    }

#pragma mark CMPopTipViewDelegate methods
    - (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView {
        self.hintPopup = nil;
    }
*/

    - (void)viewController:(UIViewController *)viewController didDismissOKWithAddress:(NSString *)address {
        HICheckListModel *model = ((HINewCheckListDetailViewController *) viewController).model;
        [self dismissViewControllerAnimated:YES completion:^(void) {
            [self requestCreationOfCheckList:model withAddress:(NSString *) address];
        }];

    }

@end
