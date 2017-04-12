//
//  PTScribbleManager.h
//

#import <Foundation/Foundation.h>
#import "PTScribble.h"
#import "PTScribbleThumbnailViewImageProxy.h"

@interface PTScribbleManager : NSObject 
{
	
}

- (void) saveScribble:(PTScribble *)scribble thumbnail:(UIImage *)image;
@property (nonatomic, readonly) NSInteger numberOfScribbles;
- (PTScribble *) scribbleAtIndex:(NSInteger)index;
- (UIView *) scribbleThumbnailViewAtIndex:(NSInteger)index;

@end
