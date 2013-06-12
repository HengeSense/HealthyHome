//
//  HIFavouritesTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/06/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIFavouritesTableViewController.h"
#import "Favourites.h"
#import "HIQuestionInfoViewController.h"
#import "HICheckListTemplateDelegate.h"

@interface HIFavouritesTableViewController ()

    @property(nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
    @property(nonatomic, strong) HICheckListQuestionModel *selectedQuestion;

    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

    - (BOOL)doContextSave;

@end

@implementation HIFavouritesTableViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
        self = [super initWithStyle:style];
        if (self) {
            self.managedObjectContext = managedObjectContext;
        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
    }
#pragma mark - Fetched results controller

    - (NSFetchedResultsController *)fetchedResultsController {
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController;
        }

        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];

        // Set the batch size to a suitable number.
        [fetchRequest setFetchBatchSize:20];

        // Edit the sort key as appropriate.
        NSSortDescriptor *sortListIDDescriptor = [[NSSortDescriptor alloc] initWithKey:@"questionID" ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sortListIDDescriptor, nil];

        [fetchRequest setSortDescriptors:sortDescriptors];

        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
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

        Favourites *favourite = [self.fetchedResultsController objectAtIndexPath:indexPath];
        HICheckListQuestionModel *question = [self.templateDelegate findQuestionWithKey:favourite.questionID];
        cell.textLabel.text = question.infoTitle;

    }

#pragma mark - Table view data source

    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        int count = 1;
        return count;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        int numberOfItems = [sectionInfo numberOfObjects];
        return numberOfItems;
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

        HIQuestionInfoViewController *vc = [[HIQuestionInfoViewController alloc] init];
        Favourites *favourite = [self.fetchedResultsController objectAtIndexPath:indexPath];
        self.selectedQuestion = [self.templateDelegate findQuestionWithKey:favourite.questionID];

        vc.questionModel = self.selectedQuestion;
        vc.delegate = self;
        vc.isModal = NO;

        [self.navigationController pushViewController:vc animated:YES];

//        CheckListAnswers *answers = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        [self pushDetailView:[self.templateDelegate checkListWithID:answers.checkListID] answers:answers];

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

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
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
