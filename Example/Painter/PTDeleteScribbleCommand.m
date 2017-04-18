//
//  PTDeleteScribbleCommand.m
//

#import "PTDeleteScribbleCommand.h"
#import "PTCoordinatingController.h"
#import "PTExampleCanvasViewController.h"

@implementation PTDeleteScribbleCommand

- (void) execute
{
  // get a hold of the current
  // PTCanvasViewController from
  // the PTCoordinatingController
  PTCoordinatingController *coordinatingController = [PTCoordinatingController sharedInstance];
  PTExampleCanvasViewController *canvasViewController = coordinatingController.canvasViewController;
  
  // create a new scribble for
  // canvasViewController
  PTScribble *newScribble = [[PTScribble alloc] init];
  canvasViewController.scribble = newScribble;
}


@end
