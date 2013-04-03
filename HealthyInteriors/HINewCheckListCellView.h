//
//  HINewCheckListCell.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 29/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HICheckListModel;
@class MAConfirmButton;

@interface HINewCheckListCellView : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *storeLabel;

-(void)configureCellWithTemplate:(HICheckListModel *)template;

@end
