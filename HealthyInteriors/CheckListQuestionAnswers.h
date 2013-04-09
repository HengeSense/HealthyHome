//
//  CheckListQuestionAnswers.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CheckListQuestionAnswers : NSManagedObject

@property (nonatomic, retain) NSNumber * answer;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * questionID;
@property (nonatomic, retain) NSSet *answerImages;
@property (nonatomic, retain) NSManagedObject *questionCheckList;
@end

@interface CheckListQuestionAnswers (CoreDataGeneratedAccessors)

- (void)addAnswerImagesObject:(NSManagedObject *)value;
- (void)removeAnswerImagesObject:(NSManagedObject *)value;
- (void)addAnswerImages:(NSSet *)values;
- (void)removeAnswerImages:(NSSet *)values;

@end
