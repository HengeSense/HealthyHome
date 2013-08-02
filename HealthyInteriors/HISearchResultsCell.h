//
//  HIQuestionCell.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/06/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HITableViewCell.h"

@interface HISearchResultsCell : HITableViewCell
@property(strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property(strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
