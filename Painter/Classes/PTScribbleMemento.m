//
//  ScirbbleMemento.m
//

#import "PTScribbleMemento.h"
#import "PTScribbleMemento+Friend.h"

@implementation PTScribbleMemento

@synthesize mark=mark_;

- (NSData *) data
{
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mark_];
  return data;
}

+ (PTScribbleMemento *) mementoWithData:(NSData *)data
{
  // It raises an NSInvalidArchiveOperationException if data is not a valid archive
  id <PTMark> retoredMark = (id <PTMark>)[NSKeyedUnarchiver unarchiveObjectWithData:data];
  PTScribbleMemento *memento = [[PTScribbleMemento alloc]
                               initWithMark:retoredMark];
  
  return memento;
}

#pragma mark -
#pragma mark Private methods

- (instancetype) initWithMark:(id <PTMark>)aMark
{
  if (self = [super init])
  {
    self.mark = aMark;
  }
  
  return self;
}

@end
