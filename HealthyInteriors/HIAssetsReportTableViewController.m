//
//  HIAssetsReportTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 26/05/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIAssetsReportTableViewController.h"

@interface HIAssetsReportTableViewController ()

@end

@implementation HIAssetsReportTableViewController

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
        self.navigationItem.title = @"Asset Results";
        self.title = @"Assets";
        self.backTitle = @"Assets";

    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    - (BOOL)isAnswerToQuestionEligibleForDisplay:(HICheckListQuestionModel *)question {
        return [self.checkListAnswers isAnswerToQuestionAnAsset:question];
    }

    - (int)countOfRowsForTemplate {
        return [self.checkListAnswers numberOfAssetsForCheckList:self.checkList];
    }

    - (HIQuestionViewDataSource *)parentDataSourceForQuestion:(HICheckListQuestionModel *)question {
        return self;
    }

@end
