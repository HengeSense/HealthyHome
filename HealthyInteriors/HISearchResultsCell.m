//
//  HIQuestionCell.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/06/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HISearchResultsCell.h"

@interface HISearchResultsCell (/* private */)

@end

@implementation HISearchResultsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HISearchResultsCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
        self.backgroundView = [[UACellBackgroundView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
