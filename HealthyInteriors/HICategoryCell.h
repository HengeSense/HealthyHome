//
//  HICategoryCell.h
//  Healthy Home
//
//  Created by Mark O'Flynn on 30/07/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HITableViewCell.h"

@interface HICategoryCell : HITableViewCell

    @property(strong, nonatomic) IBOutlet UILabel *categoryLabel;
    @property(strong, nonatomic) IBOutlet UILabel *assetsLabel;
    @property(strong, nonatomic) IBOutlet UILabel *unansweredLabel;
    @property(strong, nonatomic) IBOutlet UILabel *challengesLabel;
    @property(strong, nonatomic) IBOutlet UIImageView *ratingView;
    @property(assign, nonatomic) int assets;
    @property(assign, nonatomic) int challenges;
    @property(assign, nonatomic) int unanswered;

    - (void)isChallenge;

    - (void)isAsset;

@end
