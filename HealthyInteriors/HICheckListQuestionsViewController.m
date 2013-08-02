//
//  HICheckListQuestionsViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListQuestionsViewController.h"
#import "UIColor-Expanded.h"

@interface HICheckListQuestionsViewController ()
    - (BOOL)infoIsFavouriteForQuestionWIthKey:(NSString *)key;

    - (CheckListQuestionAnswers *)createNewAnswerForQuestion:(NSString *)questionID;
@end

@implementation HICheckListQuestionsViewController

    - (id)initWithStyle:(UITableViewStyle)style {
        self = [super initWithStyle:style];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];
        self.navigationItem.title = self.categoryModel.name;
        self.managedObjectContext = self.checkListAnswers.managedObjectContext;

        self.navigationController.navigationBar.topItem.title = @"Checklist";

    }

    - (void)viewWillAppear:(BOOL)animated {
        [self.tableView reloadData];
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

#pragma mark - Table view data source

    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [self.categoryModel questionsCount];
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"Cell";
        HIQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell == nil) {
            cell = [[HIQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        HICheckListQuestionModel *question = [self.categoryModel getQuestionAtIndex:indexPath.row];
        [cell setQuestion:question andAnswer:self.checkListAnswers];
        [cell isFavourite:[self infoIsFavouriteForQuestionWIthKey:question.key]];

        return cell;
    }

    - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
        HICheckListQuestionModel *question = [self.categoryModel getQuestionAtIndex:indexPath.row];
        HIQuestionCell *thisCell = (HIQuestionCell *) cell;

        thisCell.textLabel.textColor = [self.checkListAnswers textColourForAnswerToQuestion:question.key forTemplateQuestion:question];
        UIColor *backColour = [[self.checkListAnswers backColourForAnswerToQuestion:question.key forTemplateQuestion:question] colorByChangingAlphaTo:0.6];

        if (indexPath.row == 0) {
            [thisCell setPosition:UACellBackgroundViewPositionTop];
        } else if (indexPath.row == [self.categoryModel questionsCount] - 1) {
            [thisCell setPosition:UACellBackgroundViewPositionBottom];
        } else {
            [thisCell setPosition:UACellBackgroundViewPositionMiddle];
        }

        thisCell.bottomColor = backColour;

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

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        HICheckListQuestionDetailViewController *detailViewController = [[HICheckListQuestionDetailViewController alloc] init];

        detailViewController.dataSource = self;
        detailViewController.managedObjectContext = self.managedObjectContext;
        detailViewController.checkListAnswers = self.checkListAnswers;
        detailViewController.currentQuestion = [self.categoryModel.checkList indexOfQuestion:[self.categoryModel getQuestionAtIndex:indexPath.section]];

        [self.navigationController pushViewController:detailViewController animated:YES];

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

    - (NSInteger)totalNumberOfQuestions {
        return self.categoryModel.checkList.totalNumberOfQuestions;
    }

    - (HICheckListQuestionModel *)questionAtIndex:(NSInteger)index {
        return [self.categoryModel.checkList questionAtIndex:index];
    }

    - (CheckListQuestionAnswers *)getAnswerForQuestion:(NSString *)questionID {
        CheckListQuestionAnswers *thisAnswer = [self.checkListAnswers answerToQuestionWithID:questionID];
        if (!thisAnswer) {
            thisAnswer = [self createNewAnswerForQuestion:questionID];
        }

        return thisAnswer;
    }

    - (HIQuestionViewDataSource *)parentDataSourceForQuestion:(HICheckListQuestionModel *)question {
        HICheckListQuestionsViewController *questionsViewController = [[HICheckListQuestionsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        questionsViewController.managedObjectContext = self.managedObjectContext;
        questionsViewController.categoryModel = question.categoryModel;
        questionsViewController.checkListAnswers = self.checkListAnswers;

        return (id) questionsViewController;
    }

    - (NSString *)getBackTitle {
        return self.categoryModel.name;
    }

    - (CheckListQuestionAnswers *)createNewAnswerForQuestion:(NSString *)questionID {
        //add a new answer
        CheckListQuestionAnswers *thisAnswer = [NSEntityDescription insertNewObjectForEntityForName:@"CheckListQuestionAnswers" inManagedObjectContext:self.managedObjectContext];

        thisAnswer.questionID = questionID;
        thisAnswer.questionCheckList = self.checkListAnswers;
        thisAnswer.answer = [NSNumber numberWithInt:AnswerStateNotAnswered];

        [self doContextSave];

        return thisAnswer;
    }

@end
