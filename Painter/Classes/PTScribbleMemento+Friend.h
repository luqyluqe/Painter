//
//  PTScribbleMemento+Private.h
//

#import <Foundation/Foundation.h>
#import "PTMark.h"
#import "PTScribbleMemento.h"

@interface PTScribbleMemento ()

- (instancetype) initWithMark:(id <PTMark>)aMark;

@property (nonatomic, copy) id <PTMark> mark;
@property (nonatomic, assign) BOOL hasCompleteSnapshot;

@end
