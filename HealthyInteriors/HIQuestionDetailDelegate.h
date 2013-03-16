//
//  HIQuestionDetailDelegate.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HIQuestionDetailDelegate <NSObject>

- (void) setValueforQuestionID:(NSString *)questionID to:(BOOL)value;
- (NSString *)getNotesforQuestionID:(NSString *)questionID;
- (void) setNotesforQuestionID:(NSString *)questionID to:(NSString *)text;

@end
