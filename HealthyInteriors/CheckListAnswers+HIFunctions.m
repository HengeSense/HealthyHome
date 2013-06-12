//
//  CheckListAnswers+HIFunctions.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

@implementation CheckListAnswers (HIFunctions)

//
//- (BOOL)answerToQuestionExists:(NSString *)questionID
//{
//    CheckListQuestionAnswers * answer = [self answerToQuestionWithID:questionID];
//    if (answer) {
//        return YES;
//    } else {
//        return NO;
//    }
//}
//
//- (BOOL)questionHasValidAnswer:(NSString *)questionID
//{
//    for (CheckListQuestionAnswers * answer in self.checkListQuestions) {
//        if ([answer.questionID isEqualToString:questionID]) {
//            return [answer.questionAnswered boolValue];
//        }
//    }
//    return NO;
//}
//
//- (BOOL)questionAnsweredYes:(NSString *)questionID
//{
//    for (CheckListQuestionAnswers * answer in self.checkListQuestions) {
//        if ([answer.questionID isEqualToString:questionID] && [answer.questionAnswered boolValue]) {
//            return [answer.answer boolValue];
//        }
//    }
//    return NO;
//}

    - (AnswerState)getAnswerStateForQuestion:(NSString *)questionID {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:questionID];
        if (answer) {
            return [answer.answer integerValue];
        } else {
            return AnswerStateNotAnswered;
        }
    }

    - (CheckListQuestionAnswers *)answerToQuestionWithID:(NSString *)questionID {
        for (CheckListQuestionAnswers *answer in self.checkListQuestions) {
            if ([answer.questionID isEqualToString:questionID]) {
                return answer;
            }
        }
        return nil;
    }

    - (UIImage *)smallImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:questionID];
        if (answer) {
            return [answer smallImageForAnswerToTemplateQuestion:templateModel];
        } else {
            return [UIImage imageNamed:@"question_16.png"];
        }

    }

    - (UIImage *)largeImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:questionID];
        if (answer) {
            return [[self answerToQuestionWithID:questionID] largeImageForAnswerToTemplateQuestion:templateModel];
        } else {
            return [UIImage imageNamed:@"question_24.png"];
        }
    }

    - (UIColor *)textColourForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel {

        switch ([self getAnswerStateForQuestion:questionID]) {

            case AnswerStateYes:

                if (templateModel.yesIsBad) {
                    return templateModel.categoryModel.checkList.badAnswerTextColour;
                } else {
                    return templateModel.categoryModel.checkList.goodAnswerTextColour;
                }
                break;

            case AnswerStateNo:

                if (templateModel.yesIsBad) {
                    return templateModel.categoryModel.checkList.goodAnswerTextColour;
                } else {
                    return templateModel.categoryModel.checkList.badAnswerTextColour;
                }
                break;

            case AnswerStateNotApplicable:

            case AnswerStateNotAnswered:

            default:
                return [UIColor blackColor];

        }
    }

    - (UIColor *)backColourForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)templateModel {
        switch ([self getAnswerStateForQuestion:questionID]) {

            case AnswerStateYes:

                if (templateModel.yesIsBad) {
                    return templateModel.categoryModel.checkList.badAnswerBackColour;
                } else {
                    return templateModel.categoryModel.checkList.goodAnswerBackColour;
                }
                break;

            case AnswerStateNo:

                if (templateModel.yesIsBad) {
                    return templateModel.categoryModel.checkList.goodAnswerBackColour;
                } else {
                    return templateModel.categoryModel.checkList.badAnswerBackColour;
                }
                break;

            case AnswerStateNotApplicable:

            case AnswerStateNotAnswered:

            default:
                return [UIColor whiteColor];
        }
    }

    - (BOOL)isAnswerToQuestionAnAsset:(HICheckListQuestionModel *)questionModel {

        switch ([self getAnswerStateForQuestion:questionModel.key]) {

            case AnswerStateYes:

                if (questionModel.yesIsBad) {
                    return NO;
                } else {
                    return YES;
                }
                break;

            case AnswerStateNo:

                if (questionModel.yesIsBad) {
                    return YES;
                } else {
                    return NO;
                }
                break;

            case AnswerStateNotApplicable:

            case AnswerStateNotAnswered:

            default:
                return NO;

        }
    }

    - (BOOL)isAnswerToQuestionAChallenge:(HICheckListQuestionModel *)templateModel {

        switch ([self getAnswerStateForQuestion:templateModel.key]) {

            case AnswerStateYes:

                if (templateModel.yesIsBad) {
                    return YES;
                } else {
                    return NO;
                }
                break;

            case AnswerStateNo:

                if (templateModel.yesIsBad) {
                    return NO;
                } else {
                    return YES;
                }
                break;

            case AnswerStateNotApplicable:

            case AnswerStateNotAnswered:

            default:
                return NO;

        }

    }

    - (NSUInteger)countOfImagesForQuestion:(HICheckListQuestionModel *)templateModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:templateModel.key];
        return answer.answerImages.count;
    }

    - (BOOL)questionHasNotes:(HICheckListQuestionModel *)templateModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:templateModel.key];
        return answer.notes && answer.notes.length > 0;
    }

    - (BOOL)questionHasImages:(HICheckListQuestionModel *)templateModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:templateModel.key];
        return answer.answerImages.count > 0;
    }

@end
