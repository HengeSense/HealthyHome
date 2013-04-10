//
//  HICheckListQuestionDetailViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 9/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListQuestionDetailViewController.h"
#import "HIQuestionInfoViewController.h"
#import "HIQuestionNotesViewController.h"
#import "SVSegmentedControl.h"
#import "HIPhotosCollectionViewController.h"
#import "CheckListQuestionAnswers+HIFunctions.h"
#import "CheckListAnswerImages.h"

#import "CustomBadge.h"

@interface HICheckListQuestionDetailViewController ()
@end

@implementation HICheckListQuestionDetailViewController

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
    //self.navigationItem.title = @"Question";
    
    self.infoButton = [[UIBarButtonItem alloc] initWithTitle:@"Healthy Info" style:UIBarButtonItemStylePlain target:self action:@selector(infoClicked)];
    self.navigationItem.rightBarButtonItem = self.infoButton;
    
    self.QuestionLabel.text = self.questionModel.text;
    
    self.segmentControlAnswer = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"NA", @"Yes", @"No", nil] ];
    
	self.segmentControlAnswer.crossFadeLabelsOnDrag = YES;
	self.segmentControlAnswer.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 14);
    self.segmentControlAnswer.textColor = [UIColor darkTextColor];
	self.segmentControlAnswer.height = 40;
	self.segmentControlAnswer.thumb.tintColor = [UIColor colorWithRed:0.999 green:0.889 blue:0.312 alpha:1.000];
	self.segmentControlAnswer.thumb.textColor = [UIColor blackColor];
	self.segmentControlAnswer.thumb.textShadowColor = [UIColor colorWithWhite:1 alpha:0.5];
	self.segmentControlAnswer.thumb.textShadowOffset = CGSizeMake(0, 1);
    
    if (self.answer.answer == [NSNumber numberWithInt:AnswerStateNo]) {
        [self.segmentControlAnswer setSelectedSegmentIndex:2 animated:YES];
    } else if (self.answer.answer ==[NSNumber numberWithInt:AnswerStateYes]) {        
        [self.segmentControlAnswer setSelectedSegmentIndex:1 animated:YES];        
    } else if (self.answer.answer == [NSNumber numberWithInt:AnswerStateNotApplicable]) {
        [self.segmentControlAnswer setSelectedSegmentIndex:0 animated:YES];        
    }
    
    [self.segmentControlAnswer addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];	
	[self.view addSubview:self.segmentControlAnswer];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    int segTop = self.QuestionLabel.frame.origin.y + self.QuestionLabel.frame.size.height + 30;
	self.segmentControlAnswer.center = CGPointMake(screenBounds.size.width / 2, segTop);
    self.segmentControlAnswer.hidden = YES;
    
    self.infoButton.enabled = ![self.questionModel.information isEqualToString:@""];
    
//    if (self.notesExist) {
//        
//        
//        self.notesBadge = [CustomBadge customBadgeWithString:@"\u2713"
//                                                       withStringColor:[UIColor whiteColor]
//                                                        withInsetColor:[UIColor redColor]
//                                                        withBadgeFrame:YES
//                                                   withBadgeFrameColor:[UIColor whiteColor]
//                                                             withScale:1.0
//                                                           withShining:YES];
//        
//        [self.view addSubview:self.notesBadge];
//
//    }

}

- (void) viewDidLayoutSubviews
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    int segTop = self.QuestionLabel.frame.origin.y + self.QuestionLabel.frame.size.height + 30;
	self.segmentControlAnswer.center = CGPointMake(screenBounds.size.width / 2, segTop);
    self.segmentControlAnswer.hidden = NO;
    
    //[self.notesBadge setCenter:CGPointMake(self.notesButton.frame.origin.x + self.notesButton.frame.size.width, self.notesButton.frame.origin.y)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl {
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            [self setValueTo:AnswerStateNotApplicable];
            break;
        case 1:
            [self setValueTo:AnswerStateYes];
            break;
        case 2:
            [self setValueTo:AnswerStateNo];
            break;
        default:
            break;
    }
}

- (void)infoClicked {
    
//    HIQuestionInfoViewController * vc = [[HIQuestionInfoViewController alloc] init];
//    vc.questionModel = self.questionModel;
//    vc.delegate = self.delegate;
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)NotesClicked {
    
    HIQuestionNotesViewController * vc = [[HIQuestionNotesViewController alloc] init];
    vc.questionModel = self.questionModel;
    vc.answer = self.answer;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)CameraClicked {
    
    HIPhotosCollectionViewController * vc = [[HIPhotosCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    vc.questionModel = self.questionModel;
    vc.answer = self.answer;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)MicrophoneClicked:(id)sender {
}


- (void)doContextSave
{
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate.
         You should not use this function in a shipping application, although it may be useful during development.
         If it is not possible to recover from the error,
         display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}

- (void) setValueTo:(AnswerState)value
{
    self.answer.answer = [NSNumber numberWithInt:value];
    [self doContextSave];
}

- (void) setNotesTo:(NSString *)text
{
    self.answer.notes = text;
    [self doContextSave];
}

- (void) addImageWithFullName:(NSString *)fullname andThumbnailName:(NSString *)thumbnailName
{
    
    CheckListAnswerImages *thisAnswerImage = [NSEntityDescription insertNewObjectForEntityForName:@"CheckListAnswerImages" inManagedObjectContext:self.managedObjectContext];
    
    thisAnswerImage.fullPathName = fullname;
    thisAnswerImage.thumbPathName = thumbnailName;
    thisAnswerImage.imageAnswer = self.answer;
    thisAnswerImage.creationDate = [NSDate date];
    
    [self.answer addAnswerImagesObject:thisAnswerImage];
    
    [self doContextSave];
    
}

- (void)viewDidUnload {
    [self setLabelQuestionTitle:nil];
    [self setNextButton:nil];
    [self setPrevButton:nil];
    [super viewDidUnload];
}
@end
