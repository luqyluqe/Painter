//
//  PTOpenScribbleCommand.h
//

#import <Foundation/Foundation.h>
#import "PTCommand.h"
#import "PTScribbleSource.h"

@interface PTOpenScribbleCommand : PTCommand

@property (nonatomic, strong) id <PTScribbleSource> scribbleSource;

- (instancetype) initWithScribbleSource:(id <PTScribbleSource>) aScribbleSource NS_DESIGNATED_INITIALIZER;
- (void) execute;

@end
