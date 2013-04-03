//
//  HIHomeViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 22/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIHomeViewController.h"

@interface HIHomeViewController ()

@end

@implementation HIHomeViewController

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
    self.tabBarItem.title = @"Home";
    self.tabBarItem.image = [UIImage imageNamed:@"home"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
