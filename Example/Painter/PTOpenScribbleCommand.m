//
//  PTOpenScribbleCommand.m
//

#import "PTOpenScribbleCommand.h"
#import "PTCoordinatingController.h"
#import "PTExampleCanvasViewController.h"

@implementation PTOpenScribbleCommand

- (instancetype) initWithScribbleSource:(id <PTScribbleSource>) aScribbleSource
{
  if (self = [super init])
  {
    self.scribbleSource = aScribbleSource;
  }
  
  return self;
}

- (void) execute
{
  // get a scribble from the scribbleSource_
  PTScribble *scribble = [self.scribbleSource scribble];
  
  // set it to the current PTCanvasViewController
  PTCoordinatingController *coordinator = [PTCoordinatingController sharedInstance];
  PTExampleCanvasViewController *controller = coordinator.canvasViewController;
  controller.scribble = scribble;
  
  // then tell the coordinator to change views
  [coordinator requestViewChangeByObject:self];
}

@end
