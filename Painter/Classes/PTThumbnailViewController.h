//
//  PTThumbnailViewController.h
//

#import <UIKit/UIKit.h>
#import "PTScribbleThumbnailCell.h"
#import "PTScribbleManager.h"
#import "PTCommandBarButton.h"

@interface PTThumbnailViewController : UIViewController 
										<UITableViewDelegate,
										 UITableViewDataSource>

{
	@private
	IBOutlet UINavigationItem *navItem_;
	PTScribbleManager *scribbleManager_;
}

@end
