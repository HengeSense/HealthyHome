//
//  HIViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 23/05/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIViewController.h"

@interface HIViewController ()

@end

@implementation HIViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];
        self.view.styleClass = @"view";
    }

    - (void)viewDidAppear:(BOOL)animated {
        [PXEngine applyStylesheets];
    }

    - (void)viewWillLayoutSubviews {
        [super viewWillLayoutSubviews];

        if (self.navigationController) {
            self.screenBounds = self.navigationController.view.bounds;
        } else {
            self.screenBounds = [[UIScreen mainScreen] bounds];
        }

    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

@end
