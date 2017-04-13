//
//  PTCoordinatingController.m
//

#import "PTCoordinatingController.h"

@interface PTCoordinatingController ()

- (void) initialize;

@end


@implementation PTCoordinatingController

- (void) initialize
{
  _canvasViewController = [[PTCanvasViewController alloc] init];
  _activeViewController = self.canvasViewController;
}

#pragma mark -
#pragma mark PTCoordinatingController Singleton Implementation

+ (PTCoordinatingController *) sharedInstance
{
    static PTCoordinatingController *sharedCoordinator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCoordinator = [[super alloc] init];
        
        // initialize the first view controller
        // and keep it with the singleton
        [sharedCoordinator initialize];
    });
  
    return sharedCoordinator;
}

- (id) copyWithZone:(NSZone*)zone
{
  return self;
}

#pragma mark -
#pragma mark A method for view transitions

- (IBAction) requestViewChangeByObject:(id)object
{
  
  if ([object isKindOfClass:[UIBarButtonItem class]])
  {
    switch (((UIBarButtonItem *)object).tag) 
    {
      case kButtonTagOpenPaletteView:
      {
        // load a PTPaletteViewController
        PTPaletteViewController *controller = [[PTPaletteViewController alloc] init];
        
        // transition to the PTPaletteViewController
        [self.canvasViewController presentModalViewController:controller
                                                 animated:YES];
        
        // set the activeViewController to 
        // paletteViewController
        _activeViewController = controller;
      }
        break;
      case kButtonTagOpenThumbnailView:
      {
        // load a PTThumbnailViewController
        PTThumbnailViewController *controller = [[PTThumbnailViewController alloc] init];
        
        
        // transition to the PTThumbnailViewController
        [self.canvasViewController presentModalViewController:controller
                                                 animated:YES];
        
        // set the activeViewController to
        // PTThumbnailViewController
        _activeViewController = controller;
      }
        break;
      default:
        // just go back to the main canvasViewController
        // for the other types 
      {
        // The Done command is shared on every 
        // view controller except the PTCanvasViewController
        // When the Done button is hit, it should
        // take the user back to the first page in
        // conjunction with the design
        // other objects will follow the same path
        [self.canvasViewController dismissModalViewControllerAnimated:YES];
        
        // set the activeViewController back to 
        // canvasViewController
        _activeViewController = _canvasViewController;
      }
        break;
    }
  }
  // every thing else goes to the main canvasViewController
  else 
  {
    [self.canvasViewController dismissModalViewControllerAnimated:YES];
    
    // set the activeViewController back to 
    // canvasViewController
    _activeViewController = _canvasViewController;
  }
  
}

@end
