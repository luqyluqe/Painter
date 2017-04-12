//
//  PTCanvasView.m
//

#import "PTCanvasView.h"
#import "PTMarkRenderer.h"

@implementation PTCanvasView

- (instancetype)initWithFrame:(CGRect)frame 
{
  if ((self = [super initWithFrame:frame])) 
  {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
  
  // Drawing code
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  // create a renderer visitor
  PTMarkRenderer *markRenderer = [[PTMarkRenderer alloc] initWithCGContext:context];
  
  // pass this renderer along the mark composite structure
  [self.mark acceptMarkVisitor:markRenderer];
  
}

@end
