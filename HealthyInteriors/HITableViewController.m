//
//  HITableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 3/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HITableViewController.h"

@interface HITableViewController ()

@end

@implementation HITableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"retina_wood"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
