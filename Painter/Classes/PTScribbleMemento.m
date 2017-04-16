//
//  ScirbbleMemento.m
//

#import "PTScribbleMemento.h"
#import "PTScribbleMemento+Friend.h"

@interface PTDefaultMarkSerializer : NSObject<PTMarkSerialization>

@end

@implementation PTDefaultMarkSerializer

-(NSString*)stringBySerializingMark:(id<PTMark>)mark
{
    return nil;
}

-(NSData*)dataBySerializingMark:(id<PTMark>)mark
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mark];
    return data;
}

-(id<PTMark>)markByDeserializingString:(NSString *)string
{
    return nil;
}

-(id<PTMark>)markByDeserializingData:(NSData *)data
{
    // It raises an NSInvalidArchiveOperationException if data is not a valid archive
    id <PTMark> mark = (id <PTMark>)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return mark;
}

@end

@implementation PTScribbleMemento

@synthesize mark=mark_;

-(id<PTMarkSerialization>)serializer
{
    if (!_serializer) {
        _serializer=[PTDefaultMarkSerializer new];
    }
    return _serializer;
}

- (NSData *) data
{
    if ([self.serializer respondsToSelector:@selector(dataBySerializingMark:)]) {
        NSData* data=[self.serializer dataBySerializingMark:self.mark];
        return data;
    }
    return nil;
}

-(NSString*)stringSerialization
{
    if ([self.serializer respondsToSelector:@selector(stringBySerializingMark:)]) {
        NSString* string=[self.serializer stringBySerializingMark:self.mark];
        return string;
    }
    return nil;
}

+ (PTScribbleMemento *) mementoWithData:(NSData *)data
{
  // It raises an NSInvalidArchiveOperationException if data is not a valid archive
  PTScribbleMemento *memento = [[PTScribbleMemento alloc] init];
    memento.mark=[memento.serializer markByDeserializingData:data];
  
  return memento;
}

#pragma mark -
#pragma mark Private methods

- (instancetype) initWithMark:(id <PTMark>)aMark
{
  if (self = [super init])
  {
    self.mark = aMark;
  }
  
  return self;
}

@end
