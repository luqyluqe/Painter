//
//  PTSetStrokeColorCommand.m
//

#import "PTSetStrokeColorCommand.h"
#import "PTCoordinatingController.h"
#import "PTCanvasViewController.h"

@implementation PTSetStrokeColorCommand

@synthesize delegate=delegate_;
@synthesize postColorUpdateProvider=postColorUpdateProvider_;
@synthesize RGBValuesProvider=RGBValuesProvider_;


- (void) execute
{
  CGFloat redValue = 0.0;
  CGFloat greenValue = 0.0;
  CGFloat blueValue = 0.0;
  
  // Retrieve RGB values from a delegate or a block 
  
  // Delegation (object adapter) approach:
  [self.delegate command:self didRequestColorComponentsForRed:&redValue
                                                    green:&greenValue
                                                     blue:&blueValue];
  
  // Block approach:
  if (RGBValuesProvider_ != nil)
  {
    RGBValuesProvider_(&redValue, &greenValue, &blueValue);
  }
  
  // Create a color object based on the RGB values
  UIColor *color = [UIColor colorWithRed:redValue
                                   green:greenValue
                                    blue:blueValue
                                   alpha:1.0];
  
  // Assign it to the current canvasViewController
  PTCoordinatingController *coordinator = [PTCoordinatingController sharedInstance];
  PTCanvasViewController *controller = coordinator.canvasViewController;
  controller.strokeColor = color;
  
  // Forward a post update message
  
  // Delegation approach:
  [self.delegate command:self didFinishColorUpdateWithColor:color];
  
  // Block approach:
  if (postColorUpdateProvider_ != nil)
  {
    postColorUpdateProvider_(color);
  }
}

@end
