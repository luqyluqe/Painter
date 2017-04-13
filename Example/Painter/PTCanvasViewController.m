//
//  PTCanvasViewController.m
//

#import "PTCanvasViewController.h"
#import "PTDot.h"
#import "PTStroke.h"

@implementation PTCanvasViewController

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

-(void)dealloc
{
    [self.scribble removeObserver:self forKeyPath:@"mark"];
}

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
  // initialize a PTScribble model
  PTScribble *scribble = [[PTScribble alloc] init];
  self.scribble = scribble;
  
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
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark PTStroke color and size accessor methods

- (void) setStrokeSize:(CGFloat) aSize
{
  // enforce the smallest size
  // allowed
  if (aSize < 5.0) 
  {
    _strokeSize = 5.0;
  }
  else 
  {
    _strokeSize = aSize;
  }
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


#pragma mark -
#pragma mark PTScribble observer method

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


#pragma mark -
#pragma mark Draw PTScribble Invocation Generation Methods

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

#pragma mark Draw PTScribble Command Methods

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

@end
