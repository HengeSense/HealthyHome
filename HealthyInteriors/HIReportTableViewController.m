//
//  HICompletionTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 26/05/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIReportTableViewController.h"
#import "HICheckListQuestionDetailViewController.h"
#import "UIColor-Expanded.h"
#import "HIQuestionCell.h"

@interface HIReportTableViewController ()

    @property(nonatomic, strong) NSMutableArray *questions;

    - (void)doContextSave;

    - (CheckListQuestionAnswers *)getAnswerManagedObjectForQuestionID:(NSString *)questionID;

    - (CheckListQuestionAnswers *)createNewAnswerForQuestion:(NSString *)questionID;

@end

@implementation HIReportTableViewController

    - (id)initWithStyle:(UITableViewStyle)style {
        self = [super initWithStyle:style];
        if (self) {
            self.questions = [[NSMutableArray alloc] init];
        }
        return self;
    }

    - (id)initWithStyle:(UITableViewStyle)style checkList:(HICheckListModel *)checkList checkListAnswers:(CheckListAnswers *)checkListAnswers managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
        self = [super initWithStyle:style];
        if (self) {
            self.checkList = checkList;
            self.checkListAnswers = checkListAnswers;
            self.managedObjectContext = managedObjectContext;
            // [self requery];
        }

        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];

        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

    - (void)viewWillAppear:(BOOL)animated {
        self.navigationController.navigationBar.topItem.title = @"Checklist";
        [self requery];
        [super viewWillAppear:animated];
    }

    - (void)viewDidAppear:(BOOL)animated {
        //if there are no questions to display, pop off the nav stack
        if ([self totalNumberOfQuestions] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [super viewDidAppear:animated];
    }

    - (void)requery {

        [self.questions removeAllObjects];

        for (int i = 0; i < self.checkList.categoriesCount; i++) {

            HICheckListCategoryModel *category = [self.checkList categoryAtIndex:i];
            for (int j = 0; j < category.questionsCount; j++) {

                HICheckListQuestionModel *question = [category getQuestionAtIndex:j];

                if ([self isAnswerToQuestionEligibleForDisplay:question]) {
                    [self.questions addObject:question];
                }

            }

        }

        [self.tableView reloadData];

    }

    - (BOOL)isAnswerToQuestionEligibleForDisplay:(HICheckListQuestionModel *)question {
        return NO;
    }

    - (int)countOfRowsForTemplate:(HICheckListQuestionModel *)question withAnswers:(CheckListAnswers *)checkListAnswers {
        return 0;
    }

    - (CheckListQuestionAnswers *)getAnswerManagedObjectForQuestionID:(NSString *)questionID {
        CheckListQuestionAnswers *thisAnswer = [self.checkListAnswers answerToQuestionWithID:questionID];
        if (!thisAnswer) {
            thisAnswer = [self createNewAnswerForQuestion:questionID];
        }

        return thisAnswer;
    }

    - (CheckListQuestionAnswers *)createNewAnswerForQuestion:(NSString *)questionID {
        //add a new answer
        CheckListQuestionAnswers *thisAnswer = [NSEntityDescription insertNewObjectForEntityForName:@"CheckListQuestionAnswers" inManagedObjectContext:self.managedObjectContext];

        thisAnswer.questionID = questionID;
        thisAnswer.questionCheckList = self.checkListAnswers;
        thisAnswer.answer = [NSNumber numberWithInteger:AnswerStateNotAnswered];

        [self doContextSave];

        return thisAnswer;
    }

    - (void)doContextSave {
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
            abort();
        }

        [self.tableView reloadData];
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

#pragma mark - Table view data source

    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        // Return the number of sections.
        return self.questions.count;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"Cell";
        HIQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell == nil) {
            cell = [[HIQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        //get the category
        HICheckListQuestionModel *question = [self.questions objectAtIndex:(NSUInteger) indexPath.section];
        [cell setQuestion:question andAnswer:self.checkListAnswers];
        [cell isFavourite:[self infoIsFavouriteForQuestionWIthKey:question.key]];

        return cell;
    }

    - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
        HICheckListQuestionModel *question = [self.questions objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [self.checkListAnswers textColourForAnswerToQuestion:question.key forTemplateQuestion:question];
        UIColor *backColour = [[self.checkListAnswers backColourForAnswerToQuestion:question.key forTemplateQuestion:question] colorByChangingAlphaTo:0.2];
        cell.backgroundColor = backColour;
        for (UIView *view in cell.contentView.subviews) {
            view.backgroundColor = [UIColor clearColor];
        }
    }

    - (BOOL)infoIsFavouriteForQuestionWIthKey:(NSString *)key {

        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionID = %@", key];
        [request setPredicate:predicate];

        NSError *error = nil;
        NSUInteger count = 0;
        count = [self.managedObjectContext countForFetchRequest:request error:&error];

        return count > 0;

    }

#pragma mark - Table view delegate
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 100;
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
        HICheckListQuestionDetailViewController *detailViewController = [[HICheckListQuestionDetailViewController alloc] init];
        detailViewController.managedObjectContext = self.managedObjectContext;
        detailViewController.checkListAnswers = self.checkListAnswers;
        detailViewController.dataSource = self;
        detailViewController.currentQuestion = indexPath.section;

        //detailViewController.isReportPage = YES;

        [self.navigationController pushViewController:detailViewController animated:YES];
    }

    - (NSInteger)totalNumberOfQuestions {
        //[self requery];
        return self.questions.count;
    }

    - (HICheckListQuestionModel *)questionAtIndex:(NSInteger)index {
        return [self.questions objectAtIndex:index];
    }

    - (NSString *)getBackTitle {
        return self.backTitle;
    }

    - (CheckListQuestionAnswers *)getAnswerForQuestion:(NSString *)questionID {
        CheckListQuestionAnswers *thisAnswer = [self.checkListAnswers answerToQuestionWithID:questionID];
        if (!thisAnswer) {
            thisAnswer = [self createNewAnswerForQuestion:questionID];
        }

        return thisAnswer;
    }

@end
