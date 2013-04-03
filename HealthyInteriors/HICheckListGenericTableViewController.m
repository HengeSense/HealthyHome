//
//  HICheckListGenericTableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 2/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListGenericTableViewController.h"

@implementation HICheckListGenericTableViewController


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.checkListModel.name;
}

@end
