//
//  ScirbbleMemento.h
//

#import <Foundation/Foundation.h>
#import "PTMark.h"


@interface PTScribbleMemento : NSObject
{
  @private
  id <PTMark> mark_;
}

+ (PTScribbleMemento *) mementoWithData:(NSData *)data;
@property (nonatomic, readonly, copy) NSData *data;

@end
