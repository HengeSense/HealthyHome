//
//  HICheckListQuestionDetailViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 9/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListQuestionDetailViewController.h"
#import "HIQuestionInfoViewController.h"
#import "HIQuestionNotesViewController.h"

#import "CustomBadge.h"

@interface HICheckListQuestionDetailViewController ()
- (void)setUpViewController:(HIQuestionInfoViewController *)vc ;
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
    
    if (self.answerValue == AnswerValueNo) {
        
        self.answerSegmentControl.selectedSegmentIndex = 1;
        
    } else if (self.answerValue == AnswerValueYes) {
        
        self.answerSegmentControl.selectedSegmentIndex = 0;
        
    }
    
    self.infoButton.enabled = ![self.questionModel.information isEqualToString:@""];
    
    if (self.notesExist) {
        
        
        CustomBadge *notesBadge = [CustomBadge customBadgeWithString:@"\u2713"
                                                       withStringColor:[UIColor whiteColor]
                                                        withInsetColor:[UIColor redColor]
                                                        withBadgeFrame:YES
                                                   withBadgeFrameColor:[UIColor whiteColor]
                                                             withScale:1.0
                                                           withShining:YES];
        
        //[notesBadge setFrame:CGRectMake()];
        [self.view addSubview:notesBadge];

    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)answerSelected:(id)sender {
    
    if (self.answerSegmentControl.selectedSegmentIndex == 0) {
        //yes selected
        [self.delegate setValueforQuestionID:self.questionModel.key to:YES];
    } else {
        //no selected
        [self.delegate setValueforQuestionID:self.questionModel.key to:NO];
    }
}

- (void)setUpViewController:(HIQuestionDetailBaseViewController *)vc {
    vc.questionModel = self.questionModel;
    vc.delegate = self.delegate;
}

- (IBAction)infoClicked {
    
    HIQuestionInfoViewController * vc = [[HIQuestionInfoViewController alloc] init];
    [self setUpViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)NotesClicked {
    
    HIQuestionDetailBaseViewController * vc = [[HIQuestionNotesViewController alloc] init];
    [self setUpViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)CameraClicked {
}

- (IBAction)MicrophoneClicked:(id)sender {
}

@end
