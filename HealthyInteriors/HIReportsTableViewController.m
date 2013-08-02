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
#import "MSSimpleGauge.h"
#import "MSAnnotatedGauge.h"

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
                    @"Gauge",
                    @"Assets Results",
                    @"Challenge Results",
                    @"Incomplete Questions",
                    nil];

            self.reportDetails = [[NSArray alloc] initWithObjects:
                    @"Gauge",
                    @"This list shows all the areas that are healthy assets",
                    @"This list shows all the areas that are potential health challenges",
                    @"This list shows all the questions that have not yet been answered",
                    nil];

            self.reportViews = [[NSArray alloc] initWithObjects:
                    [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    [[HIAssetsReportTableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    [[HIChallengesReportTableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    [[HICompletionReportTableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                    nil];
            self.reportBackColours = [[NSArray alloc] initWithObjects:
                    [self.checkListModel.noAnswerBackColour colorByChangingAlphaTo:0.5],
                    [self.checkListModel.goodAnswerBackColour colorByChangingAlphaTo:0.5],
                    [self.checkListModel.badAnswerBackColour colorByChangingAlphaTo:0.5],
                    [self.checkListModel.noAnswerBackColour colorByChangingAlphaTo:0.5],
                    nil];

            self.reportTextColours = [[NSArray alloc] initWithObjects:
                    self.checkListModel.noAnswerTextColour,
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

    - (void)configureReportCell:(HIReportTypeCell *)cell atIndexPath:(NSIndexPath *)indexPath {

        cell.titleLabel.text = [self.reportNames objectAtIndex:indexPath.row];
        cell.descriptionLabel.text = [self.reportDetails objectAtIndex:indexPath.row];

        HIReportTableViewController *report = [self.reportViews objectAtIndex:indexPath.row];
        report.managedObjectContext = self.managedObjectContext;
        report.checkList = self.checkListModel;
        report.checkListAnswers = self.checkListAnswers;
        [report requery];

        cell.countLabel.text = [NSString stringWithFormat:@"%d", [report countOfRowsForTemplate]];

        if ([report totalNumberOfQuestions] == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

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

        if (indexPath.row == 0) {

            static NSString *CellIdentifier = @"GaugeCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

                MSAnnotatedGauge *gauge = [[MSAnnotatedGauge alloc] initWithFrame:CGRectMake(70, 10, 150, 80)];
                gauge.startRangeLabel.text = @"";
                gauge.endRangeLabel.font = [UIFont systemFontOfSize:8];
                gauge.endRangeLabel.text = @"Healthy Home";
                gauge.valueLabel.hidden = YES;

                gauge.tag = 101;
                gauge.backgroundColor = [UIColor clearColor];

                [cell.contentView addSubview:gauge];

                cell.backgroundView = [[UACellBackgroundView alloc] initWithFrame:CGRectZero];

            }

            int totalQuestions = self.checkListModel.totalNumberOfQuestions;
            int assets = [self.checkListAnswers numberOfAssetsForCheckList:self.checkListModel];
            float status = (100 * assets) / totalQuestions;
            MSAnnotatedGauge *gauge = [cell viewWithTag:101];
            gauge.fillArcFillColor = self.checkListModel.goodAnswerBackColour;
            [gauge setValue:status animated:YES];

            return cell;

        } else {

            static NSString *CellIdentifier = @"ReportCell";
            HIReportTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

            if (cell == nil) {
                cell = [[HIReportTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }

            [self configureReportCell:cell atIndexPath:indexPath];
            return cell;
        }

    }

    - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

        if (indexPath.row == 0) {

        } else {

            cell.textLabel.textColor = [self.reportTextColours objectAtIndex:indexPath.row];
            UIColor *backColour = [[self.reportBackColours objectAtIndex:indexPath.row] colorWithAlphaComponent:0.5];
            UIColor *textColour = [self.reportTextColours objectAtIndex:indexPath.row];

            ((UACellBackgroundView *) cell).bottomColor = backColour;

            for (UIView *view in cell.contentView.subviews) {
                view.backgroundColor = [UIColor clearColor];
            }
        }
    }

#pragma mark - Table view delegate

    - (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {

        if (indexPath.row == 0) {
            return NO;
        }
        else {
            HIReportTableViewController *vc = [self.reportViews objectAtIndex:indexPath.row];
            return [vc totalNumberOfQuestions] > 0;
        }

    }

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

        if (indexPath.row == 0) {

        } else {
            HIReportTableViewController *vc = [self.reportViews objectAtIndex:indexPath.row];

            if ([vc totalNumberOfQuestions] > 0) {
                [self.navController pushViewController:vc animated:YES];
            }
        }

    }

@end
