//
//  PTMarkVisitor.h
//

#import <UIKit/UIKit.h>


@protocol PTMark;
@class PTDot, PTVertex, PTStroke;

@protocol PTMarkVisitor <NSObject>

- (void) visitMark:(id <PTMark>)mark;
- (void) visitDot:(PTDot *)dot;
- (void) visitVertex:(PTVertex *)vertex;
- (void) visitStroke:(PTStroke *)stroke;

@end
