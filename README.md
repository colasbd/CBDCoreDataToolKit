# CBDCoreDataToolKit



## CBDCoreDataToolKit : cloning, replacing & fetching easily

You have three parts.

### Cloning objects

You want to copy an object from a NSManagedObjectContext (MOC) to another one. CBDCoreDataToolKit can do it. It will also copy the objects in relationship with the first object, but you can specify entities or attribute to ignore.

### Replacing an object by another one

Let's say you have a graph with many objects in relation one with another. You want to replace one object in this graph by another one, and of course, you want the graph to stay the same. CBDCoreDataToolKit can do it.

### Convenience methods for fetching

With CoreData, when you wanna fetch, it's long and repetitive. CBDCoreDataToolKit offers you convenience methods to go to the point. These methods accepts format strings, so it is even more convenient. Many other librairies do the same, including the very well known Magical Record. Unfortunately, Magical Record does not work with NSPersistentDocument. CBDCoreDataToolKit does.

## Installation

CBDCoreDataToolKit is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "CBDCoreDataToolKit"

## Author

Colas, colas.bardavid@gmail.com

## License

CBDCoreDataToolKit is available under the MIT license. See the LICENSE file for more info.

