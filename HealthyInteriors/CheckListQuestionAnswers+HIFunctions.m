//
//  CheckListQuestionAnswers+HIFunctions.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "CheckListQuestionAnswers+HIFunctions.h"
#import "CheckListAnswers+HIFunctions.h"

@implementation CheckListQuestionAnswers (HIFunctions)

- (UIImage *)smallImageForAnswerToTemplateQuestion:(HICheckListQuestionModel *)templateModel
{
    if ([self.answer boolValue]) {
        
        if (!templateModel.yesIsBad) {
            
            return [UIImage imageNamed:@"thumb_dn_16.png"];

        } else {

            return [UIImage imageNamed:@"thumb_up_16.png"];
            
        }
        
    } else {
        
        if (templateModel.yesIsBad) {
            
            return [UIImage imageNamed:@"thumb_dn_16.png"];
            
        } else {
            
            return [UIImage imageNamed:@"thumb_up_16.png"];
            
        }
    }

}

- (UIImage *)largeImageForAnswerToTemplateQuestion:(HICheckListQuestionModel *)templateModel
{
    if ([self.answer boolValue]) {
        
        if (templateModel.yesIsBad) {
            
            return [UIImage imageNamed:@"thumb_dn_24.png"];
            
        } else {
            
            return [UIImage imageNamed:@"thumb_up_24.png"];
            
        }
        
    } else {
        
        if (!templateModel.yesIsBad) {
            
            return [UIImage imageNamed:@"thumb_dn_24.png"];
            
        } else {
            
            return [UIImage imageNamed:@"thumb_up_24.png"];
            
        }
    }
    
}

@end
