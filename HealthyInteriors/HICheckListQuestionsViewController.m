//
//  HICheckListQuestionsViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListQuestionsViewController.h"
#import "HICheckListQuestionDetailViewController.h"
#import "CheckListQuestionAnswers+HIFunctions.h"

@interface HICheckListQuestionsViewController ()
@end

@implementation HICheckListQuestionsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.categoryModel.name;
    self.managedObjectContext = self.checkListAnswers.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryModel questionsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:17.0];
        [cell.textLabel sizeToFit];}

    //get the category
    HICheckListQuestionModel * question = [self.categoryModel getQuestionAtIndex:indexPath.row];
    cell.textLabel.text = question.text;    
    cell.imageView.image = [self.checkListAnswers largeImageForAnswerToQuestion:question.key forTemplateQuestion:question];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HICheckListQuestionModel * question = [self.categoryModel getQuestionAtIndex:indexPath.row];
    cell.textLabel.textColor = [self.checkListAnswers colourForAnswerToQuestion:question.key forTemplateQuestion:question];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HICheckListQuestionDetailViewController *detailViewController = [[HICheckListQuestionDetailViewController alloc] init];
    HICheckListQuestionModel * questionModel = [self.categoryModel getQuestionAtIndex:indexPath.row];
    detailViewController.questionModel = questionModel;
    detailViewController.delegate = self;
    
    AnswerValue value = AnswerValueNone;
    if ([self.checkListAnswers answerToQuestionExists:questionModel.key]) {
        
        if ([self.checkListAnswers questionHasValidAnswer:questionModel.key]) {
            
            CheckListQuestionAnswers *answer = [self.checkListAnswers answerToQuestionWithID:questionModel.key];
            if ([self.checkListAnswers questionAnsweredYes:questionModel.key]) {
                value = AnswerValueYes;
            } else {
                value = AnswerValueNo;
            }
            detailViewController.notesExist = ![answer.notes isEqualToString:@""];
        }
    }
    detailViewController.AnswerValue = value;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)doContextSave
{
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

- (CheckListQuestionAnswers *)createNewAnswerForQuestion:(NSString *)questionID
{
    //add a new answer
    CheckListQuestionAnswers *thisAnswer = [NSEntityDescription insertNewObjectForEntityForName:@"CheckListQuestionAnswers" inManagedObjectContext:self.managedObjectContext];
    
    thisAnswer.questionID = questionID;
    thisAnswer.questionCheckList = self.checkListAnswers;
    return thisAnswer;
}

- (void) setValueforQuestionID:(NSString *)questionID to:(BOOL)value
{
    CheckListQuestionAnswers *thisAnswer;
    
    if (![self.checkListAnswers answerToQuestionExists:questionID]) {
        
        thisAnswer = [self createNewAnswerForQuestion:questionID];
        
    } else {
        
        thisAnswer = [self.checkListAnswers answerToQuestionWithID:questionID];
        
    }
    
    thisAnswer.answer = [NSNumber numberWithBool:value];
    thisAnswer.questionAnswered = [NSNumber numberWithBool:YES];
    
    [self doContextSave];
}

- (NSString *)getNotesforQuestionID:(NSString *)questionID
{
    CheckListQuestionAnswers *thisAnswer;
    
    if (![self.checkListAnswers answerToQuestionExists:questionID]) {
        
        thisAnswer = [self createNewAnswerForQuestion:questionID];
        
    } else {
        
        thisAnswer = [self.checkListAnswers answerToQuestionWithID:questionID];
        
    }
    
    return thisAnswer.notes;
    
}

- (void) setNotesforQuestionID:(NSString *)questionID to:(NSString *)text
{
    CheckListQuestionAnswers *thisAnswer;
    
    if (![self.checkListAnswers answerToQuestionExists:questionID]) {
        
        thisAnswer = [self createNewAnswerForQuestion:questionID];
        
    } else {
        
        thisAnswer = [self.checkListAnswers answerToQuestionWithID:questionID];
        
    }
    
    thisAnswer.notes = text;
    
    [self doContextSave];
    
}

@end
