//
// Created by Mark O'Flynn on 21/06/13.
// Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HIIntroViewController.h"

@implementation HIIntroViewController {

}
    - (void)viewWillAppear:(BOOL)animated {
        [super viewWillAppear:animated];

        MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Page1"] title:@"Welcome" description:NSLocalizedString(@"Intro Panel 1 Description", @"")];
        MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Page2"] title:@"Create a Checklist" description:NSLocalizedString(@"Intro Panel 2 Description", @"")];
        MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Page3"] title:@"Questions" description:NSLocalizedString(@"Intro Panel 3 Description", @"")];
        MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Page4"] title:@"Tips" description:NSLocalizedString(@"Intro Panel 4 Description", @"")];
        MYIntroductionPanel *panel5 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Page5"] title:@"Favourites" description:NSLocalizedString(@"Intro Panel 5 Description", @"")];
        MYIntroductionPanel *panel6 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Page6"] title:@"Results" description:NSLocalizedString(@"Intro Panel 6 Description", @"")];

        MYIntroductionView *introView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerText:@"Healthy Home App" panels:@[panel1, panel2, panel3, panel4, panel5, panel6]];
        introView.backgroundColor = [UIColor colorWithRed:0.788 green:0.741 blue:0.651 alpha:1.000];

        introView.SkipButton.hidden = !self.displaySkipButton;

        introView.delegate = self;
        [introView showInView:self.view];

    }

#pragma mark - Introduction Delegate Methods

    -(void)introductionDidFinishWithType:(MYFinishType)finishType{

        if (finishType == MYFinishTypeSkipButton) {
            NSLog(@"Did Finish Introduction By Skipping It");
        }
        else if (finishType == MYFinishTypeSwipeOut){
            NSLog(@"Did Finish Introduction By Swiping Out");
        }

        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        } else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }

    -(void)introductionDidChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
        NSLog(@"%@ \nPanelIndex: %d", panel.Description, panelIndex);
    }

@end