#import "City.h"


@interface City ()

// Private interface goes here.

@end


@implementation City

- (NSString *)description
{
    return [NSString stringWithFormat:@"Ville de %@", self.name] ;
}
@end
