//
//  HICheckListsXMLReader.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 29/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListsXMLReader.h"

@interface HICheckListsXMLReader ()

@end

@implementation HICheckListsXMLReader

- (HICheckListsXMLReader *) initXMLParser {
	
	if (self = [super init]) {
    }
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
    
    NSLog(@"Processing Element: %@", elementName);
    
	if ([elementName isEqualToString:@"CheckLists"]) {
        
        self.templates = [[NSMutableArray alloc] init];
        
	} else if ([elementName isEqualToString:@"CheckList"]) {
        
        HICheckListModel * model = [[HICheckListModel alloc] init];
        model.name = [attributeDict valueForKey:@"name"];
        model.key = [attributeDict valueForKey:@"id"];
        model.filename = [attributeDict valueForKey:@"filename"];
        
        [self.templates addObject:model];
        
 		NSLog(@"Creating template: %@", model.name);
        
	}
    
}

@end
