//
//  HICategoriesTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 2/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICategoriesTableViewController.h"
#import "HICheckListQuestionsViewController.h"
#import "HICategoryCell.h"
#import "UIColor-Expanded.h"

@interface HICategoriesTableViewController ()
    - (void)configureCategoryCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation HICategoriesTableViewController

    - (void)configureCategoryCell:(HICategoryCell *)cell atIndexPath:(NSIndexPath *)indexPath {
        //get the category
        HICheckListCategoryModel *category = [self.checkListModel categoryAtIndex:indexPath.row];

        cell.categoryLabel.text = [@"" stringByAppendingString:category.name];

        cell.assets = [self.checkListAnswers numberOfAssetsForCategory:category];
        cell.challenges = [self.checkListAnswers numberOfChallengesForCategory:category];
        cell.unanswered = [self.checkListAnswers numberNotCompletedForCategory:category];

        cell.assetsLabel.text = [NSString stringWithFormat:@"%d", cell.assets];
        cell.challengesLabel.text = [NSString stringWithFormat:@"%d", cell.challenges];
        cell.unansweredLabel.text = [NSString stringWithFormat:@"%d", cell.unanswered];

        //float score = (assets / challenges) * 100;

        if (cell.assets > cell.challenges) {
            [cell isAsset];
        } else if (cell.challenges > cell.assets) {
            [cell isChallenge];
        }

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }

#pragma mark - Table view data source

    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.checkListModel.categoriesCount;

    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"HICategoryCell";
        HICategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell == nil) {
            cell = [[HICategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        [self configureCategoryCell:cell atIndexPath:indexPath];
        return cell;
    }

    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 70.0;
    }

    - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
        //HICheckListQuestionModel *question = [self.categoryModel getQuestionAtIndex:indexPath.section];
        //cell.textLabel.textColor = [self.checkListAnswers textColourForAnswerToQuestion:question.key forTemplateQuestion:question];
        UIColor *backColour;// = [[self.checkListModel.] colorByChangingAlphaTo:0.5];

        HICategoryCell *catCell = (HICategoryCell *) cell;
        if (catCell.assets > catCell.challenges) {
            backColour = self.checkListModel.goodAnswerBackColour;
        } else if (catCell.challenges > catCell.assets) {
            backColour = self.checkListModel.badAnswerBackColour;
        } else {
            backColour = self.checkListModel.noAnswerBackColour;
        }

        ((UACellBackgroundView *) cell).bottomColor = [backColour colorByChangingAlphaTo:0.5];
        for (UIView *view in cell.contentView.subviews) {
            view.backgroundColor = [UIColor clearColor];
        }
    }

#pragma mark - Table view delegate

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        HICheckListQuestionsViewController *detailViewController = [[HICheckListQuestionsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        detailViewController.managedObjectContext = self.managedObjectContext;
        detailViewController.categoryModel = [self.checkListModel categoryAtIndex:indexPath.row];
        detailViewController.checkListAnswers = self.checkListAnswers;

        [self.navController pushViewController:detailViewController animated:YES];
    }

@end
