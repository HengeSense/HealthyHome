//
//  HIQuestionInfoViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HIQuestionDetailDelegate.h"
#import "HIViewController.h"

@interface HIQuestionInfoViewController : HIViewController <UIWebViewDelegate>

    @property(strong, nonatomic) IBOutlet UIWebView *infoView;
    @property(nonatomic, strong) HICheckListQuestionModel *questionModel;
    @property(weak, nonatomic) id <HIQuestionDetailDelegate> delegate;
    @property(nonatomic, strong) CheckListQuestionAnswers *answer;
    @property(nonatomic, assign) BOOL isModal;
    @property (strong, nonatomic) IBOutlet UILabel *infoTitleLabel;
    @property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;

@end
