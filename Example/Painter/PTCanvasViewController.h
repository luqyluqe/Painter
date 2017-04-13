//
//  PTCanvasViewController.h
//

#import <UIKit/UIKit.h>
#import "PTScribble.h"
#import "PTCanvasView.h"
#import "PTCanvasViewGenerator.h"
#import "PTCommandBarButton.h"
#import "NSMutableArray+Stack.h"

@interface PTCanvasViewController : UIViewController

@property (nonatomic, strong) PTCanvasView *canvasView;
@property (nonatomic, strong) PTScribble *scribble;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;
@property (nonatomic, assign) CGPoint startPoint;

- (void) loadCanvasViewWithGenerator:(PTCanvasViewGenerator *)generator;

- (IBAction) onBarButtonHit:(id) button;
- (IBAction) onCustomBarButtonHit:(PTCommandBarButton *)barButton;

@property (nonatomic, readonly, strong) NSInvocation *drawScribbleInvocation;
@property (nonatomic, readonly, strong) NSInvocation *undrawScribbleInvocation;

- (void) executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation;
- (void) unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation;

@end

