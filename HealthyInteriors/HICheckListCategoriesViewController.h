//
//  HIHealthyHomeCheckListMainViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListModel.h"
#import "CheckListAnswers.h"

@interface HICheckListCategoriesViewController : UITableViewController

@property (nonatomic, strong) HICheckListModel * checkListModel;
@property (nonatomic, strong) CheckListAnswers * checkListAnswers;

@end
