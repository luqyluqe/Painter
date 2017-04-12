//
//  PTVertex.m
//

#import "PTVertex.h"


@implementation PTVertex

@dynamic color, size;

- (instancetype) initWithLocation:(CGPoint) aLocation
{
  if (self = [super init])
  {
    self.location = aLocation;
  }
  
  return self;
}

// default properties do nothing
- (void) setColor:(UIColor *)color {}
- (UIColor *) color { return nil; }
- (void) setSize:(CGFloat)size {}
- (CGFloat) size { return 0.0; }

// PTMark operations do nothing
- (void) addMark:(id <PTMark>) mark {}
- (void) removeMark:(id <PTMark>) mark {}
- (id <PTMark>) childMarkAtIndex:(NSUInteger) index { return nil; }
- (id <PTMark>) lastChild { return nil; }
- (NSUInteger) count { return 0; }
- (NSEnumerator *) enumerator { return nil; }


- (void) acceptMarkVisitor:(id <PTMarkVisitor>)visitor
{
  [visitor visitVertex:self];
}

#pragma mark -
#pragma mark NSCopying method

// it needs to be implemented for memento
- (id)copyWithZone:(NSZone *)zone
{
  PTVertex *vertexCopy = [[[self class] allocWithZone:zone] initWithLocation:self.location];
  
  return vertexCopy;
}


#pragma mark -
#pragma mark NSCoder methods

- (instancetype)initWithCoder:(NSCoder *)coder
{
  if (self = [super init])
  {
    self.location = ((NSValue *)[coder decodeObjectForKey:@"VertexLocation"]).CGPointValue;
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:[NSValue valueWithCGPoint:self.location] forKey:@"VertexLocation"];
}

#pragma mark -
#pragma mark MarkIterator methods

// for internal iterator implementation
- (void) enumerateMarksUsingBlock:(void (^)(id <PTMark> item, BOOL *stop)) block {}

#pragma mark -
#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void) drawWithContext:(CGContextRef)context
{
  CGFloat x = self.location.x;
  CGFloat y = self.location.y;
  
  CGContextAddLineToPoint(context, x, y);
}

@end
