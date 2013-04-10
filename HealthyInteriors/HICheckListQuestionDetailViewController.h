//
//  HICheckListQuestionDetailViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 9/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListQuestionModel.h"
#import "CheckListAnswers+HIFunctions.h"
#import "HIViewController.h"
#import "HIQuestionDetailDelegate.h"

@class SVSegmentedControl;
@class CustomBadge;

@protocol HIQuestionDetailDelegate;

@interface HICheckListQuestionDetailViewController : HIViewController <HIQuestionDetailDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) CheckListAnswers * checkListAnswers;
@property (nonatomic, retain) HICheckListCategoryModel * categoryModel;
@property (nonatomic, strong) HICheckListQuestionModel * questionModel;
@property (nonatomic, strong) CheckListQuestionAnswers * answer;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray * navStack;

@property (strong, nonatomic) IBOutlet UILabel *QuestionLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesButton;
@property (strong, nonatomic) IBOutlet UIButton *cameraButton;
@property (strong, nonatomic) IBOutlet UIButton *micButton;
@property (strong, nonatomic) SVSegmentedControl *segmentControlAnswer;
@property (strong, nonatomic) UIBarButtonItem * infoButton;
@property (strong, nonatomic) CustomBadge * notesBadge;
@property (strong, nonatomic) IBOutlet UILabel *labelQuestionTitle;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *prevButton;

- (void)infoClicked;
- (IBAction)NotesClicked;
- (IBAction)CameraClicked;
- (IBAction)MicrophoneClicked:(id)sender;
- (IBAction)nextButtonPressed;
- (IBAction)prevButtonPressed;

@end
