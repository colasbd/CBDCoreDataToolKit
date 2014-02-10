#import "Family.h"


@interface Family ()

// Private interface goes here.

@end


@implementation Family

- (NSString *)description
{
    return [NSString stringWithFormat:@"Famille %@", self.name] ;
}
@end
