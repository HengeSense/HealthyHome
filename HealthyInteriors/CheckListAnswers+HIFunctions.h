//
//  CheckListAnswers+HIFunctions.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "CheckListAnswers.h"
#import "HICheckListQuestionModel.h"

typedef NS_ENUM(NSInteger, AnswerState) {
    AnswerStateNotAnswered,
    AnswerStateNotApplicable,
    AnswerStateYes,
    AnswerStateNo
};

@interface CheckListAnswers (HIFunctions)


//- (BOOL)answerToQuestionExists:(NSString *)questionID;
//- (BOOL)questionAnsweredYes:(NSString *)questionID;
//- (BOOL)questionHasValidAnswer:(NSString *)questionID;
- (AnswerState)getAnswerStateForQuestion:(NSString *)questionID;
- (CheckListQuestionAnswers *)answerToQuestionWithID:(NSString *)questionID;
- (UIImage *)smallImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel;
- (UIImage *)largeImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel;
- (UIColor *)colourForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel;

@end
