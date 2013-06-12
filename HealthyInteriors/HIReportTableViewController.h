//
//  HICompletionTableViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 26/05/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HIReportTableViewController : UITableViewController

    @property(nonatomic, strong) HICheckListModel *checkList;
    @property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
    @property(nonatomic, strong) CheckListAnswers *checkListAnswers;
    @property(nonatomic, strong) NSString *backTitle;

    - (void)requery;

    - (BOOL)isAnswerToQuestionEligibleForDisplay:(HICheckListQuestionModel *)question;
@end
