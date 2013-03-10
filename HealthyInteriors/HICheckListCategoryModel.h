//
//  HICheckListCategoryModel.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HICheckListQuestionModel.h"

@class HICheckListModel;

@interface HICheckListCategoryModel : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) HICheckListModel * checkList;

- (id) init;
- (HICheckListQuestionModel *)addQuestionWithText:(NSString *)questionText;
- (HICheckListQuestionModel *)getQuestionAtIndex:(NSUInteger)index;
- (NSUInteger)questionsCount;

@end