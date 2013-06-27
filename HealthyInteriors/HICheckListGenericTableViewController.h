//
//  HICheckListGenericTableViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 2/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HICheckListModel.h"
#import "CheckListAnswers.h"

@interface HICheckListGenericTableViewController : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HICheckListModel * checkListModel;
@property (nonatomic, strong) CheckListAnswers * checkListAnswers;
@property (nonatomic, strong) UINavigationController * navController;

    - (id)initWithCheckListAnswers:(CheckListAnswers *)checkListAnswers checkListModel:(HICheckListModel *)checkListModel;

    + (id)controllerWithCheckListAnswers:(CheckListAnswers *)checkListAnswers checkListModel:(HICheckListModel *)checkListModel;

@end
