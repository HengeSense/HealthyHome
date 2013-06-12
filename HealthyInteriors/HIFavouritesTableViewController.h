//
//  HIFavouritesTableViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/06/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HITableViewController.h"
#import "HIQuestionDetailDelegate.h"

@protocol HICheckListTemplateDelegate;

@interface HIFavouritesTableViewController : HITableViewController <NSFetchedResultsControllerDelegate, HIQuestionDetailDelegate>
    @property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
    @property(nonatomic, weak) id <HICheckListTemplateDelegate> templateDelegate;

    - (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
