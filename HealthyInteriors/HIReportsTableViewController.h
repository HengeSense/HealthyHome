//
//  HIReportsTableViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 2/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HICheckListGenericTableViewController.h"

@interface HIReportsTableViewController : HICheckListGenericTableViewController
    @property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
