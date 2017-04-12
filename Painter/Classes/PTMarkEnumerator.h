//
//  PTMarkEnumerator.h
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+Stack.h"
#import "PTMark.h"

@interface PTMarkEnumerator : NSEnumerator
{
  @private
  NSMutableArray *stack_;
}

@property (nonatomic, readonly, copy) NSArray *allObjects;
@property (nonatomic, readonly, strong) id nextObject;

@end
