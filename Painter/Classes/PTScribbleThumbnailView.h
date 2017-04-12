//
//  ScribbleThumbnail.h
//

#import <Foundation/Foundation.h>
#import "PTScribble.h"
#import "PTScribbleSource.h"

@interface PTScribbleThumbnailView : UIView <PTScribbleSource> 
{
  @protected
  NSString *imagePath_;
  NSString *scribblePath_;
}

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) PTScribble *scribble;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *scribblePath;

@end
