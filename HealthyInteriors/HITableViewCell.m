//
// Created by Mark O'Flynn on 1/08/13.
// Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HICategoryCell.h"

@implementation HITableViewCell {

}

    - (void)setPosition:(UACellBackgroundViewPosition)newPosition {
        [(UACellBackgroundView *) self.backgroundView setPosition:newPosition];
    }

    - (void)setTopColor:(UIColor *)topColor {
        _topColor = topColor;
        [(UACellBackgroundView *) self.backgroundView setTopColor:topColor];
    }

    - (void)setBottomColor:(UIColor *)bottomColor {
        _bottomColor = bottomColor;
        [(UACellBackgroundView *) self.backgroundView setBottomColor:bottomColor];
    }

    - (void)setSelected:(BOOL)selected animated:(BOOL)animated {
        [super setSelected:selected animated:animated];

        // Configure the view for the selected state
    }
@end