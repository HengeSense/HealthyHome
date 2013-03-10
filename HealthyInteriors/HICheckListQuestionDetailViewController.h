//
//  HICheckListQuestionDetailViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 9/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListQuestionModel.h"

@interface HICheckListQuestionDetailViewController : UIViewController

@property (strong, nonatomic) HICheckListQuestionModel * questionModel;
@property (strong, nonatomic) IBOutlet UILabel *QuestionLabel;
@property (strong, nonatomic) IBOutlet UIView *AnswerControl;
@property (strong, nonatomic) IBOutlet UIWebView *InfoView;

@end
