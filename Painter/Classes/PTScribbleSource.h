//
//  ScribbleSource.h
//

#import <UIKit/UIKit.h>
#import "PTScribble.h"

@protocol PTScribbleSource

@property (nonatomic, readonly, strong) PTScribble *scribble;

@end
