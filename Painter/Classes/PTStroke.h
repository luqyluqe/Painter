//
//  PTStroke.h
//

#import <Foundation/Foundation.h>
#import "PTMark.h"
#import "PTMarkEnumerator.h"

@protocol PTMarkVisitor;

@interface PTStroke : NSObject <PTMark>
{
  @private
  NSMutableArray *children_;
}

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id <PTMark> lastChild;

- (void) addMark:(id <PTMark>) mark;
- (void) removeMark:(id <PTMark>) mark;
- (id <PTMark>) childMarkAtIndex:(NSUInteger) index;

// for the Visitor pattern
- (void) acceptMarkVisitor:(id <PTMarkVisitor>)visitor;

// for the Prototype pattern
- (id) copyWithZone:(NSZone *)zone;

// for the Iterator pattern
@property (nonatomic, readonly, strong) NSEnumerator *enumerator;

// for internal iterator implementation
- (void) enumerateMarksUsingBlock:(void (^)(id <PTMark> item, BOOL *stop)) block;

// for the Memento pattern
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;
- (void)encodeWithCoder:(NSCoder *)coder;

@end
