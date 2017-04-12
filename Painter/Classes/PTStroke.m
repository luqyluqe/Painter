//
//  PTStroke.m
//

#import "PTStroke.h"
#import "PTMarkEnumerator+Internal.h"

@implementation PTStroke

@dynamic location;

- (instancetype) init
{
  if (self = [super init])
  {
    children_ = [[NSMutableArray alloc] initWithCapacity:5];
  }
  
  return self;
}

- (void) setLocation:(CGPoint)aPoint
{
  // it doesn't set any arbitrary location
}

- (CGPoint) location
{
  // return the location of the first child
  if (children_.count > 0)
  {
    return ((PTStroke*)children_[0]).location;
  }
  
  // otherwise returns the origin
  return CGPointZero;
}

- (void) addMark:(id <PTMark>) mark
{
  [children_ addObject:mark];
}

- (void) removeMark:(id <PTMark>) mark
{
  // if mark is at this level then
  // remove it and return
  // otherwise, let every child
  // search for it
  if ([children_ containsObject:mark])
  {
    [children_ removeObject:mark];
  }
  else 
  {
    [children_ makeObjectsPerformSelector:@selector(removeMark:)
                               withObject:mark];
  }
}


- (id <PTMark>) childMarkAtIndex:(NSUInteger) index
{
  if (index >= children_.count) return nil;
  
  return children_[index];
}


// a convenience method to return the last child
- (id <PTMark>) lastChild
{
  return children_.lastObject;
}

// returns number of children
- (NSUInteger) count
{
  return children_.count;
}


- (void) acceptMarkVisitor:(id <PTMarkVisitor>)visitor
{
  for (id <PTMark> dot in children_)
  {
    [dot acceptMarkVisitor:visitor];
  }
  
  [visitor visitStroke:self];
}

#pragma mark -
#pragma mark NSCopying method


- (id)copyWithZone:(NSZone *)zone
{
  PTStroke *strokeCopy = [[[self class] allocWithZone:zone] init];
  
  // copy the color
  strokeCopy.color = [UIColor colorWithCGColor:(self.color).CGColor];
  
  // copy the size
  strokeCopy.size = self.size;
  
  // copy the children
  for (id <PTMark> child in children_)
  {
    id <PTMark> childCopy = [child copy];
    [strokeCopy addMark:child];
  }
  
  return strokeCopy;
}

#pragma mark -
#pragma mark NSCoder methods

- (instancetype)initWithCoder:(NSCoder *)coder
{
  if (self = [super init])
  {
    self.color = [coder decodeObjectForKey:@"StrokeColor"];
    self.size = [coder decodeFloatForKey:@"StrokeSize"];
    children_ = [coder decodeObjectForKey:@"StrokeChildren"];
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:self.color forKey:@"StrokeColor"];
  [coder encodeFloat:self.size forKey:@"StrokeSize"];
  [coder encodeObject:children_ forKey:@"StrokeChildren"];
}

#pragma mark -
#pragma mark enumerator methods

- (NSEnumerator *) enumerator
{
  return [[PTMarkEnumerator alloc] initWithMark:self];
}

- (void) enumerateMarksUsingBlock:(void (^)(id <PTMark> item, BOOL *stop)) block
{
  BOOL stop = NO;
  
  NSEnumerator *enumerator = [self enumerator];
  
  for (id <PTMark> mark in enumerator)
  {
    block (mark, &stop);
    if (stop)
      break;
  }
}

#pragma mark -
#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void) drawWithContext:(CGContextRef)context
{
  CGContextMoveToPoint(context, self.location.x, self.location.y);
  
  for (id <PTMark> mark in children_)
  {
    [mark drawWithContext:context];
  }
  
  CGContextSetLineWidth(context, self.size);
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetStrokeColorWithColor(context,(self.color).CGColor);
  CGContextStrokePath(context);
}

@end
