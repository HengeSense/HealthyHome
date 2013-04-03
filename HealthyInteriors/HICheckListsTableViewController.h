//
//  HIViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HINewCheckListViewController.h"
#import "HICheckListTemplateDelegate.h"
#import "EMHint.h"
#import "CMPopTipView.h"
#import "HITableViewController.h"

@interface HICheckListsTableViewController : HITableViewController <NewCheckListCreationDelegate, NSFetchedResultsControllerDelegate, CMPopTipViewDelegate, EMHintDelegate>

@property (nonatomic, weak) id <HICheckListTemplateDelegate> templateDelegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
