//
//  HICheckListQuestionDetailViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 9/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListQuestionDetailViewController.h"

@interface HICheckListQuestionDetailViewController ()

@end

@implementation HICheckListQuestionDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Question";
    self.QuestionLabel.text = self.questionModel.text;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
