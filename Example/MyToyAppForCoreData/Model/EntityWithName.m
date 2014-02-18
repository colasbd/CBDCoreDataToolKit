#import "EntityWithName.h"


@interface EntityWithName ()

// Private interface goes here.

@end


@implementation EntityWithName

- (NSString *)description
{
    if (self.name)
    {
        return [NSString stringWithFormat:@"name: %@", self.name] ;
    }
    else
    {
        return @"" ;
    }
}


+ (id)createEntityWithName:(NSString *)theName
                    forMOC:(NSManagedObjectContext *)theMOC
{
    EntityWithName * newEntity = [self insertInManagedObjectContext:theMOC] ;
    newEntity.name = theName ;
    
    return newEntity ;
}
@end
