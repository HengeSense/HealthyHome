//
// Created by Mark O'Flynn on 8/06/13.
// Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class HIQuestionViewDataSource;

@protocol HIQuestionViewDataSource <NSObject>

    - (NSInteger)totalNumberOfQuestions;

    - (HICheckListQuestionModel *)questionAtIndex:(NSInteger)index;

    - (CheckListQuestionAnswers *)getAnswerForQuestion:(NSString *)questionID;

    - (HIQuestionViewDataSource *)parentDataSourceForQuestion:(HICheckListQuestionModel *)question;

    - (NSString *)getBackTitle;

@end