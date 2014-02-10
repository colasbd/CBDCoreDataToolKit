//
//  NSSortDescriptor+CBDTransformSQLToSortDescriptors.h
//  MyCBDCoreDataToolKit
//
//  Created by Colas on 10/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSortDescriptor (CBDTransformSQLToSortDescriptors)



/** Returns an array of sort descriptors based on the SQL-like string passed
 as parameter.
 
 Usage:
 
 You can pass an order-by clause just like in SQL. Syntax expected:
 property [asc|desc][, property [asc|desc]][, ...]
 
 Examples:
 - date
 - date asc
 - date desc, title, id asc
 */
+ (NSArray *) sortDescriptorsFromSQLString_cbd_:(NSString *)string;


@end
