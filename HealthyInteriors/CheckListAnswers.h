//
//  CheckListAnswers.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 1/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CheckListQuestionAnswers;

@interface CheckListAnswers : NSManagedObject

@property (nonatomic, retain) NSString * checkListID;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSSet *checkListQuestions;
@end

@interface CheckListAnswers (CoreDataGeneratedAccessors)

- (void)addCheckListQuestionsObject:(CheckListQuestionAnswers *)value;
- (void)removeCheckListQuestionsObject:(CheckListQuestionAnswers *)value;
- (void)addCheckListQuestions:(NSSet *)values;
- (void)removeCheckListQuestions:(NSSet *)values;

@end
