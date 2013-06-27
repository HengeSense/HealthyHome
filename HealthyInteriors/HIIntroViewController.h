//
// Created by Mark O'Flynn on 21/06/13.
// Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "MYIntroductionView.h"
#import "HIViewController.h"

@interface HIIntroViewController : HIViewController <MYIntroductionDelegate>

@property (nonatomic, assign) BOOL displaySkipButton;

@end