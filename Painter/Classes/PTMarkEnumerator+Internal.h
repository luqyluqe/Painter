//
//  PTMarkEnumerator+Private.h
//

#import "PTMarkEnumerator.h"


@interface PTMarkEnumerator ()

- (instancetype) initWithMark:(id <PTMark>)mark;
- (void) traverseAndBuildStackWithMark:(id <PTMark>)mark;

@end
