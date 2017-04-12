//
//  PTStrokeSizeCommand.h
//

#import <Foundation/Foundation.h>
#import "PTCommand.h"

@class PTSetStrokeSizeCommand;

@protocol PTSetStrokeSizeCommandDelegate

- (void) command:(PTSetStrokeSizeCommand *)command 
                didRequestForStrokeSize:(CGFloat *)size;

@end


@interface PTSetStrokeSizeCommand : PTCommand 

@property (nonatomic, weak) id <PTSetStrokeSizeCommandDelegate> delegate;

- (void) execute;

@end
