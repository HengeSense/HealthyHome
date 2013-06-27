//
//  FindThoughtViewController.h
//  Natural Thoughts Manager
//
//  Created by Mark O'Flynn on 12/08/11.
//  Copyright 2011 Thales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListTemplateDelegate.h"
#import "HIQuestionDetailDelegate.h"

@interface FindInfoViewController : HIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, HIQuestionDetailDelegate>

    @property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
    @property (nonatomic, weak) id <HICheckListTemplateDelegate> templateDelegate;

    - (id)initWithTabBar;

@end
