//
//  PTScribbleThumbnailViewImageProxy.h
//

#import <Foundation/Foundation.h>
#import "PTScribbleThumbnailView.h"
#import "PTCommand.h"

@interface PTScribbleThumbnailViewImageProxy : PTScribbleThumbnailView
{
  @private
  PTScribble *scribble_;
  PTCommand *touchCommand_;
  UIImage *realImage_;
  BOOL loadingThreadHasLaunched_;  
}

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) PTScribble *scribble;
@property (nonatomic, strong) PTCommand *touchCommand;

@end
