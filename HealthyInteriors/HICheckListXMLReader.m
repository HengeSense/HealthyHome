
#import "HICheckListXMLReader.h"

@interface HICheckListXMLReader ()

@property (nonatomic, strong) NSMutableString * currentElementValue;
@property (nonatomic, strong) HICheckListModel * currentCheckList;
@property (nonatomic, strong) HICheckListCategoryModel * currentCategory;
@property (nonatomic, strong) HICheckListQuestionModel * currentQuestion;

@end

@implementation HICheckListXMLReader

- (HICheckListXMLReader *) initXMLParser {
	
	if (self = [super init]) {
    }
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {

    NSLog(@"Processing Element: %@", elementName);

	if ([elementName isEqualToString:@"CheckList"]) {
        
		self.currentCheckList = [[HICheckListModel alloc] init];
        self.currentCheckList.name = [attributeDict valueForKey:@"name"];
        self.currentCheckList.key = [attributeDict valueForKey:@"id"];
        
		NSLog(@"Creating CheckList: %@", self.currentCheckList.name);
        
	} else if ([elementName isEqualToString:@"Category"]) {
        
        self.currentCategory = [self.currentCheckList addCategroyWithName:[attributeDict valueForKey:@"title"]];
        self.currentCategory.key = [attributeDict valueForKey:@"id"];
 		NSLog(@"Creating category: %@", self.currentCategory.name);
       
    } else if([elementName isEqualToString:@"Question"]) {
        
        self.currentQuestion = [self.currentCategory addQuestionWithText:@""];
        self.currentQuestion.key = [attributeDict valueForKey:@"id"];
        self.currentQuestion.yesIsBad = [[attributeDict valueForKey:@"yesIsBad"] isEqualToString:@"true"];
        NSString * type = [attributeDict valueForKey:@"type"];
        if ([type isEqualToString:@"boolean"]) {
            self.currentQuestion.answerType = AnswerTypeBoolean;
        }
        else {
            self.currentQuestion.answerType = AnswerTypeNone;
        }
				
	}
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 

	if(!self.currentElementValue)
		self.currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[self.currentElementValue appendString:string];
	
	NSLog(@"Processing Value: %@", string);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    NSString * elementString = [self.currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([elementName isEqualToString:@"CheckList"]) {
        self.checkList = self.currentCheckList;
    } else if ([elementName isEqualToString:@"checkListInfo"]) {
        self.currentCheckList.description = elementString;
    } else if ([elementName isEqualToString:@"questionText"]) {
        self.currentQuestion.text = elementString;
    } else if ([elementName isEqualToString:@"questionInfo"]) {
        self.currentQuestion.information = elementString;
    }
    self.currentElementValue = nil;

}

@end
