MBObjectPoolManager
============

MBObjectPoolManager is best way to reuse your objects in your project. You can save a memory reusing objects

Requires **iOS 5.0 or later**.

======


## Features
1. Ease of reusing memory
2. Save memory reusing objects


## Methods
#### MBObjectPoolManager
```objective-c
+(MBObjectPoolManager *)defaultManager;
-(id)getObjectWithClass:(Class)class;
-(void)releaseObject:(id)object;
-(void)releaseAllObjects;
-(void)removeAllFromMemory;
```

## Usage

You can get object to reuse it. Just call this method. Return a unused object automatically from a object pool. If the object pool is empty, it would return a new object.

```objective-c

NSObject *object = [[MBObjectPoolManager defaultManager] getObjectWithClass:[NSObject class]];

```


If a object will be unnecessary, you should call this method to release a object.

```objective-c
[[MBObjectPoolManager defaultManager] releaseObject:object];

```


If you call this method to reuse a object, the object pool manager will return a object you release before.

```objective-c

NSObject *object = [[MBObjectPoolManager defaultManager] getObjectWithClass:[object class]];

```


If you release all objects, should call this method

```objective-c

[[MBObjectPoolManager defaultManager] releaseAllObjects];

```


If you release all objects to free a memory that is allocated by those for reuse, should call this method

```objective-c

[[MBObjectPoolManager defaultManager] removeAllFromMemory];

```



License
=================
The MIT License (MIT)

Copyright (c) 2014 Moonbeom Kyle KWON

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


