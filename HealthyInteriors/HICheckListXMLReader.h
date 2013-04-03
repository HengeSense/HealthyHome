
#import <UIKit/UIKit.h>
#import "HICheckListModel.h"

@class HICheckListModel;

@interface HICheckListXMLReader : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) HICheckListModel * checkList;

- (HICheckListXMLReader *) initXMLParser;

@end
