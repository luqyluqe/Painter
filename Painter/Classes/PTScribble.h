//
//  PTScribble.h
//

#import <Foundation/Foundation.h>
#import "PTMark.h"
#import "PTScribbleMemento.h"

@interface PTScribble : NSObject
{
  @private
  id <PTMark> incrementalMark_;
}

// methods for PTMark management
- (void) addMark:(id <PTMark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark;
- (void) removeMark:(id <PTMark>)aMark;

// methods for memento
- (instancetype) initWithMemento:(PTScribbleMemento *)aMemento NS_DESIGNATED_INITIALIZER;
+ (PTScribble *) scribbleWithMemento:(PTScribbleMemento *)aMemento;
@property (nonatomic, readonly, strong) PTScribbleMemento *scribbleMemento;
- (PTScribbleMemento *) scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot;
- (void) attachStateFromMemento:(PTScribbleMemento *)memento;

@end
