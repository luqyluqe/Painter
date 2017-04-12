//
//  NSMutableArray+Private.h

//


//

#import <Foundation/Foundation.h>


@interface NSMutableArray (Stack)

- (void) push:(id)object;
@property (nonatomic, readonly, strong) id pop;
- (void) dropBottom;

@end
