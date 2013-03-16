//
//  HICheckListQuestionDetailViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 9/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HIQuestionDetailBaseViewController.h"
#import "HICheckListQuestionModel.h"

typedef NS_ENUM(NSInteger, AnswerValue) {
    AnswerValueNone,
    AnswerValueYes,
    AnswerValueNo
};

@protocol HIQuestionDetailDelegate;

@interface HICheckListQuestionDetailViewController : HIQuestionDetailBaseViewController

@property (assign, nonatomic) AnswerValue answerValue;
@property (strong, nonatomic) IBOutlet UILabel *QuestionLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *answerSegmentControl;

- (IBAction)answerSelected:(id)sender;
- (IBAction)infoClicked;
- (IBAction)NotesClicked;
- (IBAction)CameraClicked;
- (IBAction)MicrophoneClicked:(id)sender;

@end
