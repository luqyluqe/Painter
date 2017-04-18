//
//  PTStrokeSizeCommand.m
//

#import "PTSetStrokeSizeCommand.h"
#import "PTCoordinatingController.h"
#import "PTExampleCanvasViewController.h"

@implementation PTSetStrokeSizeCommand

- (void) execute
{
  // get the current stroke size
  // from whatever it's my delegate
  CGFloat strokeSize = 1;
  [self.delegate command:self didRequestForStrokeSize:&strokeSize];
  
  // get a hold of the current
  // canvasViewController from
  // the coordinatingController
  // (see the Mediator pattern chapter
  // for details)
  PTCoordinatingController *coordinator = [PTCoordinatingController sharedInstance];
  PTExampleCanvasViewController *controller = coordinator.canvasViewController;
  
  // assign the stroke size to
  // the canvasViewController
  controller.strokeSize = strokeSize;
}

@end
