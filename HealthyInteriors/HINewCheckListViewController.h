//
//  HINewCheckListViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HINewCheckListDetailViewController.h"
#import "HICheckListModel.h"
#import "HICheckListTemplateDelegate.h"
#import "HITableViewController.h"

@protocol NewCheckListCreationDelegate;

@interface HINewCheckListViewController : HITableViewController <NewCheckListDelegate>

@property (nonatomic, weak) id <NewCheckListCreationDelegate> delegate;
@property (nonatomic, weak) id <HICheckListTemplateDelegate> templateManagerDelegate;

@end

@protocol NewCheckListCreationDelegate  <NSObject>

- (void)requestCreationOfCheckList:(HICheckListModel *)checkListModel withAddress:(NSString *)address;

@end