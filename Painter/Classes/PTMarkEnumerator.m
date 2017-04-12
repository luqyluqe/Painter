//
//  PTMarkEnumerator.m
//

#import "PTMarkEnumerator.h"
#import "PTMarkEnumerator+Internal.h"

@implementation PTMarkEnumerator

- (NSArray *)allObjects
{
  // returns an array of yet-visited PTMark nodes
  // i.e. the remaining elements in the stack
  return [stack_ reverseObjectEnumerator].allObjects;
}

- (id)nextObject
{
  return [stack_ pop];
}

#pragma mark -
#pragma mark Private Methods

- (instancetype) initWithMark:(id <PTMark>)aMark
{
  if (self = [super init])
  {
    stack_ = [[NSMutableArray alloc] initWithCapacity:aMark.count];
    
    // post-orderly traverse the whole PTMark aggregate
    // and add individual Marks in a private stack
    [self traverseAndBuildStackWithMark:aMark];
  }
  
  return self;
}

- (void) traverseAndBuildStackWithMark:(id <PTMark>)mark
{
  // push post-order traversal
  // into the stack
  if (mark == nil) return;
  
  [stack_ push:mark];
  
  NSUInteger index = mark.count;
  id <PTMark> childMark;
  while (childMark = [mark childMarkAtIndex:--index]) 
  {
    [self traverseAndBuildStackWithMark:childMark];
  }
}

@end
