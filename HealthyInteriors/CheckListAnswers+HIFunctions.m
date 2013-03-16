//
//  CheckListAnswers+HIFunctions.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "CheckListAnswers+HIFunctions.h"
#import "CheckListQuestionAnswers+HIFunctions.h"

@implementation CheckListAnswers (HIFunctions)


- (BOOL)questionHasBeenAnswered:(NSString *)questionID
{
    for (CheckListQuestionAnswers * answer in self.checkListQuestions) {
        if ([answer.questionID isEqualToString:questionID]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)questionAnsweredYes:(NSString *)questionID
{
    for (CheckListQuestionAnswers * answer in self.checkListQuestions) {
        if ([answer.questionID isEqualToString:questionID]) {
            return [answer.answer boolValue];
        }
    }
    return NO;
}

- (CheckListQuestionAnswers *)answerToQuestionWithID:(NSString *)questionID
{
    for (CheckListQuestionAnswers * answer in self.checkListQuestions) {
        if ([answer.questionID isEqualToString:questionID]) {
            return answer;
        }
    }
    return nil;
}

- (UIImage *)smallImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel
{
    if ([self questionHasBeenAnswered:questionID]) {
        return [[self answerToQuestionWithID:questionID] smallImageForAnswerToTemplateQuestion:templateModel];
    } else {
        return [UIImage imageNamed:@"question_16.png"];
    }
    
}

- (UIImage *)largeImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel
{
    if ([self questionHasBeenAnswered:questionID]) {
        return [[self answerToQuestionWithID:questionID] largeImageForAnswerToTemplateQuestion:templateModel];
    } else {
        return [UIImage imageNamed:@"question_24.png"];
    }
}

- (UIColor *)colourForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel
{

    if (![self questionHasBeenAnswered:questionID]) {
        return [UIColor blackColor];
    } else if ([self questionAnsweredYes:questionID]) {
        if (templateModel.yesIsBad) {
            return templateModel.categoryModel.checkList.badAnswerColour;
        } else {
            return templateModel.categoryModel.checkList.goodAnswerColour;
        }
    } else {
        if (templateModel.yesIsBad) {
            return templateModel.categoryModel.checkList.goodAnswerColour;
        } else {
            return templateModel.categoryModel.checkList.badAnswerColour;
        }
    }
}

@end
