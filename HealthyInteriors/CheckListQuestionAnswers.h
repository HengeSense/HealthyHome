//
//  CheckListQuestionAnswers.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CheckListAnswers;

@interface CheckListQuestionAnswers : NSManagedObject

@property (nonatomic, retain) NSString * questionID;
@property (nonatomic, retain) NSNumber * answer;
@property (nonatomic, retain) CheckListAnswers *questionCheckList;

@end
