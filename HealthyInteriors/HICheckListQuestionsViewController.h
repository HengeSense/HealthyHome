//
//  HICheckListQuestionsViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListCategoryModel.h"
#import "CheckListAnswers.h"

@interface HICheckListQuestionsViewController : UITableViewController

@property (nonatomic, retain) HICheckListCategoryModel * categoryModel;
@property (nonatomic, strong) CheckListAnswers * checkListAnswers;

@end
