//
//  HINewCheckListDetailViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListModel.h"
#import "HIViewController.h"

@protocol NewCheckListDelegate;

@interface HINewCheckListDetailViewController : HIViewController <UITextFieldDelegate>

    @property(nonatomic, weak) id <NewCheckListDelegate> delegate;
    @property(nonatomic, strong) HICheckListModel *model;
    @property(strong, nonatomic) IBOutlet UILabel *checkListTitle;
    @property(strong, nonatomic) IBOutlet UILabel *checkListDescription;
    @property(strong, nonatomic) IBOutlet UITextField *addressField;

@end

@protocol NewCheckListDelegate <NSObject>

    - (void)viewController:(UIViewController *)viewController didDismissOKWithAddress:(NSString *)address;

@end