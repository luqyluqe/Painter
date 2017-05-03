//
//  PTCanvasViewController.m
//  Pods
//
//  Created by luqy on 4/18/17.
//
//

#import "PTCanvasViewController.h"
#import "PTDot.h"
#import "PTStroke.h"

@interface PTCanvasViewController ()

@end

@implementation PTCanvasViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    // initialize a PTScribble model
    self.scribble = [[PTScribble alloc] init];
}

// hook up everything with a new PTScribble instance
- (void) setScribble:(PTScribble *)aScribble
{
    if (_scribble != aScribble)
    {
        [_scribble removeObserver:self forKeyPath:@"mark"];
        _scribble = aScribble;
        
        // add itself to the scribble as
        // an observer for any changes to
        // its internal state - mark
        [_scribble addObserver:self
                    forKeyPath:@"mark"
                       options:NSKeyValueObservingOptionInitial |
         NSKeyValueObservingOptionNew
                       context:nil];
    }
}

#pragma mark - PTStroke color and size accessor methods

- (void) setStrokeSize:(CGFloat) aSize
{
    // enforce the smallest size
    // allowed
    _strokeSize = aSize>0?aSize:1;
}

#pragma mark - Draw PTScribble Invocation Generation Methods

- (NSInvocation *) drawScribbleInvocation
{
    NSMethodSignature *executeMethodSignature = [self.scribble
                                                 methodSignatureForSelector:
                                                 @selector(addMark:
                                                           shouldAddToPreviousMark:)];
    NSInvocation *drawInvocation = [NSInvocation
                                    invocationWithMethodSignature:
                                    executeMethodSignature];
    drawInvocation.target = self.scribble;
    drawInvocation.selector = @selector(addMark:shouldAddToPreviousMark:);
    BOOL attachToPreviousMark = NO;
    [drawInvocation setArgument:&attachToPreviousMark atIndex:3];
    
    return drawInvocation;
}

- (NSInvocation *) undrawScribbleInvocation
{
    NSMethodSignature *unexecuteMethodSignature = [self.scribble
                                                   methodSignatureForSelector:
                                                   @selector(removeMark:)];
    NSInvocation *undrawInvocation = [NSInvocation
                                      invocationWithMethodSignature:
                                      unexecuteMethodSignature];
    undrawInvocation.target = self.scribble;
    undrawInvocation.selector = @selector(removeMark:);
    
    return undrawInvocation;
}

#pragma mark - Draw PTScribble Command Methods

- (void) executeInvocation:(NSInvocation *)invocation
        withUndoInvocation:(NSInvocation *)undoInvocation
{
    [invocation retainArguments];
    
    [[self.undoManager prepareWithInvocationTarget:self]
     unexecuteInvocation:undoInvocation
     withRedoInvocation:invocation];
    
    [invocation invoke];
}

- (void) unexecuteInvocation:(NSInvocation *)invocation
          withRedoInvocation:(NSInvocation *)redoInvocation
{
    [[self.undoManager prepareWithInvocationTarget:self]
     executeInvocation:redoInvocation
     withUndoInvocation:invocation];
    
    [invocation invoke];
}

#pragma mark -
#pragma mark Touch Event Handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.startPoint = [[touches anyObject] locationInView:self.canvasView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:self.canvasView];
    
    // add a new stroke to scribble
    // if this is indeed a drag from
    // a finger
    if (CGPointEqualToPoint(lastPoint, self.startPoint))
    {
        id <PTMark> newStroke = [[PTStroke alloc] init];
        newStroke.color = self.strokeColor;
        newStroke.size = self.strokeSize;
        
        //[self.scribble addMark:newStroke shouldAddToPreviousMark:NO];
        
        // retrieve a new NSInvocation for drawing and
        // set new arguments for the draw command
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&newStroke atIndex:2];
        
        // retrieve a new NSInvocation for undrawing and
        // set a new argument for the undraw command
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&newStroke atIndex:2];
        
        // execute the draw command with the undraw command
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
    }
    
    // add the current touch as another vertex to the
    // temp stroke
    CGPoint thisPoint = [[touches anyObject] locationInView:self.canvasView];
    PTVertex *vertex = [[PTVertex alloc]
                        initWithLocation:thisPoint];
    
    // we don't need to undo every vertex
    // so we are keeping this
    [self.scribble addMark:vertex shouldAddToPreviousMark:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:self.canvasView];
    CGPoint thisPoint = [[touches anyObject] locationInView:self.canvasView];
    
    // if the touch never moves (stays at the same spot until lifted now)
    // just add a dot to an existing stroke composite
    // otherwise add it to the temp stroke as the last vertex
    if (CGPointEqualToPoint(lastPoint, thisPoint))
    {
        PTDot *singleDot = [[PTDot alloc]
                            initWithLocation:thisPoint];
        singleDot.color = self.strokeColor;
        singleDot.size = self.strokeSize;
        
        //[self.scribble addMark:singleDot shouldAddToPreviousMark:NO];
        
        // retrieve a new NSInvocation for drawing and
        // set new arguments for the draw command
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&singleDot atIndex:2];
        
        // retrieve a new NSInvocation for undrawing and
        // set a new argument for the undraw command
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&singleDot atIndex:2];
        
        // execute the draw command with the undraw command
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
    }
    
    // reset the start point here
    self.startPoint = CGPointZero;
    
    // if this is the last point of stroke
    // don't bother to draw it as the user
    // won't tell the difference
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // reset the start point here
    self.startPoint = CGPointZero;
}

#pragma mark - PTScribble observer method

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context
{
    if ([object isKindOfClass:[PTScribble class]] &&
        [keyPath isEqualToString:@"mark"])
    {
        id <PTMark> mark = change[NSKeyValueChangeNewKey];
        (self.canvasView).mark = mark;
        [self.canvasView setNeedsDisplay];
    }
}

-(void)dealloc
{
    [self.scribble removeObserver:self forKeyPath:@"mark"];
}

@end
