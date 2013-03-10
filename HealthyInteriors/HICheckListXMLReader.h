
#import <UIKit/UIKit.h>
#import "HICheckListModel.h"

@interface HICheckListXMLReader : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) HICheckListModel * checkList;

- (HICheckListXMLReader *) initXMLParser; 

@end
