//
//  HIPhotoViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIViewController.h"
#import "HIQuestionDetailDelegate.h"

@interface HIPhotoViewController : HIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) HICheckListQuestionModel * questionModel;
@property (weak, nonatomic) id <HIQuestionDetailDelegate> delegate;
@property (nonatomic, strong) CheckListQuestionAnswers * answer;
@property (nonatomic, strong) NSNumber * selectedIndex;

- (IBAction)changePage:(id)sender;

@end
