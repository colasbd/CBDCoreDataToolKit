# CBDCoreDataToolKit



## CBDCoreDataToolKit: cloning, replacing, importing  easily in CoreData


With **CBDCoreDataToolKit**, you can clone, replace or import your NSManagedObject. Cloning is useful when you want to transfer new data from a `MOC` to another one. Importing is when you want to integrate some data to one `MOC` to another one. By integrating, I mean that the data to import is entirely new. Maybe there is just new links between entities, or maybe there is a new instance of some entity with plenty of relationships with already existing objects.

One has to understand that in such a case:

 - cloning will "pull" the entire graph connected to this new object, and we will have plenty of doublons.
 
  - importing is much more clever (and difficult) and will "pull" the entire graph connected to this new object **and** will merge it with the already existing graph. **Super great !!**

### 1. Cloning objects

You want to copy an object from a NSManagedObjectContext (`MOC`) to another one. **CBDCoreDataToolKit** can do it. It will also copy the objects in relationship with the first object, but you can specify entities or attributes to ignore.

### 2. Replacing an object by another one

Let's say you have a graph with many objects in relation one with another. You want to replace one object in this graph by another one, and of course, you want the graph to stay the same. **CBDCoreDataToolKit** can do it. When you don't have to ask yourself questions about `MOC`s: you take any `NSManagedObject` and you replace it by any other one.

### 3. Importing objects
It's a little bit like cloning but it's more powerful. While cloning was pulling all the graph (excepted some parts you can cut off) of an object from a `sourceMOC` to a `targetMOC`, the importing feature is more clever.

#### a) CBDCoreDataImporter
To import some data, it's easy! 

First, you have to create an instance of `CBDCoreDataImporter`. You do:

```
CBDCoreDataImporter * myImporter;

myImporter = [CBDCoreDataImporter alloc] initWithSourceMOC:sourceMOC
              						             targetMOC:targetMOC];
```

And then, to import:

```
[myDataImporter import:object];
```
It will import `object` to `targetMOC` and will include it in the graph of already existing objects of `targetMOC`. To do that, CBDCoreDataImporter will have to compare objects in the `sourceMOC` and in the `targetMOC`. This is the aim of `CBDCoreDataDiscriminator`.

#### b) CBDCoreDataDiscriminator

An instance of `CBDCoreDataDiscriminator` aims at comparing objects of a given entity, regarding given attributes and relationships. Instead of testing the equality with `==` or with `isEqual:`, it will use the (given at the initialisation) attributes and relationships.

Some code:

```
CBDCoreDataDiscriminator * myDiscriminator ;

myDiscriminator = [CBDCoreDataDiscriminator alloc] initWithDefaultType] ;

[myDiscriminator    isSourceObject:firstObject
     		 similarToTargetObject:secondObject] ;


NSArray * similarObjects = [myDiscriminator similarObjectTo:refObject
                      							      inMOC:myMOC] ;

NSManagedObject * similarObject = [myDiscriminator firstSimilarObjectTo:refObject
                                  				                  inMOC:myMOC] ;
										 								 
```

You can also do this kind of actions:

```
[myDiscriminator    objectsInWorkingMOC:MOCWhereWeAreWorking
          alreadyExistingInReferenceMOC:referenceMOC] ;
```

But, you may want to define very precisely upon which attributes and relationships you want to do all that: discriminating as well as importing. It is possible and it uses `CBDCoreDataDecisionCenter` and `CBDCoreDataDecisionUnit`.

#### c) CBDCoreDataDecisionCenter and CBDCoreDataDecisionUnit

##### — CBDCoreDataDecisionUnit

A `CBDCoreDataDecisionUnit` will typically says something like:

- for the entity `Person`, consider only attributes `name`, `age` and relationships `family` to make your decision (a decision, here, is either "tell me if they are similar" or "copy this entity", but you can imagine other ones). 

- for the entity `Car`, don't (I mean : **never**) consider the relationship `owners` to make your decision. 

- ignore the entity `Bike`. 

- etc.

The best is to refer to the documentation to know more about the code.

##### — CBDCoreDataDecisionCenter

A `CBDCoreDataDecisionCenter` groups together several `CBDCoreDataDecisionUnit`. It is the true decision maker, because in the case of an entity `Entity` that heritates from an other `SuperEntity`, if both entities have decision unit , the decision cannot be taken withour knowing about both.

You don't have to specify a decision unit for all entities. 

You can use one the three global settings: `initWithFacilitatingType`, `initWithSemiFacilitatingType`, `initWithDemandingType`. There are all conveninent. See the doc for more information.

Here is some code:

```
CBDCoreDataDecisionCenter * myDecisionCenter ;
myDecisionCenter = [CBDCoreDataDecisionCenter alloc] initWithSemiFacilitatingType] ;

CBDCoreDataDecisionUnit *myUnit1 ;
myUnit1 = [[CBDCoreDataDecisionUnit alloc] initForEntity:personEntity
        				                 usingAttributes:nil
                                        andRelationships:@[@"friends"]] ;

CBDCoreDataDecisionUnit *myUnit2 ;
myUnit2 = [[CBDCoreDataDecisionUnit alloc] initForEntity:employeeEntity
        				                 usingAttributes:nil
                                        andRelationships:@[@"employees"]] ;

[myDecisionCenter addDecisionUnit:myUnit1];
[myDecisionCenter addDecisionUnit:myUnit2];

[myDecisionCenter relationshipsFor:employeeEntity]

```




### 4. Convenience methods for fetching

With CoreData, when you wanna fetch, it's long and repetitive. **CBDCoreDataToolKit** offers you convenience methods to go to the point. These methods accepts format strings, so it is even more convenient. Many other librairies do the same, including the very well known Magical Record. Unfortunately, Magical Record does not work with `NSPersistentDocument`. **CBDCoreDataToolKit** does.

All the methods defined in categories over Apple classes are suffixed with `_cbd_` to avoid name conflicts.

#### a) Class methods for subclasses of NSManagedObject for fetching

You can fetch on subclasses of `NSManagedObject`, if they implement the class method `+ (NSString *)entityName` or if they are have the same name as their corresponding entity. This is the case for classes generated by `mogenerator`. 


#### b) Full support of format string

You will able to do, for example

```
			[Person findInMOC:self.myMOC
      		        orderedBy:@"name, age"
     withPredicateFormat_cbd_:@"city == %@", theCity] ;
```

<!--
## DEPRECATED

#### c) Finding similar objects
Also available:

 ```
 [me findSimilarObjectsForAttributes:@[@"age", @"city"]
 		   			forRelationships:nil
  withAdditionalPredicateFormat_cbd_:@"isMale == NO"] ;
 ```-->
 
 
## Requirements

Some of the methods in the categories over `NSManagedObject+CBDActiveRecord` require one or the other of the following conditions:

- you have generated your subclasses of `NSManagedObject` with [`mogenerator`](https://github.com/rentzsch/mogenerator).
- the subclass of `NSManagedObject` corresponding to your `Entity` is also nammed `Entity`.

But don't worry, this requirement (which is always satisfied actually) has been limited to only this category. All the rest of this pod doesn't ask for this requirement.


 
## Documentation
 
 The documentation of classes and methods is available [here](http://cocoadocs.org/docsets/CBDCoreDataToolKit/2.0.0).
 
 
## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.


## Installation

CBDCoreDataToolKit is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "CBDCoreDataToolKit"



## Author

Colas, colas.bardavid@gmail.com

### Special thanks

* [Víctor Pena Placer](https://github.com/vicpenap/VPPCoreData) for his **VPPCoreData** package
* [user353759](http://stackoverflow.com/users/353759/user353759) of **StackOverflow**


## Changelog

- 2014/02/18 (v3.0.0): 
  - New convenience initializers for `CBDCoreDataDecisionUnit`
  - New methods for finding duplicate between two `MOC`s
  - Correction of various bugs
  - No more `- removeLastHint`, `removeLastEntryOfTheCache` methods
- 2014/02/18 (v2.0.0): 
  - Introducing the much more hi-tech importer from a `MOC` to another `MOC`. Comparing objects on their graph-like identity..
  - New methods for fetching similar objects. 
  - Slight changes  in the names of few methods. 
- 2014/02/11 (v1.0.0): New methods. Few changes in the names of few methods.
- 2014/02/11 (v0.0.2): Improved documentation.
- 2014/02/10 (v0.0.1): First release.

## License 

Copyright (c) 2014 Colas Bardavid


Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


