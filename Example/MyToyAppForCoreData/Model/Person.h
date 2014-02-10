#import "_Person.h"

@interface Person : _Person {}

+ (id)createPersonWithName:(NSString *)name
             withBirthYear:(NSUInteger)theYearOfTheBirth
                    isMale:(BOOL)isMale
                    forMOC:(NSManagedObjectContext *)theMOC ;


@property (nonatomic, readonly) NSString * sex ;
@property (nonatomic, readonly) NSString * birthYearString ;

@end
