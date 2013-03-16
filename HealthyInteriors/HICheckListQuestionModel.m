//
//  HICheckListQuestion.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListQuestionModel.h"

@implementation HICheckListQuestionModel

- (id) init {
    if (self = [super init]) {
        self.answerType = AnswerTypeNone;
        self.yesIsBad = YES;
    }
    return self;
}

@end
