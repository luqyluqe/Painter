//
//  PTMarkRenderer.h
//

#import <Foundation/Foundation.h>
#import "PTMarkVisitor.h"
#import "PTDot.h"
#import "PTVertex.h"
#import "PTStroke.h"

@interface PTMarkRenderer : NSObject <PTMarkVisitor>
{
  @private
  BOOL shouldMoveContextToDot_;
  
  @protected
  CGContextRef context_;
}

- (instancetype) initWithCGContext:(CGContextRef)context NS_DESIGNATED_INITIALIZER;

- (void) visitMark:(id <PTMark>)mark;
- (void) visitDot:(PTDot *)dot;
- (void) visitVertex:(PTVertex *)vertex;
- (void) visitStroke:(PTStroke *)stroke;

@end
