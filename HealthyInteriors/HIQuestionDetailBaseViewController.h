//
//  HIQuestionDetailBaseViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListQuestionModel.h"
#import "HIQuestionDetailDelegate.h"

@interface HIQuestionDetailBaseViewController : UIViewController

@property (nonatomic, strong) HICheckListQuestionModel * questionModel;
@property (weak, nonatomic) id <HIQuestionDetailDelegate> delegate;

@end
