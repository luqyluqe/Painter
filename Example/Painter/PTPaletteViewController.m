//
//  PTPaletteViewController.m
//

#import "PTPaletteViewController.h"

@implementation PTPaletteViewController

/*
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) 
  {
    // Custom initialization
    
  }
  return self;
}
 */

- (void) viewDidDisappear:(BOOL)animated
{
  // save the values of the sliders
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setFloat:redSlider_.value forKey:@"red"];
  [userDefaults setFloat:greenSlider_.value forKey:@"green"];
  [userDefaults setFloat:blueSlider_.value forKey:@"blue"];
  [userDefaults setFloat:sizeSlider_.value forKey:@"size"];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
  [super viewDidLoad];
  
  // initialize the RGB sliders with
  // a PTStrokeColorCommand
  PTSetStrokeColorCommand *colorCommand = (PTSetStrokeColorCommand *)redSlider_.command;
  
  // set each color component provider
  // to the color command
  colorCommand.RGBValuesProvider = ^(CGFloat *red, CGFloat *green, CGFloat *blue)
   {
     *red = redSlider_.value;
     *green = greenSlider_.value;
     *blue = blueSlider_.value;
   };
  
  // set a post-update provider to the command
  // for any callback after a new color is set
  colorCommand.postColorUpdateProvider = ^(UIColor *color) 
   {
     paletteView_.backgroundColor = color;
   };
  
  
  // restore the original values of the sliders
  // and the color of the small palette view
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  CGFloat redValue = [userDefaults floatForKey:@"red"];
  CGFloat greenValue = [userDefaults floatForKey:@"green"];
  CGFloat blueValue = [userDefaults floatForKey:@"blue"];
  CGFloat sizeValue = [userDefaults floatForKey:@"size"];
  
  redSlider_.value = redValue;
  greenSlider_.value = greenValue;
  blueSlider_.value = blueValue;
  sizeSlider_.value = sizeValue;
  
  UIColor *color = [UIColor colorWithRed:redValue
                                   green:greenValue
                                    blue:blueValue
                                   alpha:1.0];
  
  paletteView_.backgroundColor = color;
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning 
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
  [super viewDidUnload];
  // Release any stronged subviews of the main view.
  // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark PTSetStrokeColorCommandDelegate methods

- (void) command:(PTSetStrokeColorCommand *) command
                didRequestColorComponentsForRed:(CGFloat *) red
                                          green:(CGFloat *) green 
                                           blue:(CGFloat *) blue
{
  *red = redSlider_.value;
  *green = greenSlider_.value;
  *blue = blueSlider_.value;
}

- (void) command:(PTSetStrokeColorCommand *) command
                didFinishColorUpdateWithColor:(UIColor *) color
{
  paletteView_.backgroundColor = color;
}

#pragma mark PTSetStrokeSizeCommandDelegate method

- (void) command:(PTSetStrokeSizeCommand *)command
                didRequestForStrokeSize:(CGFloat *)size
{
  *size = sizeSlider_.value;
}

#pragma mark -
#pragma mark Slider event handler

- (IBAction) onCommandSliderValueChanged:(PTCommandSlider *)slider
{
  [slider.command execute];
}


@end
