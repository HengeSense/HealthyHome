//
//  HICheckListCategoryModel.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HICheckListModel;
@class HICheckListQuestionModel;

@interface HICheckListCategoryModel : NSObject

    @property(nonatomic, strong) NSString *name;
    @property(nonatomic, strong) NSString *key;
    @property(nonatomic, strong) HICheckListModel *checkList;
    @property(nonatomic, strong) NSMutableArray *questions;

    - (id)init;

    - (HICheckListQuestionModel *)addQuestionWithText:(NSString *)questionText;

    - (HICheckListQuestionModel *)getQuestionAtIndex:(NSUInteger)index;

    - (NSUInteger)questionsCount;

    - (HICheckListQuestionModel *)findQuestionWithKey:(NSString *)key;

@end
