//
//  HICheckListGenericTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 2/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListGenericTableViewController.h"

@implementation HICheckListGenericTableViewController

    - (id)initWithCheckListAnswers:(CheckListAnswers *)checkListAnswers checkListModel:(HICheckListModel *)checkListModel {
        self = [super init];
        if (self) {
            self.checkListAnswers = checkListAnswers;
            self.checkListModel = checkListModel;
        }

        return self;
    }

    + (id)controllerWithCheckListAnswers:(CheckListAnswers *)checkListAnswers checkListModel:(HICheckListModel *)checkListModel {
        return [[self alloc] initWithCheckListAnswers:checkListAnswers checkListModel:checkListModel];
    }

    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return self.checkListModel.name;
    }

@end
