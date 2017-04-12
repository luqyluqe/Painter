//
//  PTDot.h
//

#import <Foundation/Foundation.h>
#import "PTVertex.h"

@protocol PTMarkVisitor;

@interface PTDot : PTVertex
{
  @private
  UIColor *color_;
  CGFloat size_;
}

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat size;

// for the Visitor pattern
- (void) acceptMarkVisitor:(id <PTMarkVisitor>)visitor;

// for the Prototype pattern
- (id) copyWithZone:(NSZone *)zone;

// for the Memento pattern
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;
- (void)encodeWithCoder:(NSCoder *)coder;

@end
