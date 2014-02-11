# CBDCoreDataToolKit

### Special thanks

* [Víctor Pena Placer](https://github.com/vicpenap/VPPCoreData)
* [user353759](http://stackoverflow.com/users/353759/user353759)

## CBDCoreDataToolKit: cloning, replacing & fetching easily

Three things now (more to come?):

### Cloning objects

You want to copy an object from a NSManagedObjectContext (MOC) to another one. CBDCoreDataToolKit can do it. It will also copy the objects in relationship with the first object, but you can specify entities or attribute to ignore.

### Replacing an object by another one

Let's say you have a graph with many objects in relation one with another. You want to replace one object in this graph by another one, and of course, you want the graph to stay the same. CBDCoreDataToolKit can do it.

### Convenience methods for fetching

With CoreData, when you wanna fetch, it's long and repetitive. CBDCoreDataToolKit offers you convenience methods to go to the point. These methods accepts format strings, so it is even more convenient. Many other librairies do the same, including the very well known Magical Record. Unfortunately, Magical Record does not work with NSPersistentDocument. CBDCoreDataToolKit does.


## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.


## Installation

CBDCoreDataToolKit is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "CBDCoreDataToolKit"



## Author

Colas, colas.bardavid@gmail.com


## Changelog

- 2014/02/11 (v1.0.0): New methods. Few changes in the names of the methods.
- 2014/02/11 (v0.0.2): Improved documentation.
- 2014/02/10 (v0.0.1): First release.

## License 

Copyright (c) 2014 Colas Bardavid


Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


