//
//  PTCustomBarButton.h
//

#import <Foundation/Foundation.h>
#import  "PTCommand.h"

@interface PTCommandBarButton : UIBarButtonItem

@property (nonatomic, strong) IBOutlet PTCommand *command;

@end

