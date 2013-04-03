//
//  CheckListQuestionAnswers.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 1/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CheckListAnswers;

@interface CheckListQuestionAnswers : NSManagedObject

@property (nonatomic, retain) NSNumber * answer;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * questionAnswered;
@property (nonatomic, retain) NSString * questionID;
@property (nonatomic, retain) CheckListAnswers *questionCheckList;

@end
