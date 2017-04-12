//
//  PTCanvasView.h
//

#import <UIKit/UIKit.h>

@protocol PTMark;

@interface PTCanvasView : UIView 

@property (nonatomic, strong) id <PTMark> mark;

@end
