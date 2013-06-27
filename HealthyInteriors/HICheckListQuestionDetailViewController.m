//
//  HICheckListQuestionDetailBaseController.m
//  
//
//  Created by Mark O'Flynn on 3/06/13.
//
//

#import "HICheckListQuestionDetailViewController.h"
#import "HIQuestionInfoViewController.h"
#import "HIQuestionNotesViewController.h"
#import "HIPhotosCollectionViewController.h"
#import "HICheckListQuestionsViewController.h"
#import "CheckListAnswerImages.h"
#import "CustomBadge.h"
#import "Favourites.h"
#import "UIColor-Expanded.h"

@interface HICheckListQuestionDetailViewController (/*private*/)
    @property(nonatomic, assign) NSInteger currentIndex;
    @property(nonatomic, assign) NSInteger totalQuestions;
    @property(nonatomic, retain) HICheckListCategoryModel *categoryModel;
    @property(nonatomic, strong) HICheckListQuestionModel *questionModel;
    @property(nonatomic, strong) CheckListQuestionAnswers *answer;
    @property(nonatomic, strong) NSString *backTitle;
    @property(nonatomic, assign) BOOL isReportPage;
    @property(strong, nonatomic) IBOutlet UILabel *currentQuestionLabel;
    @property(strong, nonatomic) IBOutlet UILabel *prevQuestionLabel;
    @property(strong, nonatomic) IBOutlet UIButton *notesButton;
    @property(strong, nonatomic) IBOutlet UIButton *cameraButton;
    @property(nonatomic, strong) IBOutlet UIProgressView *progressView;
    @property(strong, nonatomic) IBOutlet UILabel *colourIndicator;
    @property(strong, nonatomic) IBOutlet UILabel *ResultLabel;
    @property(strong, nonatomic) IBOutlet NVUIGradientButton *infoButton;
    @property(strong, nonatomic) IBOutlet UIView *toolBar;
    @property(strong, nonatomic) SVSegmentedControl *segmentControlAnswer;
    @property(strong, nonatomic) CustomBadge *notesBadge;
    @property(strong, nonatomic) CustomBadge *imagesBadge;
    @property(nonatomic, strong) UISegmentedControl *questionNavSegmentedControl;

    - (BOOL)infoIsFavourite;

    - (NSArray *)listFileAtPath:(NSString *)path;

    - (BOOL)isFirstQuestion;

    - (BOOL)isLastQuestion;

    - (void)updateImagesBadge;

    - (void)updateNotesBadge;

    - (void)updateBackColour:(BOOL)animated;

    - (void)updateProgress;

    - (void)updateAnswer:(BOOL)animated;

    - (void)updateInfoButton;

    - (void)updateNavigationBar;

    - (void)updateFavouriteTip;

    - (void)nextButtonPressed;

    - (void)prevButtonPressed;

    - (IBAction)infoButtonPressed;

    - (IBAction)NotesClicked;

    - (IBAction)CameraClicked;

    - (void)pushQuestion;

    - (void)popQuestion;

    - (CheckListQuestionAnswers *)getAnswerManagedObjectForQuestionID:(NSString *)questionID;

    - (BOOL)doContextSave;

    - (void)rebuildNavigationStack;

@end

@implementation HICheckListQuestionDetailViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {

            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonClicked)];
            self.navigationItem.leftBarButtonItem = backButton;

            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.questionNavSegmentedControl];

            [self.view addSubview:self.segmentControlAnswer];

            self.infoButton.text = @"Healthy Tip";
            self.infoButton.textColor = [UIColor whiteColor];
            self.infoButton.tintColor = [UIColor colorWithRed:0.140 green:0.314 blue:0.824 alpha:0.85f];

            [self.currentQuestionLabel setUserInteractionEnabled:YES];

            UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(prevButtonPressed)];
            swipeRight.numberOfTouchesRequired = 1;
            swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
            [self.currentQuestionLabel addGestureRecognizer:swipeRight];

            UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextButtonPressed)];
            swipeLeft.numberOfTouchesRequired = 1;
            swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
            [self.currentQuestionLabel addGestureRecognizer:swipeLeft];

            self.prevQuestionLabel.alpha = 0.0f;
/*

 temporary disable pending usability
*/

        }
        return self;
    }

    - (void)viewWillAppear:(BOOL)animated {
        [super viewWillAppear:animated];

        //update the favourite tip indication in case this has been done through the Favourite Tips tab
        [self updateFavouriteTip];
    }

    - (void)viewDidLoad {
        [super viewDidLoad];

        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataModelChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];

    }

    - (void)viewDidLayoutSubviews {
        [super viewDidLayoutSubviews];

        int segTop = self.currentQuestionLabel.frame.origin.y + self.currentQuestionLabel.frame.size.height + 30;
        self.segmentControlAnswer.center = CGPointMake(self.screenBounds.size.width / 2, segTop);
        self.segmentControlAnswer.hidden = NO;

        self.progressView.frame = CGRectMake(0, 0, self.screenBounds.size.width, 10);
        self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        int centreX = self.notesButton.frame.origin.x + self.notesButton.frame.size.width;
        int centreY = self.notesButton.frame.origin.y;
        if (self.notesBadge)
            [self.notesBadge setCenter:CGPointMake(centreX, centreY)];

        centreX = self.cameraButton.frame.origin.x + self.cameraButton.frame.size.width;
        centreY = self.cameraButton.frame.origin.y;
        if (self.imagesBadge)
            [self.imagesBadge setCenter:CGPointMake(centreX, centreY)];

    }

//    - (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//
//        int segTop = self.currentQuestionLabel.frame.origin.y + self.currentQuestionLabel.frame.size.height + 30;
//        self.screenBounds = [[UIScreen mainScreen] bounds];
//        self.segmentControlAnswer.center = CGPointMake(self.screenBounds.size.width / 2, segTop);
//
////        if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
////        } else {
////        }
//    }


    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    - (SVSegmentedControl *)segmentControlAnswer {

        if (!_segmentControlAnswer) {
            _segmentControlAnswer = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"?", @"No", nil]];

            _segmentControlAnswer.crossFadeLabelsOnDrag = YES;
            _segmentControlAnswer.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 14);
            _segmentControlAnswer.textColor = [UIColor darkTextColor];
            _segmentControlAnswer.height = 40;
            _segmentControlAnswer.thumb.tintColor = [UIColor colorWithRed:0.999 green:0.889 blue:0.312 alpha:1.000];
            _segmentControlAnswer.thumb.textColor = [UIColor blackColor];
            _segmentControlAnswer.thumb.textShadowColor = [UIColor colorWithWhite:1 alpha:0.5];
            _segmentControlAnswer.thumb.textShadowOffset = CGSizeMake(0, 1);

            [_segmentControlAnswer addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];

        }
        return _segmentControlAnswer;
    }

    - (UISegmentedControl *)questionNavSegmentedControl {

        if (!_questionNavSegmentedControl) {
            _questionNavSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
                    [UIImage imageNamed:@"arrow-simple-01-white"],
                    [UIImage imageNamed:@"arrow-simple-02-white"], nil]];
            [_questionNavSegmentedControl addTarget:self action:@selector(questionNavSegmentedPressed:) forControlEvents:UIControlEventValueChanged];
            _questionNavSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
            _questionNavSegmentedControl.momentary = YES;

        }

        return _questionNavSegmentedControl;
    }

    - (NSUInteger)currentQuestion {
        return self.currentIndex;
    }

    - (void)setCurrentQuestion:(NSUInteger)currentQuestion {

        int prevIndex = self.currentIndex;
        self.currentIndex = currentQuestion;
        self.questionModel = [self.dataSource questionAtIndex:self.currentIndex];
        self.answer = [self getAnswerManagedObjectForQuestionID:self.questionModel.key];
        self.categoryModel = self.questionModel.categoryModel;

        self.totalQuestions = self.dataSource.totalNumberOfQuestions;

        [self updateNavigationBar];
        [self updateQuestionNavButtons];

        if (prevIndex < self.currentIndex) {
            [self pushQuestion];
        } else {
            [self popQuestion];
        }

        [self updateAnswer:YES];
        [self updateInfoButton];
        [self updateProgress];
        [self updateNotesBadge];
        [self updateImagesBadge];
        [self updateBackColour:NO];

        //hide camera button if not ios 6
        NSString *version = [[UIDevice currentDevice] systemVersion];

        BOOL isAtLeast6 = [version floatValue] >= 6.0;
        self.cameraButton.hidden = !isAtLeast6;

    }

    - (void)updateQuestionNavButtons {
        [self.questionNavSegmentedControl setEnabled:![self isFirstQuestion] forSegmentAtIndex:0];
        [self.questionNavSegmentedControl setEnabled:![self isLastQuestion] forSegmentAtIndex:1];
    }

    - (void)segmentedControlChangedValue:(SVSegmentedControl *)segmentedControl {

        switch (segmentedControl.selectedSegmentIndex) {
            case 1:
                [self setValueTo:AnswerStateNotApplicable];
                break;
            case 0:
                [self setValueTo:AnswerStateYes];
                break;
            case 2:
                [self setValueTo:AnswerStateNo];
                break;
            default:
                break;
        }

        [self updateBackColour:YES];

    }

    - (void)questionNavSegmentedPressed:(UISegmentedControl *)sender {

        if (self.questionNavSegmentedControl.selectedSegmentIndex == 0) {
            [self prevButtonPressed];
        } else {
            [self nextButtonPressed];
        }

    }

    - (void)updateFavouriteTip {
        [self.infoButton setRightAccessoryImage:([self isFavourite]) ? ([UIImage imageNamed:@"star-mini-white"]) : nil];
        [self.infoButton setRightHighlightedAccessoryImage:([self isFavourite]) ? ([UIImage imageNamed:@"star-mini-white"]) : nil];
    }

    - (void)nextButtonPressed {

        if (![self isLastQuestion]) {
            self.currentQuestion = (NSUInteger) (self.currentIndex + 1);
            [self rebuildNavigationStack];
        }

    }

    - (void)prevButtonPressed {

        if (![self isFirstQuestion]) {
            self.currentQuestion = (NSUInteger) (self.currentIndex - 1);
            [self rebuildNavigationStack];
        }

    }

    - (void)rebuildNavigationStack {

        id <HIQuestionDetailDelegate> questionsViewController = (id <HIQuestionDetailDelegate>) [self.dataSource parentDataSourceForQuestion:self.questionModel];
        self.dataSource = (id <HIQuestionViewDataSource>) questionsViewController;
        self.backTitle = [self.dataSource getBackTitle];

        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[[self navigationController] viewControllers]];
        [viewControllers removeLastObject];
        [viewControllers removeLastObject];

        [viewControllers addObject:questionsViewController];
        [viewControllers addObject:self];
        [self.navigationController setViewControllers:viewControllers animated:NO];

    }

    - (IBAction)backButtonClicked {
        [self.navigationController popViewControllerAnimated:YES];
    }

    - (IBAction)infoButtonPressed {

        HIQuestionInfoViewController *vc = [[HIQuestionInfoViewController alloc] init];
        vc.questionModel = self.questionModel;
        vc.managedObjectContext = self.managedObjectContext;
        vc.delegate = self;
        vc.isModal = YES;

        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nc animated:YES completion:nil];

    }

    - (IBAction)NotesClicked {

        HIQuestionNotesViewController *vc = [[HIQuestionNotesViewController alloc] init];
        vc.questionModel = self.questionModel;
        vc.answer = self.answer;
        vc.delegate = self;
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nc animated:YES completion:nil];

    }

    - (IBAction)CameraClicked {

        HIPhotosCollectionViewController *vc = [[HIPhotosCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        vc.questionModel = self.questionModel;
        vc.answer = self.answer;
        vc.delegate = self;
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nc animated:YES completion:nil];

    }

    - (void)pushQuestion {

        self.prevQuestionLabel.text = self.currentQuestionLabel.text;
        self.prevQuestionLabel.alpha = 1.0f;
        self.prevQuestionLabel.adjustsFontSizeToFitWidth = YES;

        CGRect currentFrame = self.currentQuestionLabel.frame;

        self.prevQuestionLabel.frame = currentFrame;
        self.currentQuestionLabel.frame = CGRectMake(currentFrame.origin.x + self.screenBounds.size.width, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
        self.currentQuestionLabel.text = self.questionModel.text;
        self.currentQuestionLabel.adjustsFontSizeToFitWidth = YES;

        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                animations:^{
                    self.currentQuestionLabel.frame = currentFrame;
                    self.prevQuestionLabel.frame = CGRectMake(currentFrame.origin.x - self.screenBounds.size.width, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
                    self.prevQuestionLabel.alpha = 0.0f;
                } completion:nil];

        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    self.prevQuestionLabel.alpha = 0.0f;
                } completion:nil];

    }

    - (void)popQuestion {

        self.prevQuestionLabel.text = self.currentQuestionLabel.text;
        self.prevQuestionLabel.alpha = 1.0f;
        self.prevQuestionLabel.adjustsFontSizeToFitWidth = YES;

        CGRect currentFrame = self.currentQuestionLabel.frame;

        self.prevQuestionLabel.frame = currentFrame;
        self.currentQuestionLabel.frame = CGRectMake(currentFrame.origin.x - self.screenBounds.size.width, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
        self.currentQuestionLabel.text = self.questionModel.text;
        self.currentQuestionLabel.adjustsFontSizeToFitWidth = YES;

        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    self.currentQuestionLabel.frame = currentFrame;
                    self.prevQuestionLabel.frame = CGRectMake(currentFrame.origin.x + self.screenBounds.size.width, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
                } completion:nil];

        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    self.prevQuestionLabel.alpha = 0.0f;
                } completion:nil];

    }

    - (void)updateNavigationBar {
        self.navigationItem.title = [NSString stringWithFormat:@"%d / %d", self.currentIndex + 1, self.totalQuestions];
        self.navigationItem.leftBarButtonItem.title = self.backTitle;
    }

    - (void)updateInfoButton {
        self.infoButton.enabled = ![self.questionModel.information isEqualToString:@""];
        [self updateFavouriteTip];
    }

    - (void)updateProgress {
        float progress = (float) (self.currentIndex + 1) / self.totalQuestions;
        [self.progressView setProgress:progress animated:YES];
    }

    - (void)updateAnswer:(BOOL)animated {
        if (self.answer.answer == [NSNumber numberWithInt:AnswerStateNo]) {
            [self.segmentControlAnswer setSelectedSegmentIndex:2 animated:animated];
        } else if (self.answer.answer == [NSNumber numberWithInt:AnswerStateYes]) {
            [self.segmentControlAnswer setSelectedSegmentIndex:0 animated:animated];
        } else if (self.answer.answer == [NSNumber numberWithInt:AnswerStateNotApplicable]) {
            [self.segmentControlAnswer setSelectedSegmentIndex:1 animated:animated];
        } else {
            [self.segmentControlAnswer setSelectedSegmentIndex:1 animated:animated];
        }
    }

    - (void)updateImagesBadge {
        if (self.imagesBadge)
            [self.imagesBadge removeFromSuperview];

        int imagesCount = self.answer.answerImages.count;
        self.imagesBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d", imagesCount]
                                              withStringColor:[UIColor whiteColor]
                                               withInsetColor:[UIColor redColor]
                                               withBadgeFrame:YES
                                          withBadgeFrameColor:[UIColor whiteColor]
                                                    withScale:1.0
                                                  withShining:YES];

        [self.toolBar addSubview:self.imagesBadge];
        self.imagesBadge.badgeText = [[NSNumber numberWithInt:imagesCount] stringValue];
        [self.imagesBadge setNeedsLayout];
        self.imagesBadge.hidden = (imagesCount == 0);
        [self.view setNeedsLayout];
    }

    - (void)updateNotesBadge {
        if (self.notesBadge)
            [self.notesBadge removeFromSuperview];

        self.notesBadge = [CustomBadge customBadgeWithString:@"\u2713"
                                             withStringColor:[UIColor whiteColor]
                                              withInsetColor:[UIColor redColor]
                                              withBadgeFrame:YES
                                         withBadgeFrameColor:[UIColor whiteColor]
                                                   withScale:1.0
                                                 withShining:YES];

        [self.toolBar addSubview:self.notesBadge];
        BOOL notesExist = self.answer.notes && self.answer.notes.length > 0;
        self.notesBadge.hidden = !notesExist;
        [self.view setNeedsLayout];
    }

    - (void)updateBackColour:(BOOL)animated {
        UIColor *newBackColor = [self.checkListAnswers backColourForAnswerToQuestion:self.questionModel.key forTemplateQuestion:self.questionModel];
        UIColor *newTextColor = [self.checkListAnswers textColourForAnswerToQuestion:self.questionModel.key forTemplateQuestion:self.questionModel];
        NSString *result = @"";
        NSString *image = @"Question-mark";


        if ([self.checkListAnswers isAnswerToQuestionAChallenge:self.questionModel]) {
            result = @"Healthy Challenge";
            image = @"ThumbsDn_150";
        } else if ([self.checkListAnswers isAnswerToQuestionAnAsset:self.questionModel]) {
            result = @"Healthy Asset";
            image = @"ThumbsUp_150";
        } else{
            newBackColor = [UIColor clearColor];
            newTextColor = [UIColor clearColor];

        }

        self.colourIndicator.alpha = 0.0;
        self.colourIndicator.backgroundColor = newBackColor;

        [UIView animateWithDuration:0.1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    self.colourIndicator.alpha = 0.0;
                    self.ResultLabel.alpha = 0.0;
                } completion:^(BOOL finished) {
            if (finished) {
                self.ResultLabel.textColor = newTextColor;
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     self.ResultLabel.text = result;
                                     self.ResultLabel.alpha = 1.0;
                                     self.colourIndicator.alpha = 0.3;
                                 }];
            }
        }];


//    self.ResultLabel.text = @"";
//    if ([self.checkListAnswers isAnswerToQuestionAChallenge:self.questionModel]) {
//        self.colourIndicator.backgroundColor = [UIColor redColor];
//        self.colourIndicator.alpha = 0.05;
//        self.ResultLabel.text = @"Healthy Challenge";
//        self.ResultLabel.textColor = challengeTextColour;
//    } else if ([self.checkListAnswers isAnswerToQuestionAnAsset:self.questionModel]) {
//        self.colourIndicator.backgroundColor = [UIColor greenColor];
//        self.colourIndicator.alpha = 0.05;
//        self.ResultLabel.text = @"Healthy Asset";
//        self.ResultLabel.textColor = assetTextColour;
//    }

    }

    - (CheckListQuestionAnswers *)getAnswerManagedObjectForQuestionID:(NSString *)questionID {
        CheckListQuestionAnswers *thisAnswer = [self.checkListAnswers answerToQuestionWithID:questionID];
        if (!thisAnswer) {
            thisAnswer = [self createNewAnswerForQuestion:questionID];
        }

        return thisAnswer;
    }

    - (CheckListQuestionAnswers *)createNewAnswerForQuestion:(NSString *)questionID {
        //add a new answer
        CheckListQuestionAnswers *thisAnswer = [NSEntityDescription insertNewObjectForEntityForName:@"CheckListQuestionAnswers" inManagedObjectContext:self.managedObjectContext];

        thisAnswer.questionID = questionID;
        thisAnswer.questionCheckList = self.checkListAnswers;
        thisAnswer.answer = [NSNumber numberWithInteger:AnswerStateNotAnswered];

        [self doContextSave];

        return thisAnswer;
    }

    - (BOOL)doContextSave {
        NSError *error = nil;
        BOOL result = YES;
        if (![self.managedObjectContext save:&error]) {

            /*
             Replace this implementation with code to handle the error appropriately.

             abort() causes the application to generate a crash log and terminate.
             You should not use this function in a shipping application, although it may be useful during development.
             If it is not possible to recover from the error,
             display an alert panel that instructs the user to quit the application by pressing the Home button.
             */

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            result = NO;
        }

        return result;

    }

    - (void)setValueTo:(AnswerState)value {
        self.answer.answer = [NSNumber numberWithInt:value];
        [self doContextSave];
    }

    - (void)setNotesTo:(NSString *)text {
        self.answer.notes = text;
        [self doContextSave];
        [self updateNotesBadge];
    }

    - (void)addImageWithFullName:(NSString *)fullName andThumbnailName:(NSString *)thumbnailName {

        CheckListAnswerImages *thisAnswerImage = [NSEntityDescription insertNewObjectForEntityForName:@"CheckListAnswerImages" inManagedObjectContext:self.managedObjectContext];

        thisAnswerImage.fullPathName = fullName;
        thisAnswerImage.thumbPathName = thumbnailName;
        thisAnswerImage.imageAnswer = self.answer;
        thisAnswerImage.creationDate = [NSDate date];

        [self.answer addAnswerImagesObject:thisAnswerImage];

        [self doContextSave];
        [self updateImagesBadge];

    }

    - (BOOL)deleteImage:(CheckListAnswerImages *)image {

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imagesPath = [documentsDirectory stringByAppendingPathComponent:@"Images"];

        [self listFileAtPath:imagesPath];

        NSError *error;
        BOOL result;
        [self.managedObjectContext deleteObject:image];
        result = [self.managedObjectContext save:&error];
        if (!result) {
            NSLog(@"Error deleting database object: %@", [error localizedDescription]);
        } else {
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            NSLog(@"Deleting file: %@", image.fullPathName);
            if ([fileMgr removeItemAtPath:image.fullPathName error:&error] != YES)
                NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            NSLog(@"Deleting file: %@", image.thumbPathName);
            if ([fileMgr removeItemAtPath:image.thumbPathName error:&error] != YES)
                NSLog(@"Unable to delete file: %@", [error localizedDescription]);

            [self listFileAtPath:imagesPath];
            [self updateImagesBadge];
        }

        return result;
    }

    - (BOOL)addFavourite {
        Favourites *favourite = [NSEntityDescription insertNewObjectForEntityForName:@"Favourites" inManagedObjectContext:self.managedObjectContext];
        favourite.questionID = self.questionModel.key;
        BOOL itemAdded = [self doContextSave];
        [self updateFavouriteTip];
        return itemAdded;
    }

    - (BOOL)removeFavourite {

        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionID = %@", self.questionModel.key];
        [request setPredicate:predicate];

        //get the object
        NSError *error = nil;
        NSArray *records = [self.managedObjectContext executeFetchRequest:request error:&error];
        BOOL itemRemoved = NO;
        for (Favourites *item in records) {
            [self.managedObjectContext deleteObject:item];
            itemRemoved = YES;
        }

        [self updateFavouriteTip];
        return itemRemoved;

    }

    - (BOOL)isFavourite {
        return [self infoIsFavourite];
    }

    - (BOOL)infoIsFavourite {

        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionID = %@", self.questionModel.key];
        [request setPredicate:predicate];

        NSError *error = nil;
        NSUInteger count = 0;
        count = [self.managedObjectContext countForFetchRequest:request error:&error];

        return count > 0;

    }

    - (NSArray *)listFileAtPath:(NSString *)path {
        //-----> LIST ALL FILES <-----//
        NSLog(@"LISTING ALL FILES FOUND");

        int count;
        NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
        for (count = 0; count < (int) [directoryContent count]; count++) {
            NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
        }
        return directoryContent;
    }

    - (BOOL)isFirstQuestion {
        return (self.currentIndex == 0);
    }

    - (BOOL)isLastQuestion {
        return ((self.currentIndex + 1) == self.totalQuestions);

    }

    - (void)handleDataModelChange:(NSNotification *)note {
//    NSSet *updatedObjects = [[note userInfo] objectForKey:NSUpdatedObjectsKey];
//    NSSet *deletedObjects = [[note userInfo] objectForKey:NSDeletedObjectsKey];
//    NSSet *insertedObjects = [[note userInfo] objectForKey:NSInsertedObjectsKey];
//    [self updateNotesBadge];
//    [self updateImagesBadge];

        // Do something in response to this
    }

    - (void)pushController:(UIViewController *)controller
            withTransition:(UIViewAnimationTransition)transition {
        [UIView beginAnimations:nil context:NULL];
        [self.navigationController pushViewController:controller animated:NO];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationTransition:transition forView:self.view cache:YES];
        [UIView commitAnimations];
    }

    - (void)setViewControllers:(NSArray *)viewControllers
                withTransition:(UIViewAnimationTransition)transition {
        [UIView beginAnimations:nil context:NULL];
        [self.navigationController setViewControllers:viewControllers animated:NO];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationTransition:transition forView:self.view cache:YES];
        [UIView commitAnimations];
    }

    - (void)viewDidUnload {
        [self setColourIndicator:nil];
        [self setToolBar:nil];
        [self setPrevQuestionLabel:nil];
        [super viewDidUnload];
    }

@end
