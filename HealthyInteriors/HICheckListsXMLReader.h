//
//  HICheckListsXMLReader.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 29/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HICheckListsXMLReader : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray * templates;

- (HICheckListsXMLReader *) initXMLParser;

@end
