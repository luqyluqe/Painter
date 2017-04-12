//
//  PTScribbleThumbnailCell.h
//

#import <UIKit/UIKit.h>
#import "PTScribbleThumbnailView.h"

@interface PTScribbleThumbnailCell : UITableViewCell 
{
	
}

+ (NSInteger) numberOfPlaceHolders;
- (void) addThumbnailView:(UIView *)thumbnailView 
                      atIndex:(NSInteger)index;

@end
