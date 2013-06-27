//
//  HIReportsTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 2/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIReportsTableViewController.h"
#import "HICompletionReportTableViewController.h"
#import "HIAssetsReportTableViewController.h"
#import "HIChallengesReportTableViewController.h"
#import "HIReportTypeCell.h"
#import "UIColor-Expanded.h"

@interface HIReportsTableViewController ()
    @property(nonatomic, strong) NSArray *reportNames;
    @property(nonatomic, strong) NSArray *reportDetails;
    @property(nonatomic, strong) NSArray *reportViews;
    @property(nonatomic, strong) NSArray *reportBackColours;
    @property(nonatomic, strong) NSArray *reportTextColours;

    - (void)configureReportCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation HIReportsTableViewController
    - (id)initWithCheckListAnswers:(CheckListAnswers *)checkListAnswers checkListModel:(HICheckListModel *)checkListModel {
        self = [super initWithCheckListAnswers:checkListAnswers checkListModel:checkListModel];
        if (self) {

            self.reportNames = [[NSArray alloc] initWithObjects:
                    @"Assets Results",
                    @"Challenge Results",
                    @"Incomplete Questions",
                    nil];

            self.reportDetails = [[NSArray alloc] initWithObjects:
                    @"This list shows all the areas that are healthy assets",
                    @"This list shows all the areas that are potential health challenges",
                    @"This list shows all the questions that have not yet been answered",
                    nil];

            self.reportViews = [[NSArray alloc] initWithObjects:
                    [[HIAssetsReportTableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    [[HIChallengesReportTableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    [[HICompletionReportTableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    nil];
            self.reportBackColours = [[NSArray alloc] initWithObjects:
                    [self.checkListModel.goodAnswerBackColour colorByChangingAlphaTo:0.5],
                    [self.checkListModel.badAnswerBackColour colorByChangingAlphaTo:0.5],
                    [self.checkListModel.noAnswerBackColour colorByChangingAlphaTo:0.5],
                    nil];

            self.reportTextColours = [[NSArray alloc] initWithObjects:
                    self.checkListModel.goodAnswerTextColour,
                    self.checkListModel.badAnswerTextColour,
                    self.checkListModel.noAnswerTextColour,
                    nil];

        }

        return self;
    }

    + (id)controllerWithCheckListAnswers:(CheckListAnswers *)checkListAnswers checkListModel:(HICheckListModel *)checkListModel {
        return [super controllerWithCheckListAnswers:checkListAnswers checkListModel:checkListModel];
    }

//] checkList:self.checkListModel checkListAnswers:self.checkListAnswers managedObjectContext:self.managedObjectContext],

    - (void)configureReportCell:(HIReportTypeCell *)cell atIndexPath:(NSIndexPath *)indexPath {
        cell.titleLabel.text = [self.reportNames objectAtIndex:indexPath.row];
        cell.descriptionLabel.text = [self.reportDetails objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        HIReportTableViewController *report = [self.reportViews objectAtIndex:indexPath.row];
        cell.countLabel.text = @""; // [NSString stringWithFormat:@"%d", [report countOfRowsForTemplate:self.checkListModel withAnswers:self.checkListAnswers]];

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

    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 100;
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"ReportCell";
        HIReportTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell == nil) {
            cell = [[HIReportTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        [self configureReportCell:cell atIndexPath:indexPath];
        return cell;
    }

    - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
        cell.textLabel.textColor = [self.reportTextColours objectAtIndex:indexPath.row];
        UIColor *backColour = [self.reportBackColours objectAtIndex:indexPath.row];
        cell.backgroundColor = backColour;
        for (UIView *view in cell.contentView.subviews) {
            view.backgroundColor = [UIColor clearColor];
        }
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
        vc.managedObjectContext = self.managedObjectContext;
        vc.checkList = self.checkListModel;
        vc.checkListAnswers = self.checkListAnswers;
        [vc requery];
        [self.navController pushViewController:vc animated:YES];

    }

@end
