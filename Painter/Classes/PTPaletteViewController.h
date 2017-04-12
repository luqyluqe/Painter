//
//  PTPaletteViewController.h
//

#import <UIKit/UIKit.h>
#import "PTCommandBarButton.h"
#import "PTCommandSlider.h"
#import "PTSetStrokeColorCommand.h"
#import "PTSetStrokeSizeCommand.h"

@interface PTPaletteViewController : UIViewController 
                                   <PTSetStrokeColorCommandDelegate, 
                                    PTSetStrokeSizeCommandDelegate>
{
	@private
	IBOutlet PTCommandSlider *redSlider_;
	IBOutlet PTCommandSlider *greenSlider_;
	IBOutlet PTCommandSlider *blueSlider_;
	IBOutlet PTCommandSlider *sizeSlider_;
	IBOutlet UIView *paletteView_;
}

// slider event handler
- (IBAction) onCommandSliderValueChanged:(PTCommandSlider *)slider;

@end
