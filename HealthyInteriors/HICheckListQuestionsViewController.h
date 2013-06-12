//
//  HICheckListQuestionsViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListCategoryModel.h"
#import "CheckListAnswers+HIFunctions.h"
#import "HICheckListQuestionDetailViewController.h"
#import "HITableViewController.h"
#import "HIQuestionCell.h"
#import "HIQuestionViewDataSource.h"

@interface HICheckListQuestionsViewController : HITableViewController <HIQuestionViewDataSource>

    @property(nonatomic, retain) HICheckListCategoryModel *categoryModel;
    @property(nonatomic, strong) CheckListAnswers *checkListAnswers;
    @property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
