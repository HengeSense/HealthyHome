//
//  HIReportsTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 2/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIReportsTableViewController.h"
#import "HICompletionReportTableViewController.h"
#import "HIAssestsReportTableViewController.h"
#import "HIChallengesReportTableViewController.h"

@interface HIReportsTableViewController ()
    @property(nonatomic, strong) NSArray *reportNames;
    @property(nonatomic, strong) NSArray *reportDetails;
    @property(nonatomic, strong) NSArray *reportViews;

    - (void)configureReportCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation HIReportsTableViewController

    - (id)init {
        if (self = [super init]) {

            self.reportNames = [[NSArray alloc] initWithObjects:@"Assets Report", @"Challenges Report", @"Completion Report", nil];
            self.reportDetails = [[NSArray alloc] initWithObjects:@"This report shows all the areas that are healthy assets",
                                                                  @"This report shows all the areas that are health challenges",
                                                                  @"This report shows all the questions that have not been answered yet", nil];
            self.reportViews = [[NSArray alloc] initWithObjects:
                    [[HIAssestsReportTableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    [[HIChallengesReportTableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    [[HICompletionReportTableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    nil];
        }
        return self;
    }

    - (void)configureReportCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
        cell.textLabel.text = [self.reportNames objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.reportDetails objectAtIndex:indexPath.row];
    }

#pragma mark - Table view data source

    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.reportNames.count;
    }

    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return self.checkListModel.name;
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"ReportCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }

        [self configureReportCell:cell atIndexPath:indexPath];
        return cell;
    }

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        HIReportTableViewController *vc = [self.reportViews objectAtIndex:indexPath.row];
        vc.checkList = self.checkListModel;
        vc.checkListAnswers = self.checkListAnswers;
        vc.managedObjectContext = self.managedObjectContext;
        [vc requery];
        [self.navController pushViewController:vc animated:YES];

    }

@end
