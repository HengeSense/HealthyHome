//
//  HIQuestionInfoViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIQuestionInfoViewController.h"

@interface HIQuestionInfoViewController ()

@end

@implementation HIQuestionInfoViewController

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
    
    //http://kiefermat.com/2011/09/30/using-uiwebview-for-displaying-rich-text/
    NSString* htmlContentString = [NSString stringWithFormat:
                                   @"<html>"
                                   "<body>"
                                   "<p>%@</p>"
                                   "</body></html>", self.questionModel.information];
    
    [self.infoView loadHTMLString:htmlContentString baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
