#import "Company.h"


@interface Company ()

// Private interface goes here.

@end


@implementation Company

- (NSString *)description
{
    return [NSString stringWithFormat:@"Entreprise : %@", self.name] ;
}
@end
