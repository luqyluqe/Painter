//
//  PTDot.m
//

#import "PTDot.h"


@implementation PTDot
@synthesize size=size_, color=color_;

- (void) acceptMarkVisitor:(id <PTMarkVisitor>)visitor
{
  [visitor visitDot:self];
}

#pragma mark -
#pragma mark NSCopying method

// it needs to be implemented for memento
- (id)copyWithZone:(NSZone *)zone
{
  PTDot *dotCopy = [[[self class] allocWithZone:zone] initWithLocation:self.location];
  
  // copy the color
  dotCopy.color = [UIColor colorWithCGColor:(self.color).CGColor];
  
  // copy the size
  dotCopy.size = size_;
  
  return dotCopy;
}


#pragma mark -
#pragma mark NSCoder methods

- (instancetype)initWithCoder:(NSCoder *)coder
{
  if (self = [super initWithCoder:coder])
  {
    color_ = [coder decodeObjectForKey:@"DotColor"];
    size_ = [coder decodeFloatForKey:@"DotSize"];
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [super encodeWithCoder:coder];
  [coder encodeObject:color_ forKey:@"DotColor"];
  [coder encodeFloat:size_ forKey:@"DotSize"];
}

#pragma mark -
#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void) drawWithContext:(CGContextRef)context
{
  CGFloat x = self.location.x;
  CGFloat y = self.location.y;
  CGFloat frameSize = self.size;
  CGRect frame = CGRectMake(x - frameSize / 2.0, 
                            y - frameSize / 2.0, 
                            frameSize, 
                            frameSize);
  
  CGContextSetFillColorWithColor (context,(self.color).CGColor);
  CGContextFillEllipseInRect(context, frame);
}

@end
