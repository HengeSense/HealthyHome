//
//  HIHealthyHomeCheckListMainViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "CMPopTipView.h"
#import "HICheckListCategoriesViewController.h"
#import "HICategoriesTableViewController.h"
#import "HIReportsTableViewController.h"

@interface HICheckListCategoriesViewController ()
    @property(nonatomic, strong) UISegmentedControl *tableTypeSegmentedControl;
    @property(nonatomic, strong) HICategoriesTableViewController *categories;
    @property(nonatomic, strong) HIReportsTableViewController *reports;
    @property(nonatomic, strong) HICheckListGenericTableViewController *currentTableDelegate;
@end

@implementation HICheckListCategoriesViewController

    - (id)initWithStyle:(UITableViewStyle)style {
        self = [super initWithStyle:style];
        if (self) {

        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.tableTypeSegmentedControl];

        self.categories = [[HICategoriesTableViewController alloc] initWithCheckListAnswers:self.checkListAnswers checkListModel:self.checkListModel];
        self.categories.managedObjectContext = self.managedObjectContext;
        self.categories.navController = self.navigationController;

        self.reports = [[HIReportsTableViewController alloc] initWithCheckListAnswers:self.checkListAnswers checkListModel:self.checkListModel];
        self.reports.managedObjectContext = self.managedObjectContext;
        self.reports.navController = self.navigationController;

        [self tableTypeControlPressed:self.tableTypeSegmentedControl];
    }

    - (void)viewWillAppear:(BOOL)animated {
        [super viewWillAppear:animated];

        self.navigationItem.title = @"";

        [self.tableView reloadData];
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    - (UISegmentedControl *)tableTypeSegmentedControl {
        if (!_tableTypeSegmentedControl) {
            _tableTypeSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Questions", @"Results", nil]];
            [_tableTypeSegmentedControl addTarget:self action:@selector(tableTypeControlPressed:) forControlEvents:UIControlEventValueChanged];
            _tableTypeSegmentedControl.selectedSegmentIndex = 0;
            _tableTypeSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        }

        return _tableTypeSegmentedControl;
    }

    - (void)tableTypeControlPressed:(UISegmentedControl *)sender {

        if (self.tableTypeSegmentedControl.selectedSegmentIndex == 0) {
            self.currentTableDelegate = self.categories;
        } else {
            self.currentTableDelegate = self.reports;
        }
        self.tableView.delegate = self.currentTableDelegate;
        self.tableView.dataSource = self.currentTableDelegate;


        [UIView transitionWithView:self.tableView
                          duration:0.35f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^(void) {
                            [self.tableView reloadData];
                        }
                        completion:^(BOOL isFinished) {
                        }];

        [self showPopTipView];
    }

    - (void)showPopTipView {
        NSString *message = @"Press + to create a checklist from one of the templates.";
        CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:message];
        popTipView.delegate = self;
        popTipView.dismissTapAnywhere = YES;
        [popTipView autoDismissAnimated:YES atTimeInterval:5.0];
        [popTipView presentPointingAtView:self.tableView inView:self.view animated:YES];

        //self.hintPopup = popTipView;
    }

    - (void)dismissPopTipView {
//    if (self.hintPopup != nil) {
//        [self.hintPopup dismissAnimated:NO];
//        self.hintPopup = nil;
//    }
    }


#pragma mark CMPopTipViewDelegate methods
    - (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView {
//    self.hintPopup = nil;
    }

@end
