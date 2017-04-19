//
//  PTCanvasViewController.m
//

#import "PTExampleCanvasViewController.h"
#import "PTDot.h"
#import "PTStroke.h"

@implementation PTExampleCanvasViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
  [super viewDidLoad];
  
  // Get a default canvas view
  // with the factory method of 
  // the PTCanvasViewGenerator
//  PTCanvasViewGenerator *defaultGenerator = [[PTCanvasViewGenerator alloc] init];
//  [self loadCanvasViewWithGenerator:defaultGenerator];
    self.canvasView=(PTCanvasView*)self.view;
  
  // setup default stroke color and size
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  CGFloat redValue = [userDefaults floatForKey:@"red"];
  CGFloat greenValue = [userDefaults floatForKey:@"green"];
  CGFloat blueValue = [userDefaults floatForKey:@"blue"];
  CGFloat sizeValue = [userDefaults floatForKey:@"size"];
  
  self.strokeSize = sizeValue;
  self.strokeColor = [UIColor colorWithRed:redValue
                                       green:greenValue 
                                        blue:blueValue 
                                       alpha:1.0];
}

#pragma mark -
#pragma mark Toolbar button hit method

- (IBAction) onBarButtonHit:(id)button
{
  UIBarButtonItem *barButton = button;
  
  if (barButton.tag == 4)
  {
    [self.undoManager undo];
  }
  else if (barButton.tag == 5)
  {
    [self.undoManager redo];
  }
}

- (IBAction) onCustomBarButtonHit:(PTCommandBarButton *)barButton
{
  [barButton.command execute];
}

#pragma mark -
#pragma mark Loading a PTCanvasView from a PTCanvasViewGenerator

- (void) loadCanvasViewWithGenerator:(PTCanvasViewGenerator *)generator
{
  [self.canvasView removeFromSuperview];
  PTCanvasView *aCanvasView = [generator canvasViewWithFrame:self.view.frame];
  self.canvasView = aCanvasView;
  NSInteger viewIndex = self.view.subviews.count - 1;
  [self.view insertSubview:self.canvasView atIndex:viewIndex];
}

@end
