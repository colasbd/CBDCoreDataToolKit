#import "Pet.h"


@interface Pet ()

// Private interface goes here.

@end


@implementation Pet

- (NSString *)description
{
    return [NSString stringWithFormat:@"Pet with name %@", self.name] ;
}
@end
