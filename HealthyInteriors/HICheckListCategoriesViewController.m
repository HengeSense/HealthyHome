//
//  HIHealthyHomeCheckListMainViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListCategoriesViewController.h"
#import "HICheckListQuestionsViewController.h"
#import "HICategoriesTableViewController.h"
#import "HIReportsTableViewController.h"
#import "HICheckListGenericTableViewController.h"

@interface HICheckListCategoriesViewController ()
@property (nonatomic, strong) UISegmentedControl * tableTypeSegmentedControl;
@property (nonatomic, strong) HICategoriesTableViewController *categories;
@property (nonatomic, strong) HIReportsTableViewController *reports;
@property (nonatomic, strong) HICheckListGenericTableViewController * currentTableDelegate;
@end

@implementation HICheckListCategoriesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: self.tableTypeSegmentedControl];
    self.categories = [[HICategoriesTableViewController alloc] init];
    self.categories.checkListModel = self.checkListModel;
    self.categories.checkListAnswers = self.checkListAnswers;
    self.categories.navController = self.navigationController;
    self.reports = [[HIReportsTableViewController alloc] init];
    self.reports.checkListModel = self.checkListModel;
    self.reports.checkListAnswers = self.checkListAnswers;
    self.reports.navController = self.navigationController;

    [self tableTypeControlPressed:self.tableTypeSegmentedControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UISegmentedControl*)tableTypeSegmentedControl {
    if (!_tableTypeSegmentedControl) {
        _tableTypeSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Categories",@"Reports", nil]];
        [_tableTypeSegmentedControl addTarget:self action:@selector(tableTypeControlPressed:) forControlEvents:UIControlEventValueChanged];
        _tableTypeSegmentedControl.selectedSegmentIndex = 0;
        _tableTypeSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    }
    
    return _tableTypeSegmentedControl;
}

- (void)tableTypeControlPressed:(UISegmentedControl *)sender
{
 
    if (self.tableTypeSegmentedControl.selectedSegmentIndex == 0) {
        self.currentTableDelegate = self.categories;
    } else {
        self.currentTableDelegate = self.reports;
    }
    self.tableView.delegate = self.currentTableDelegate;
    self.tableView.dataSource = self.currentTableDelegate;
    
    [UIView transitionWithView: self.tableView
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [self.tableView reloadData];
     }
                    completion: ^(BOOL isFinished)
     {
     }];

    
}

@end
