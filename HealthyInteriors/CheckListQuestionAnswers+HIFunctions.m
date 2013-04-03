//
//  CheckListQuestionAnswers+HIFunctions.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "CheckListQuestionAnswers+HIFunctions.h"
#import "CheckListAnswers+HIFunctions.h"

static NSString *const OKAnswer = @"thumb_up_%@.png";
static NSString *const NOKAnswer = @"thumb_dn_%@.png";
static NSString *const NotAnswered = @"question_%@.png";
static NSString *const Small = @"16";
static NSString *const Large = @"24";

@implementation CheckListQuestionAnswers (HIFunctions)

- (UIImage *)ImageForAnswerToTemplateQuestion:(HICheckListQuestionModel *)templateModel imageSize:(NSString *)size
{
    if (self.questionAnswered) {
        
        if ([self.answer boolValue]) {
            
            //Yes answer to the question
            
            if (templateModel.yesIsBad) {
                
                return [UIImage imageNamed:[NSString stringWithFormat:NOKAnswer, size]];
                
            } else {
                
                return [UIImage imageNamed:[NSString stringWithFormat:OKAnswer, size]];
                
            }
            
        } else {
            
            //No answer to the question
            
            if (templateModel.yesIsBad) {
                
                return [UIImage imageNamed:[NSString stringWithFormat:OKAnswer, size]];
                
            } else {
                
                return [UIImage imageNamed:[NSString stringWithFormat:NOKAnswer, size]];
                
            }
        }
        
    } else {
        
        return [UIImage imageNamed:[NSString stringWithFormat:NotAnswered, size]];
    }
    
}

- (UIImage *)smallImageForAnswerToTemplateQuestion:(HICheckListQuestionModel *)templateModel
{
    return [self ImageForAnswerToTemplateQuestion:templateModel imageSize:@"16"];
}

- (UIImage *)largeImageForAnswerToTemplateQuestion:(HICheckListQuestionModel *)templateModel
{
    return [self ImageForAnswerToTemplateQuestion:templateModel imageSize:@"24"];
}

@end
