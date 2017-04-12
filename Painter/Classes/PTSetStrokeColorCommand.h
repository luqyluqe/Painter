//
//  PTSetStrokeColorCommand.h
//

#import <Foundation/Foundation.h>
#import "PTCommand.h"

typedef void (^RGBValuesProvider)(CGFloat *red, CGFloat *green, CGFloat *blue);
typedef void (^PostColorUpdateProvider)(UIColor *color);

@class PTSetStrokeColorCommand;

@protocol PTSetStrokeColorCommandDelegate

- (void) command:(PTSetStrokeColorCommand *) command 
                didRequestColorComponentsForRed:(CGFloat *) red
                                          green:(CGFloat *) green 
                                           blue:(CGFloat *) blue;

- (void) command:(PTSetStrokeColorCommand *) command
                didFinishColorUpdateWithColor:(UIColor *) color;

@end


@interface PTSetStrokeColorCommand : PTCommand
{
  @private
  id <PTSetStrokeColorCommandDelegate> __weak delegate_;
  RGBValuesProvider RGBValuesProvider_;
  PostColorUpdateProvider postColorUpdateProvider_;
}

@property (nonatomic, weak) id <PTSetStrokeColorCommandDelegate> delegate;
@property (nonatomic, copy) RGBValuesProvider RGBValuesProvider;
@property (nonatomic, copy) PostColorUpdateProvider postColorUpdateProvider;

- (void) execute;

@end
