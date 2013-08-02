//
//  HIQuestionCell.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/06/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIReportTypeCell.h"

@interface HIReportTypeCell (/* private */)

@end

@implementation HIReportTypeCell

    - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HIReportTypeCell" owner:self options:nil];
            self = [nibArray objectAtIndex:0];

            self.backgroundView = [[UACellBackgroundView alloc] initWithFrame:CGRectZero];
        }
        return self;
    }

@end
