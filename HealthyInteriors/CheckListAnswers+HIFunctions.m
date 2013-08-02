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

    - (UIImage *)smallImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)questionModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:questionID];
        if (answer) {
            return [answer smallImageForAnswerToTemplateQuestion:questionModel];
        } else {
            return [UIImage imageNamed:@"question_16.png"];
        }

    }

    - (UIImage *)largeImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)questionModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:questionID];
        if (answer) {
            return [[self answerToQuestionWithID:questionID] largeImageForAnswerToTemplateQuestion:questionModel];
        } else {
            return [UIImage imageNamed:@"question_24.png"];
        }
    }

    - (UIColor *)textColourForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)questionModel {

        switch ([self getAnswerStateForQuestion:questionID]) {

            case AnswerStateYes:

                if (questionModel.yesIsBad) {
                    return questionModel.categoryModel.checkList.badAnswerTextColour;
                } else {
                    return questionModel.categoryModel.checkList.goodAnswerTextColour;
                }
                break;

            case AnswerStateNo:

                if (questionModel.yesIsBad) {
                    return questionModel.categoryModel.checkList.goodAnswerTextColour;
                } else {
                    return questionModel.categoryModel.checkList.badAnswerTextColour;
                }
                break;

            case AnswerStateNotApplicable:

            case AnswerStateNotAnswered:

            default:
                return [UIColor blackColor];

        }
    }

    - (UIColor *)backColourForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)questionModel {
        switch ([self getAnswerStateForQuestion:questionID]) {

            case AnswerStateYes:

                if (questionModel.yesIsBad) {
                    return questionModel.categoryModel.checkList.badAnswerBackColour;
                } else {
                    return questionModel.categoryModel.checkList.goodAnswerBackColour;
                }
                break;

            case AnswerStateNo:

                if (questionModel.yesIsBad) {
                    return questionModel.categoryModel.checkList.goodAnswerBackColour;
                } else {
                    return questionModel.categoryModel.checkList.badAnswerBackColour;
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

    - (BOOL)isAnswerToQuestionAChallenge:(HICheckListQuestionModel *)questionModel {

        switch ([self getAnswerStateForQuestion:questionModel.key]) {

            case AnswerStateYes:

                if (questionModel.yesIsBad) {
                    return YES;
                } else {
                    return NO;
                }
                break;

            case AnswerStateNo:

                if (questionModel.yesIsBad) {
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

    - (NSUInteger)countOfImagesForQuestion:(HICheckListQuestionModel *)questionModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:questionModel.key];
        return answer.answerImages.count;
    }

    - (BOOL)questionHasNotes:(HICheckListQuestionModel *)questionModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:questionModel.key];
        return answer.notes && answer.notes.length > 0;
    }

    - (BOOL)questionHasImages:(HICheckListQuestionModel *)questionModel {
        CheckListQuestionAnswers *answer = [self answerToQuestionWithID:questionModel.key];
        return answer.answerImages.count > 0;
    }

    - (NSUInteger)numberOfAssetsForCheckList:(HICheckListModel *)checkListModel {
        int count = 0;
        int totalQuestions = checkListModel.totalNumberOfQuestions;

        for (int index = 0; index < totalQuestions; index++) {
            if ([self isAnswerToQuestionAnAsset:[checkListModel questionAtIndex:index]]) {
                count++;
            }
        }
        //NSLog(@"Number of Assets: %d", count);
        return (NSUInteger) count;
    }

    - (NSUInteger)numberOfChallengesForCheckList:(HICheckListModel *)checkListModel {
        int count = 0;
        int totalQuestions = checkListModel.totalNumberOfQuestions;

        for (int index = 0; index < totalQuestions; index++) {
            if ([self isAnswerToQuestionAChallenge:[checkListModel questionAtIndex:index]]) {
                count++;
            }
        }
        //NSLog(@"Number of Challenges: %d", count);
        return (NSUInteger) count;
    }

    - (NSUInteger)numberNotCompletedForCheckList:(HICheckListModel *)checkListModel {
        int count = checkListModel.totalNumberOfQuestions - [self numberOfAssetsForCheckList:checkListModel] - [self numberOfChallengesForCheckList:checkListModel];
        //NSLog(@"Number not answered: %d", count);
        return count;
    }

    - (NSUInteger)numberOfAssetsForCategory:(HICheckListCategoryModel *)categoryListModel {
        int count = 0;
        int totalQuestions = categoryListModel.questionsCount;

        for (int index = 0; index < totalQuestions; index++) {
            if ([self isAnswerToQuestionAnAsset:[categoryListModel getQuestionAtIndex:index]]) {
                count++;
            }
        }
        //NSLog(@"Number of Assets: %d", count);
        return (NSUInteger) count;
    }

    - (NSUInteger)numberOfChallengesForCategory:(HICheckListCategoryModel *)categoryListModel {
        int count = 0;
        int totalQuestions = categoryListModel.questionsCount;

        for (int index = 0; index < totalQuestions; index++) {
            if ([self isAnswerToQuestionAChallenge:[categoryListModel getQuestionAtIndex:index]]) {
                count++;
            }
        }
        //NSLog(@"Number of Challenges: %d", count);
        return (NSUInteger) count;
    }

    - (NSUInteger)numberNotCompletedForCategory:(HICheckListCategoryModel *)categoryListModel {
        int count = categoryListModel.questionsCount - [self numberOfAssetsForCategory:categoryListModel] - [self numberOfChallengesForCategory:categoryListModel];
        //NSLog(@"Number not answered: %d", count);
        return count;
    }

@end
