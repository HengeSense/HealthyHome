//
//  HICheckListModel.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#define assetTextColour [UIColor colorWithRed:0.099 green:0.356 blue:0.109 alpha:1.000]
#define challengeTextColour [UIColor colorWithRed:0.570 green:0.111 blue:0.142 alpha:1.000]
#define assetBackColour [UIColor greenColor]
#define challengeBackColour [UIColor redColor]

@interface HICheckListModel (/*private*/)
    @property(nonatomic, strong) NSMutableArray *categories;
    @property(nonatomic, strong) NSMutableArray *questions;
@end

@implementation HICheckListModel

    - (id)init {
        if (self = [super init]) {
            self.name = @"";
            self.description = @"";
            self.shortDescription = @"";
            self.filename = @"";
            self.categories = [[NSMutableArray alloc] init];
            self.goodAnswerTextColour = assetTextColour;
            self.badAnswerTextColour = challengeTextColour;
            self.goodAnswerBackColour = assetBackColour;
            self.badAnswerBackColour = challengeBackColour;
        }
        return self;
    }

    - (HICheckListCategoryModel *)addCategoryWithName:(NSString *)categoryName {
        HICheckListCategoryModel *category = [[HICheckListCategoryModel alloc] init];
        category.name = categoryName;
        category.checkList = self;
        [self.categories addObject:category];
        return category;
    }

    - (void)addCategory:(HICheckListCategoryModel *)category {
        category.checkList = self;
        [self.categories addObject:category];
    }

    - (HICheckListCategoryModel *)categoryAtIndex:(NSUInteger)index {
        return [self.categories objectAtIndex:index];
    }

    - (NSUInteger)indexForCategory:(HICheckListCategoryModel *)category {
        return [self.categories indexOfObject:category];
    }

    - (NSUInteger)categoriesCount {
        return self.categories.count;
    }

    - (HICheckListQuestionModel *)findQuestionWithKey:(NSString *)key {
        for (HICheckListCategoryModel *category in self.categories) {

            HICheckListQuestionModel *question = [category findQuestionWithKey:key];
            if (question) {
                return question;
            }
        }
        return nil;
    }

    - (NSUInteger)indexOfQuestion:(HICheckListQuestionModel *)question {
        return [self.questions indexOfObject:question];
    }

    - (HICheckListQuestionModel *)questionAtIndex:(NSUInteger)index {
        return [self.questions objectAtIndex:index];
    }

    - (HICheckListQuestionModel *)getNextQuestion:(HICheckListQuestionModel *)question {
        NSUInteger index = [self.questions indexOfObject:question];

        if (index == [self totalNumberOfQuestions] - 1) {
            //reached the end
            return nil;
        } else {

            return [self.questions objectAtIndex:index + 1];
        }

    }

    - (HICheckListQuestionModel *)getPrevQuestion:(HICheckListQuestionModel *)question {
        NSUInteger index = [self.questions indexOfObject:question];

        if (index == 0) {
            //reached the end
            return nil;
        } else {

            return [self.questions objectAtIndex:index - 1];
        }

    }

    - (NSUInteger)totalNumberOfQuestions {
        return self.questions.count;
    }

    - (void)didFinishReadingFile {
        //finished reading the file, so build the array of questions

        self.questions = [[NSMutableArray alloc] init];
        for (HICheckListCategoryModel *category in self.categories) {

            [self.questions addObjectsFromArray:category.questions];

        }

    }

@end
