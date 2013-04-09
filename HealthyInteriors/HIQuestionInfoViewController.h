//
//  HIQuestionInfoViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HIViewController.h"
#import "HIQuestionDetailDelegate.h"

@interface HIQuestionInfoViewController : HIViewController

@property (strong, nonatomic) IBOutlet UIWebView *infoView;

@property (nonatomic, strong) HICheckListQuestionModel * questionModel;
@property (weak, nonatomic) id <HIQuestionDetailDelegate> delegate;
@property (nonatomic, strong) CheckListQuestionAnswers * answer;

@end
