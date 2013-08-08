//
//  HITableViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 23/05/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HITableViewController.h"

@interface HITableViewController ()

@end

@implementation HITableViewController

    - (id)initWithStyle:(UITableViewStyle)style {
        self = [super initWithStyle:style];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];
    }

    - (void)viewDidAppear:(BOOL)animated {
        //[PXEngine applyStylesheets];
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

//    - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//    {
//
//        UIView *transparentView=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,10)];
//        transparentView.backgroundColor = [UIColor clearColor];
//        return transparentView;
//
//    }

@end
