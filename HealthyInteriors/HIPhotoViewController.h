//
//  HIPhotoViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIViewController.h"

@interface HIPhotoViewController : HIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

@end
