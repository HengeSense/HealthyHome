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
@property (assign, nonatomic) BOOL notesExist;

@property (strong, nonatomic) IBOutlet UILabel *QuestionLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *answerSegmentControl;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *notesButton;
@property (strong, nonatomic) IBOutlet UIButton *cameraButton;
@property (strong, nonatomic) IBOutlet UIButton *micButton;

- (IBAction)answerSelected:(id)sender;
- (IBAction)infoClicked;
- (IBAction)NotesClicked;
- (IBAction)CameraClicked;
- (IBAction)MicrophoneClicked:(id)sender;

@end
