//
//  HICheckListModel.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListModel.h"

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
