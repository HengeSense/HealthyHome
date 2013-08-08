//
//  HICollectionViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 26/05/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICollectionViewController.h"

@interface HICollectionViewController ()

@end

@implementation HICollectionViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        //self.view.styleClass = @"view";
    }

    - (void)viewDidAppear:(BOOL)animated {
        //[PXEngine applyStylesheets];
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

@end
