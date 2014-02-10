#import "Person.h"
#import "Family.h"

@interface Person ()

// Private interface goes here.

@end


@implementation Person


+ (id)createPersonWithName:(NSString *)name
             withBirthYear:(NSUInteger)theYearOfTheBirth isMale:(BOOL)isMale
                    forMOC:(NSManagedObjectContext *)theMOC
{
    Person*  newPerson ;
    newPerson = [self createEntityWithName:name
                                    forMOC:theMOC] ;

    newPerson.birthYearValue = theYearOfTheBirth ;
    newPerson.isMaleValue = isMale ;
    
    return newPerson ;
}



- (NSString *)description
{
    NSString * birth = [NSString stringWithFormat:@", né%@ en %@", self.isMaleValue?@"":@"e", self.birthYear] ;
    
    return [NSString stringWithFormat:@"%@ %@ (%@%@)", self.name, self.family.name, self.isMaleValue?@"M":@"F", self.birthYearValue?birth:@""] ;
}


+ (NSSet *)keyPathsForValuesAffectingSex
{
    return [NSSet setWithObject:@"isMale"] ;
}

- (NSString *)sex
{
    if (self.isMaleValue)
    {
        return @"M" ;
    }
    else
    {
        return @"F" ;
    }
}

+ (NSSet *)keyPathsForValuesAffectingBirthYearString
{
    return [NSSet setWithObject:@"birthYear"] ;
}

- (NSString *)birthYearString
{
    if (self.birthYearValue)
    {
        return [NSString stringWithFormat:@"%@", self.birthYear] ;
    }
    else
    {
        return @"(non renseigné)" ;
    }
}

@end
