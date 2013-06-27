//
//  HICheckListModel.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HICheckListCategoryModel.h"
#import "HICheckListQuestionModel.h"

@interface HICheckListModel : NSObject

    @property(nonatomic, retain) NSString *name;
    @property(nonatomic, retain) NSString *key;
    @property(nonatomic, retain) NSString *shortDescription;
    @property(nonatomic, retain) NSString *description;
    @property(nonatomic, retain) NSString *filename;
    @property(nonatomic, assign) BOOL isPurchased;
    @property(nonatomic, retain) UIColor *goodAnswerTextColour;
    @property(nonatomic, retain) UIColor *badAnswerTextColour;
    @property(nonatomic, retain) UIColor *goodAnswerBackColour;
    @property(nonatomic, retain) UIColor *badAnswerBackColour;
    @property(nonatomic, retain) UIColor *noAnswerBackColour;
    @property(nonatomic, retain) UIColor *noAnswerTextColour;
    @property(nonatomic, readonly) NSUInteger totalNumberOfQuestions;

    - (id)init;

    - (HICheckListCategoryModel *)addCategoryWithName:(NSString *)categoryName;

    - (void)addCategory:(HICheckListCategoryModel *)category;

    - (HICheckListCategoryModel *)categoryAtIndex:(NSUInteger)index;

    - (NSUInteger)indexForCategory:(HICheckListCategoryModel *)category;

    - (NSUInteger)categoriesCount;

    - (HICheckListQuestionModel *)findQuestionWithKey:(NSString *)key;

    - (HICheckListQuestionModel *)questionAtIndex:(NSUInteger)index;

    - (HICheckListQuestionModel *)getNextQuestion:(HICheckListQuestionModel *)question;

    - (HICheckListQuestionModel *)getPrevQuestion:(HICheckListQuestionModel *)question;

    - (NSUInteger)indexOfQuestion:(HICheckListQuestionModel *)question;

    - (void)didFinishReadingFile;

    - (NSArray *)searchQuestionsForText:(NSString *)text;

    - (NSArray *)searchInfoForText:(NSString *)text;

@end
