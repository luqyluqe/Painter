//
//  PTSaveScribbleCommand.m
//

#import "PTSaveScribbleCommand.h"
#import "PTScribbleManager.h"
#import "PTCoordinatingController.h"
#import "UIView+UIImage.h"

@implementation PTSaveScribbleCommand

- (void) execute
{
  // get a hold of all necessary information
  // from an instance of PTCanvasViewController
  // for saving its PTScribble
  PTCoordinatingController *coordinatingController = [PTCoordinatingController sharedInstance];
  PTCanvasViewController *canvasViewController = coordinatingController.canvasViewController;
  UIImage *canvasViewImage = [canvasViewController.canvasView image];
  PTScribble *scribble = canvasViewController.scribble;
  
  // use an instance of PTScribbleManager
  // to save the scribble and its thumbnail
  PTScribbleManager *scribbleManager = [[PTScribbleManager alloc] init];
  [scribbleManager saveScribble:scribble thumbnail:canvasViewImage];
  
  // finally show an alertbox that says
  // after the scribble is saved
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Your scribble is saved"
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
  [alertView show];
}

@end
