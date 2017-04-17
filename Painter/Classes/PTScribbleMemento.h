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

@property (nonatomic,strong) id<PTMarkSerialization> serializer;

+(PTScribbleMemento *) mementoWithData:(NSData *)data;

@property (nonatomic, readonly) NSData *data;
@property (nonatomic, readonly) NSString* stringSerialization;
@property (nonatomic, readonly) NSDictionary* dictionarySerialization;

@end
