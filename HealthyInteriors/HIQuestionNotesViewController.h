//
//  HIViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIViewController.h"
#import "HIQuestionDetailDelegate.h"

@interface HIQuestionNotesViewController : HIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *notesView;

@property (nonatomic, strong) HICheckListQuestionModel * questionModel;
@property (weak, nonatomic) id <HIQuestionDetailDelegate> delegate;
@property (nonatomic, strong) CheckListQuestionAnswers * answer;

@end
