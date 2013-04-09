//
//  CheckListAnswerImages.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CheckListQuestionAnswers;

@interface CheckListAnswerImages : NSManagedObject

@property (nonatomic, retain) NSString * fullPathName;
@property (nonatomic, retain) NSString * thumbPathName;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) CheckListQuestionAnswers *imageAnswer;

@end
