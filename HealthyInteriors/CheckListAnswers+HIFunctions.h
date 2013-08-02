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

    - (UIImage *)smallImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)questionModel;

    - (UIImage *)largeImageForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)questionModel;

    - (UIColor *)textColourForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)questionModel;

    - (UIColor *)backColourForAnswerToQuestion:(NSString *)questionID forTemplateQuestion:(HICheckListQuestionModel *)questionModel;

    - (BOOL)isAnswerToQuestionAnAsset:(HICheckListQuestionModel *)questionModel;

    - (BOOL)isAnswerToQuestionAChallenge:(HICheckListQuestionModel *)questionModel;

    - (NSUInteger)countOfImagesForQuestion:(HICheckListQuestionModel *)questionModel;

    - (BOOL)questionHasNotes:(HICheckListQuestionModel *)questionModel;

    - (BOOL)questionHasImages:(HICheckListQuestionModel *)questionModel;

    - (NSUInteger)numberOfAssetsForCheckList:(HICheckListModel *)checkListModel;

    - (NSUInteger)numberOfChallengesForCheckList:(HICheckListModel *)checkListModel;

    - (NSUInteger)numberNotCompletedForCheckList:(HICheckListModel *)checkListModel;

    - (NSUInteger)numberOfAssetsForCategory:(HICheckListCategoryModel *)categoryListModel;

    - (NSUInteger)numberOfChallengesForCategory:(HICheckListCategoryModel *)categoryListModel;

    - (NSUInteger)numberNotCompletedForCategory:(HICheckListCategoryModel *)categoryListModel;

@end
