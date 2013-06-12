//
//  HIQuestionDetailDelegate.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckListAnswers+HIFunctions.h"

@class CheckListAnswerImages;

@protocol HIQuestionDetailDelegate <NSObject>

    - (void)setValueTo:(AnswerState)value;

    - (void)setNotesTo:(NSString *)text;

    - (void)addImageWithFullName:(NSString *)fullName andThumbnailName:(NSString *)thumbnailName;

    - (BOOL)deleteImage:(CheckListAnswerImages *)image;

    - (BOOL)addFavourite;

    - (BOOL)removeFavourite;

    - (BOOL)isFavourite;

@end
