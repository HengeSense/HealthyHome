//
//  HIHomeViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 22/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIHomeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HIHomeViewController ()
    @property(nonatomic, assign) BOOL startInfoAnimated;
@end

@implementation HIHomeViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];

        self.tabBarItem.title = @"Home";
        self.tabBarItem.image = [UIImage imageNamed:@"home"];

        self.scrollView.contentSize = self.infoLabel.bounds.size;
        [self.scrollView.layer setCornerRadius:10.0f];
        [self.scrollView.layer setBorderColor:[UIColor clearColor].CGColor];

        self.startInfoAnimated = NO;
    }

    - (void)viewDidAppear:(BOOL)animated {
        [super viewDidAppear:animated];

        if (!self.startInfoAnimated) {

            CGRect screenBounds = [[UIScreen mainScreen] bounds];

            self.startInfo.frame = CGRectMake(0, self.tabBarController.tabBar.frame.origin.y, screenBounds.size.width, self.startInfo.bounds.size.height);

            [UIView animateWithDuration:0.5
                                  delay:1.0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{

                                 self.startInfo.frame = CGRectOffset(self.tabBarController.tabBar.frame, 0, -self.startInfo.bounds.size.height);

                             }
                             completion:^(BOOL finished) {
                                 self.startInfoAnimated = YES;
                             }];

        }
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    - (void)viewDidUnload {
        [self setInfoLabel:nil];
        [self setScrollView:nil];
        [self setStartInfo:nil];
        [super viewDidUnload];
    }
@end
