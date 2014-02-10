#import "EntityWithName.h"


@interface EntityWithName ()

// Private interface goes here.

@end


@implementation EntityWithName

+ (id)createEntityWithName:(NSString *)theName
                    forMOC:(NSManagedObjectContext *)theMOC
{
    EntityWithName * newEntity = [self insertInManagedObjectContext:theMOC] ;
    newEntity.name = theName ;
    
    return newEntity ;
}
@end
