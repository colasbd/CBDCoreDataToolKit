#import "_EntityWithName.h"

@interface EntityWithName : _EntityWithName {}

+ (id)createEntityWithName:(NSString *)theName
                    forMOC:(NSManagedObjectContext *)theMOC ;

@end
