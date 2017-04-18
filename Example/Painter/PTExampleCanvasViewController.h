//
//  PTCanvasViewController.h
//

#import "PTCanvasViewController.h"
#import "PTCanvasViewGenerator.h"
#import "PTCommandBarButton.h"
#import "NSMutableArray+Stack.h"

@interface PTExampleCanvasViewController : PTCanvasViewController

- (void) loadCanvasViewWithGenerator:(PTCanvasViewGenerator *)generator;

- (IBAction) onBarButtonHit:(id) button;
- (IBAction) onCustomBarButtonHit:(PTCommandBarButton *)barButton;

@end

