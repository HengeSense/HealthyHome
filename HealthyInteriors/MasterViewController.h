//
//  MasterViewController.h
//  TestiPadApp
//
//  Created by Mark O'Flynn on 13/07/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>
#import "HIViewController.h"

@interface MasterViewController : HIViewController <NSFetchedResultsControllerDelegate>

@property(strong, nonatomic) DetailViewController *detailViewController;

@property(strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
