//
//  HINewCheckListCell.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 29/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HINewCheckListCellView.h"
#import "MAConfirmButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation HINewCheckListCellView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.storeLabel.layer.cornerRadius = 5;
}

-(void)configureCellWithTemplate:(HICheckListModel *)template
{

    self.titleLabel.text = template.name;
    self.summaryLabel.text = template.shortDescription;
    
    if (template.isPurchased) {
        self.storeLabel.text = @"Installed";
    } else {
        self.storeLabel.text = @"Buy";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
