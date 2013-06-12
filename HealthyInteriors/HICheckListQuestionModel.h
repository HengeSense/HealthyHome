//
//  HICheckListQuestion.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HICheckListCategoryModel; 

typedef NS_ENUM(NSInteger, AnswerType) {
    AnswerTypeNone,
    AnswerTypeBoolean,
};

@interface HICheckListQuestionModel : NSObject

@property (nonatomic, strong) HICheckListCategoryModel * categoryModel;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSString * key;
@property (nonatomic, assign) AnswerType answerType;
@property (nonatomic, assign) BOOL yesIsBad;
@property (nonatomic, strong) NSString * information;
@property (nonatomic, strong) NSString * infoTitle;

- (id) init;

@end
