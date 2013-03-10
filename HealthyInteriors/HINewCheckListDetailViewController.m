//
//  HINewCheckListDetailViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HINewCheckListDetailViewController.h"

@interface HINewCheckListDetailViewController ()

@end

@implementation HINewCheckListDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    
    self.checkListTitle.text = self.model.name;
    self.checkListDescription.text = self.model.description;
}

- (void)doneAction {

    [self.delegate viewControllerDidDismissWithOK:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
