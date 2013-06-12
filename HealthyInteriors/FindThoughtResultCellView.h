//
//  FindThoughtResult.h
//  Natural Thoughts Manager
//
//  Created by Mark O'Flynn on 4/01/12.
//  Copyright (c) 2012 Thales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"

@class SSRatingPicker;
@class Thought;

@interface FindThoughtResultCellView : PRPNibBasedTableViewCell

    @property(nonatomic, strong) IBOutlet UIImageView *iconImageView;
    @property(nonatomic, strong) IBOutlet UILabel *textLabel;
    @property(nonatomic, strong) IBOutlet UIImageView *star1;
    @property(nonatomic, strong) IBOutlet UIImageView *star2;
    @property(nonatomic, strong) IBOutlet UIImageView *star3;
    @property(nonatomic, strong) IBOutlet UIImageView *star4;
    @property(nonatomic, strong) IBOutlet UIImageView *star5;
    @property(nonatomic, strong) IBOutlet UILabel *textLabelTime;
    @property(nonatomic, strong) IBOutlet UILabel *textLabelDate;

    - (void)configureCellWithThought:(Thought *)thisThought;

@end
