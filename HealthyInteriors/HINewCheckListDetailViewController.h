//
//  HINewCheckListDetailViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListModel.h"

@protocol NewCheckListDelegate;

@interface HINewCheckListDetailViewController : UIViewController

@property (nonatomic, weak) id <NewCheckListDelegate> delegate;
@property (nonatomic, strong) HICheckListModel * model;

@property (strong, nonatomic) IBOutlet UILabel *checkListTitle;
@property (strong, nonatomic) IBOutlet UILabel *checkListDescription;

@end

@protocol NewCheckListDelegate <NSObject>

- (void)viewControllerDidDismissWithOK:(UIViewController *)viewController;

@end