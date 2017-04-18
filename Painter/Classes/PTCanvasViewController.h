//
//  PTCanvasViewController.h
//  Pods
//
//  Created by luqy on 4/18/17.
//
//

#import "PTScribble.h"
#import "PTCanvasView.h"

@interface PTCanvasViewController : UIViewController

@property (nonatomic, strong) PTCanvasView *canvasView;
@property (nonatomic, strong) PTScribble *scribble;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;
@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, readonly, strong) NSInvocation *drawScribbleInvocation;
@property (nonatomic, readonly, strong) NSInvocation *undrawScribbleInvocation;

- (void) executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation;
- (void) unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation;

@end
