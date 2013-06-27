//
//  HIQuestionCell.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/06/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "HIReportTypeCell.h"

@interface HIReportTypeCell (/* private */)

@end

@implementation HIReportTypeCell

    - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HIReportTypeCell" owner:self options:nil];
            self = [nibArray objectAtIndex:0];
        }
        return self;
    }

    - (void)setSelected:(BOOL)selected animated:(BOOL)animated {
        [super setSelected:selected animated:animated];

        // Configure the view for the selected state
    }

@end
