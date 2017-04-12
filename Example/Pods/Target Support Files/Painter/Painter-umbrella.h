#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSMutableArray+Stack.h"
#import "PTCanvasView.h"
#import "PTCanvasViewController.h"
#import "PTCanvasViewGenerator.h"
#import "PTCommand.h"
#import "PTCommandBarButton.h"
#import "PTCommandSlider.h"
#import "PTCoordinatingController.h"
#import "PTDeleteScribbleCommand.h"
#import "PTDot.h"
#import "PTMark.h"
#import "PTMarkEnumerator+Internal.h"
#import "PTMarkEnumerator.h"
#import "PTMarkRenderer.h"
#import "PTMarkVisitor.h"
#import "PTOpenScribbleCommand.h"
#import "PTPaletteViewController.h"
#import "PTSaveScribbleCommand.h"
#import "PTScribble.h"
#import "PTScribbleManager.h"
#import "PTScribbleMemento+Friend.h"
#import "PTScribbleMemento.h"
#import "PTScribbleSource.h"
#import "PTScribbleThumbnailCell.h"
#import "PTScribbleThumbnailView.h"
#import "PTScribbleThumbnailViewImageProxy.h"
#import "PTSetStrokeColorCommand.h"
#import "PTSetStrokeSizeCommand.h"
#import "PTStroke.h"
#import "PTThumbnailViewController.h"
#import "PTVertex.h"
#import "TouchPainterAppDelegate.h"
#import "UIView+UIImage.h"

FOUNDATION_EXPORT double PainterVersionNumber;
FOUNDATION_EXPORT const unsigned char PainterVersionString[];

