//
//  HICheckListModel.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HICheckListCategoryModel.h"
#import "HICheckListQuestionModel.h"

@interface HICheckListModel : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, strong) NSString * key;
@property (nonatomic, retain) NSString * description;
@property (nonatomic, strong) UIColor *goodAnswerColour;
@property (nonatomic, strong) UIColor *badAnswerColour;

- (id) init;
- (HICheckListCategoryModel *)addCategroyWithName:(NSString *)categoryName;
- (void) addCategory:(HICheckListCategoryModel *)category;
- (HICheckListCategoryModel *)categoryAtIndex:(NSUInteger)index;
- (NSUInteger)categoriesCount;

@end
