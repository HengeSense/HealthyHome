//
//  HIQuestionCell.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/06/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HIQuestionCell : UITableViewCell

    - (void)isFavourite:(BOOL)value;

    - (void)setQuestion:(HICheckListQuestionModel *)question andAnswer:(CheckListAnswers *)answers;

@end
