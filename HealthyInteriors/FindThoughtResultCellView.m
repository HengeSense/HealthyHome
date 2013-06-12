//
//  FindThoughtResult.m
//  Natural Thoughts Manager
//
//  Created by Mark O'Flynn on 4/01/12.
//  Copyright (c) 2012 Thales. All rights reserved.
//

#import "Thought.h"
#import "ThoughtIconManager.h"

@implementation FindThoughtResultCellView

    @synthesize iconImageView;
    @synthesize textLabel;
    @synthesize star1;
    @synthesize star2;
    @synthesize star3;
    @synthesize star4;
    @synthesize star5;
    @synthesize textLabelTime;
    @synthesize textLabelDate;

#pragma mark - Class LifeCycle

    - (void)setRatingForImageView:(UIImageView *)imageView asOn:(BOOL)on {
        if (on) {
            imageView.image = [UIImage imageNamed:@"orange-star-view.png"];
            imageView.highlightedImage = [UIImage imageNamed:@"orange-star-view.png"];
        } else {
            imageView.image = [UIImage imageNamed:@"gray-star-view-2.png"];
            imageView.highlightedImage = [UIImage imageNamed:@"gray-star-view-2-selected.png"];
        }
    }

#pragma mark - Public Messages


    - (void)configureCellWithThought:(Thought *)thisThought {

        self.textLabel.text = thisThought.thought;
        self.textLabel.textColor = [UIColor colorWithHexString:thisThought.colour];

        int rating = [thisThought.rating intValue];
        [self setRatingForImageView:self.star1 asOn:(rating == 5)];
        [self setRatingForImageView:self.star2 asOn:(rating >= 4)];
        [self setRatingForImageView:self.star3 asOn:(rating >= 3)];
        [self setRatingForImageView:self.star4 asOn:(rating >= 2)];
        [self setRatingForImageView:self.star5 asOn:(rating >= 1)];

        if ([thisThought.imageName length] != 0) {
            self.iconImageView.image = [[ThoughtIconManager sharedThoughtIconManager] iconImageWithName:thisThought.imageName];
        }

        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        self.textLabelDate.text = [dateFormat stringFromDate:thisThought.timeStamp];

        NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
        [timeFormat setDateFormat:@"HH:mm:ss"];
        self.textLabelTime.text = [timeFormat stringFromDate:thisThought.timeStamp];

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }

@end
