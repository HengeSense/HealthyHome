//
//  HIViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIQuestionNotesViewController.h"

@interface HIQuestionNotesViewController ()

@end

@implementation HIQuestionNotesViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lined_paper.png"]];
    [self.view setOpaque:NO];
    self.navigationItem.title = @"Notes";
    
    self.notesView.text = self.answer.notes;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.notesView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-  (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.delegate setNotesTo:textView.text];
}

@end
