//
//  HIHomeViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 22/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HIViewController.h"

@interface HIHomeViewController : HIViewController

@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *startInfo;

@end
