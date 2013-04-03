//
//  HICheckListTemplateDelegate.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HICheckListModel;

@protocol HICheckListTemplateDelegate <NSObject>

- (int)getNumberOfTemplates;
- (HICheckListModel *)checkListWithName:(NSString *)name;
- (HICheckListModel *)checkListWithID:(NSString *)key;
- (HICheckListModel *)checkListWithIndex:(NSUInteger)index;
@end
