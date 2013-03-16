//
//  CheckListQuestionAnswers+HIFunctions.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "CheckListQuestionAnswers.h"
#import "HICheckListQuestionModel.h"

@interface CheckListQuestionAnswers (HIFunctions)

- (UIImage *)smallImageForAnswerToTemplateQuestion:(HICheckListQuestionModel *)templateModel;
- (UIImage *)largeImageForAnswerToTemplateQuestion:(HICheckListQuestionModel *)templateModel;

@end
