//
//  HICategoriesTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 2/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICategoriesTableViewController.h"
#import "HICheckListQuestionsViewController.h"

@interface HICategoriesTableViewController ()
- (void)configureCategoryCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation HICategoriesTableViewController

- (void)configureCategoryCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //get the category
    HICheckListCategoryModel * category = [self.checkListModel categoryAtIndex:indexPath.row];

    //get the total number of questions in the category
    int totalQuestions = [category questionsCount];

    //determine how many questions have been answered
    int answeredCount = 0;
    for (HICheckListQuestionModel * question in category.questions) {

        AnswerState thisAnswer = [self.checkListAnswers getAnswerStateForQuestion:question.key];
        if (thisAnswer == AnswerStateYes || thisAnswer == AnswerStateNo ) {
            answeredCount++;
        }
    }

    cell.textLabel.text = category.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d / %d", answeredCount, totalQuestions];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.checkListModel.categoriesCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    [self configureCategoryCell:cell atIndexPath:indexPath];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HICheckListQuestionsViewController *detailViewController = [[HICheckListQuestionsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    detailViewController.managedObjectContext = self.managedObjectContext;
    detailViewController.categoryModel = [self.checkListModel categoryAtIndex:indexPath.row];
    detailViewController.checkListAnswers = self.checkListAnswers;
    
    [self.navController pushViewController:detailViewController animated:YES];
}

@end
