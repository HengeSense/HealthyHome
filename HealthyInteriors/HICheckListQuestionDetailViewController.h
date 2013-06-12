//
//  HICheckListQuestionDetailBaseController.h
//  
//
//  Created by Mark O'Flynn on 3/06/13.
//
//

#import <UIKit/UIKit.h>
#import "HICheckListQuestionModel.h"
#import "CheckListAnswers+HIFunctions.h"
#import "HIQuestionDetailDelegate.h"
#import "HIViewController.h"
#import "UIView+Bounce.h"
#import "SVSegmentedControl.h"
#import "NVUIGradientButton.h"

@protocol HIQuestionDetailDelegate;
@protocol HIQuestionViewDataSource;

@interface HICheckListQuestionDetailViewController : HIViewController <HIQuestionDetailDelegate, UIImagePickerControllerDelegate>

    @property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
    @property(nonatomic, strong) CheckListAnswers *checkListAnswers;
    @property(nonatomic, weak) id <HIQuestionViewDataSource> dataSource;
    @property(nonatomic, assign) NSUInteger currentQuestion;

@end
