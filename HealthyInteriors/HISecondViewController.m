//
//  HISecondViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HISecondViewController.h"

@interface HISecondViewController ()

@end

@implementation HISecondViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            self.title = NSLocalizedString(@"Settings", @"Settings");
            self.tabBarItem.image = [UIImage imageNamed:@"settings"];
        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.

    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    - (IBAction)FabricClicked:(id)sender {

        [PXEngine styleSheetFromFilePath:[[NSBundle mainBundle] pathForResource:@"fabric" ofType:@"css"]
                              withOrigin:PXStylesheetOriginApplication];

        [PXEngine applyStylesheets];
        [PXEngine currentApplicationStylesheet].monitorChanges = YES;

    }

    - (IBAction)WoodClicked:(id)sender {

        [PXEngine styleSheetFromFilePath:[[NSBundle mainBundle] pathForResource:@"wood" ofType:@"css"]
                              withOrigin:PXStylesheetOriginApplication];

        [PXEngine applyStylesheets];
        [PXEngine currentApplicationStylesheet].monitorChanges = YES;

    }

@end
