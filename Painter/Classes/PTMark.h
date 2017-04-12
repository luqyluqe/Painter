//
//  PTMark.h
//

#import <UIKit/UIKit.h>
#import "PTMarkVisitor.h"


@protocol PTMark <NSObject, NSCopying, NSCoding>

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id <PTMark> lastChild;

@property (nonatomic, readonly, strong) id copy;
- (void) addMark:(id <PTMark>) mark;
- (void) removeMark:(id <PTMark>) mark;
- (id <PTMark>) childMarkAtIndex:(NSUInteger) index;

// for the Visitor pattern
- (void) acceptMarkVisitor:(id <PTMarkVisitor>) visitor;

// for the Iterator pattern
@property (nonatomic, readonly, strong) NSEnumerator *enumerator;

// for internal iterator implementation
- (void) enumerateMarksUsingBlock:(void (^)(id <PTMark> item, BOOL *stop)) block;

// for a bad example
- (void) drawWithContext:(CGContextRef) context;

@end
