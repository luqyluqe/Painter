//
//  PTCoordinatingController.h
//

#import <Foundation/Foundation.h>
#import "PTExampleCanvasViewController.h"
#import "PTPaletteViewController.h"
#import "PTThumbnailViewController.h"

typedef NS_ENUM(unsigned int, ButtonTag) {
  kButtonTagDone,
  kButtonTagOpenPaletteView,
  kButtonTagOpenThumbnailView
};

@interface PTCoordinatingController : NSObject

@property (nonatomic, readonly) UIViewController *activeViewController;
@property (nonatomic, readonly) PTExampleCanvasViewController *canvasViewController;

+ (PTCoordinatingController *) sharedInstance;

- (IBAction) requestViewChangeByObject:(id)object;

@end
