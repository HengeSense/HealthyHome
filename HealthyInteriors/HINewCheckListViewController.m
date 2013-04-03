//
//  HINewCheckListViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HINewCheckListViewController.h"
#import "HICheckListTemplateManager.h"
#import "HINewCheckListCellView.h"

@interface HINewCheckListViewController ()
@end

@implementation HINewCheckListViewController

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
    self.navigationItem.title = @"New Checklist";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cancelAction {

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.templateManagerDelegate getNumberOfTemplates];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HINewCheckListCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"HiNewCheckListCellView"];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HiNewCheckListCellView" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    HICheckListModel * checkListModel = [self.templateManagerDelegate checkListWithIndex:indexPath.section];
    
    [cell configureCellWithTemplate:checkListModel];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HINewCheckListDetailViewController *detailViewController = [[HINewCheckListDetailViewController alloc] init];
    detailViewController.delegate = self;
    detailViewController.model = [self.templateManagerDelegate checkListWithIndex:indexPath.section];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)viewController:(UIViewController *)viewController didDismissOKWithAddress:(NSString *)address
{
//get the model
    HICheckListModel * model = ((HINewCheckListDetailViewController *)viewController).model;
    [self dismissViewControllerAnimated:YES completion:^(void){[self.delegate requestCreationOfCheckList:model  withAddress:(NSString *)address];}];
}

@end
