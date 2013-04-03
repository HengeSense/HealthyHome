//
//  HIViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 3/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIViewController.h"

@interface HIViewController ()

@end

@implementation HIViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"retina_wood"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
