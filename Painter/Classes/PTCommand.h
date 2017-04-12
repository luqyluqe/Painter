//
//  PTCommand.h
//

#import <Foundation/Foundation.h>


@interface PTCommand : NSObject

@property (nonatomic, strong) NSDictionary *userInfo;

- (void) execute;
- (void) undo;

@end
