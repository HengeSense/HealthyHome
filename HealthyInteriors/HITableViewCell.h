//
// Created by Mark O'Flynn on 1/08/13.
// Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "UACellBackgroundView.h"

@interface HITableViewCell : UITableViewCell
    @property(nonatomic, retain) UIColor *topColor;
    @property(nonatomic, retain) UIColor *bottomColor;

    - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

    - (void)setPosition:(UACellBackgroundViewPosition)newPosition;
@end