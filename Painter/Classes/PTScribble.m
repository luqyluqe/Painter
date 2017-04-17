//
//  PTScribble.m
//


#import "PTScribbleMemento+Friend.h"
#import "PTScribble.h"
#import "PTGraph.h"

// A private category for PTScribble
// that contains a mark property available
// only to its objects
@interface PTScribble ()

@property (nonatomic, strong) id <PTMark> mark;

@end


@implementation PTScribble

- (instancetype) init
{
  if (self = [super init])
  {
    // the parent should be a composite
    // object (i.e. PTStroke)
    self.mark = [[PTGraph alloc] init];
  }
  
  return self;
}

#pragma mark -
#pragma mark Methods for PTMark management

- (void) addMark:(id <PTMark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark
{
  // manual KVO invocation
  [self willChangeValueForKey:@"mark"];
  
  // if the flag is set to YES
  // then add this aMark to the 
  // *PREVIOUS*PTMark as part of an
  // aggregate.
  // Based on our design, it's supposed
  // to be the last child of the main
  // parent
  if (shouldAddToPreviousMark)
  {
    [self.mark.lastChild addMark:aMark];
  }
  // otherwise attach it to the parent
  else 
  {
    [self.mark addMark:aMark];
    incrementalMark_ = aMark;
  }
  
  // manual KVO invocation
  [self didChangeValueForKey:@"mark"];
}

- (void) removeMark:(id <PTMark>)aMark
{  
  // do nothing if aMark is the parent
  if (aMark == self.mark) return;
  
  // manual KVO invocation
  [self willChangeValueForKey:@"mark"];
  
  [self.mark removeMark:aMark];
  
  // we don't need to keep the 
  // incrementalMark_ reference
  // as it's just removed in the parent
  if (aMark == incrementalMark_)
  {
    incrementalMark_ = nil;
  }
  
  // manual KVO invocation
  [self didChangeValueForKey:@"mark"];
}


#pragma mark -
#pragma mark Methods for memento

- (instancetype) initWithMemento:(PTScribbleMemento*)aMemento
{
  if (self = [super init])
  {
    if (aMemento.hasCompleteSnapshot)
    {
      self.mark = aMemento.mark;
    }
    else 
    {
      // if the memento contains only
      // incremental mark, then we need to
      // create a parent PTStroke object to 
      // hold it
      self.mark = [[PTStroke alloc] init];
      [self attachStateFromMemento:aMemento];
    }
  }
  
  return self;
}


- (void) attachStateFromMemento:(PTScribbleMemento *)memento
{
  // attach any mark from a memento object
  // to the main parent 
  [self addMark:memento.mark shouldAddToPreviousMark:NO];
}


- (PTScribbleMemento *) scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot
{
  id <PTMark> mementoMark = incrementalMark_;
  
  // if the resulting memento asks
  // for a complete snapshot, then 
  // set it with self.mark
  if (hasCompleteSnapshot)
  {
    mementoMark = self.mark;
  }
  // but if incrementalMark_
  // is nil then we can't do anything
  // but bail out
  else if (mementoMark == nil)
  {
    return nil;
  }
  
  PTScribbleMemento *memento = [[PTScribbleMemento alloc]
                               initWithMark:mementoMark];
  memento.hasCompleteSnapshot = hasCompleteSnapshot;
  
  return memento;
}


- (PTScribbleMemento *) scribbleMemento
{
  return [self scribbleMementoWithCompleteSnapshot:YES];
}


+ (PTScribble *) scribbleWithMemento:(PTScribbleMemento *)aMemento
{
  PTScribble *scribble = [[PTScribble alloc] initWithMemento:aMemento];
  return scribble;
}

@end
