//
//  HICheckListModel.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListModel.h"
#import "HICheckListCategoryModel.h"

@interface HICheckListModel (/*private*/)
@property (nonatomic, retain) NSMutableArray * categories;
@end

@implementation HICheckListModel

- (id) init
{
    if (self = [super init]) {
        self.name = @"";
        self.description = @"";
        self.categories = [[NSMutableArray alloc] init];
        self.goodAnswerColour = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        self.badAnswerColour = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    }
    return self;
}

- (HICheckListCategoryModel *)addCategroyWithName:(NSString *)categoryName
{
    HICheckListCategoryModel * category = [[HICheckListCategoryModel alloc] init];
    category.name = categoryName;
    category.checkList = self;
    [self.categories addObject:category];
    return category;
}

- (void) addCategory:(HICheckListCategoryModel *)category
{
    category.checkList = self;
    [self.categories addObject:category];
}

- (HICheckListCategoryModel *)categoryAtIndex:(NSUInteger)index
{
    return [self.categories objectAtIndex:index];
}

- (NSUInteger)categoriesCount
{
    return self.categories.count;
}

@end
