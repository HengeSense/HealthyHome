//
//  HIViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIQuestionDetailBaseViewController.h"

@interface HIQuestionNotesViewController : HIQuestionDetailBaseViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *notesView;

@end
