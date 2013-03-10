//
//  HICheckListTemplateManager.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListTemplateManager.h"
#import "HICheckListXMLReader.h"

@interface HICheckListTemplateManager ()
@property (nonatomic, strong) NSArray * checkLists;
- (HICheckListModel *)loadCheckListWithFileName:(NSString *)name;
@end

@implementation HICheckListTemplateManager

- (id) init
{
    if (self = [super init]) {
        self.checkLists = [[NSArray alloc] initWithObjects:[self loadCheckListWithFileName:@"HealthyHomeCheckList.xml"], nil];
    }
    return self;
}

- (HICheckListModel *)loadCheckListWithFileName:(NSString *)name
{
    NSXMLParser *xmlEngine = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]]];
    HICheckListXMLReader * reader = [[HICheckListXMLReader alloc] initXMLParser];
    xmlEngine.delegate = reader;
    
	//Start parsing the XML file.
    
	BOOL success = [xmlEngine parse];
	
	if(success) {
		NSLog(@"No Errors");
    } else {
		NSLog(@"Error Error Error!!!");
    }
    
    return reader.checkList;   
}

- (HICheckListModel *)checkListWithName:(NSString *)name
{
    for (HICheckListModel * checkList in self.checkLists) {
        if ([checkList.name isEqualToString:name]) {
            return checkList;
        }
    }
    
    return nil;
    
}

- (HICheckListModel *)checkListWithID:(NSString *)key
{
    for (HICheckListModel * checkList in self.checkLists) {
        if ([checkList.key isEqualToString:key]) {
            return checkList;
        }
    }
    
    return nil;
}

- (HICheckListModel *)checkListWithIndex:(NSUInteger)index
{
    return [self.checkLists objectAtIndex:index];
}

@end
