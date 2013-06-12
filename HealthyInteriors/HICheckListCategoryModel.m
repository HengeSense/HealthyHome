//
//  HICheckListCategoryModel.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

@interface HICheckListCategoryModel (/*private*/)
@end

@implementation HICheckListCategoryModel

    - (id)init {
        if (self = [super init]) {
            self.name = @"";
            self.questions = [[NSMutableArray alloc] init];
        }
        return self;
    }

    - (HICheckListQuestionModel *)addQuestionWithText:(NSString *)questionText {
        HICheckListQuestionModel *question = [[HICheckListQuestionModel alloc] init];
        question.text = questionText;
        question.categoryModel = self;
        [self.questions addObject:question];
        return question;
    }

    - (HICheckListQuestionModel *)getQuestionAtIndex:(NSUInteger)index {
        return [self.questions objectAtIndex:index];
    }

    - (NSUInteger)questionsCount {
        return self.questions.count;
    }

    - (HICheckListQuestionModel *)findQuestionWithKey:(NSString *)key {
        for (HICheckListQuestionModel *question in self.questions) {
            if ([question.key isEqualToString:key]) {
                return question;
            }
        }
        return nil;
    }

@end
