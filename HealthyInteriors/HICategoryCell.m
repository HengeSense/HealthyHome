//
//  HICategoryCell.m
//  Healthy Home
//
//  Created by Mark O'Flynn on 30/07/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICategoryCell.h"

@interface HICategoryCell ()
@end

@implementation HICategoryCell
    - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {

            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HICategoryCell" owner:self options:nil];
            self = [nibArray objectAtIndex:0];

            self.backgroundView = [[UACellBackgroundView alloc] initWithFrame:CGRectZero];

        }

        return self;
    }

    - (void)isChallenge {
        self.ratingView.image = [UIImage imageNamed:@"thumb_dn_24"];
    }

    - (void)isAsset {
        self.ratingView.image = [UIImage imageNamed:@"thumb_up_24"];
    }

@end
