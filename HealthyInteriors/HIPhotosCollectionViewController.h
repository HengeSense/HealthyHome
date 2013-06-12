//
//  HIPhotosCollectionViewController.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICollectionViewController.h"
#import "HIQuestionDetailDelegate.h"
#import "MBProgressHUD.h"

@interface HIPhotosCollectionViewController : HICollectionViewController <UIActionSheetDelegate,
        UIImagePickerControllerDelegate,
        UICollectionViewDelegateFlowLayout,
        MBProgressHUDDelegate>

    @property(nonatomic, strong) HICheckListQuestionModel *questionModel;
    @property(weak, nonatomic) id <HIQuestionDetailDelegate> delegate;
    @property(nonatomic, strong) CheckListQuestionAnswers *answer;

@end
