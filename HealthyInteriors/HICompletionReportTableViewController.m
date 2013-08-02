//
//  HICompletionReportTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 26/05/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICompletionReportTableViewController.h"

@interface HICompletionReportTableViewController ()

@end

@implementation HICompletionReportTableViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        self.navigationItem.title = @"Incomplete Questions";
        self.title = @"Incomplete";
        self.backTitle = @"Incomplete";

    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    - (BOOL)isAnswerToQuestionEligibleForDisplay:(HICheckListQuestionModel *)question {

        AnswerState answer = [self.checkListAnswers getAnswerStateForQuestion:question.key];
        return answer == AnswerStateNotAnswered || answer == AnswerStateNotApplicable;
    }

    - (int)countOfRowsForTemplate {
        return [self.checkListAnswers numberNotCompletedForCheckList:self.checkList];
    }

    - (HIQuestionViewDataSource *)parentDataSourceForQuestion:(HICheckListQuestionModel *)question {
        return self;
    }

@end
