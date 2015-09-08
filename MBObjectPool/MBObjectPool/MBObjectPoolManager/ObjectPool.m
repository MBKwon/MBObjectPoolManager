//
//  ObjectPool.m
//  MBObjectPool
//
//  Created by MB KWON on 9/8/15.
//  Copyright (c) 2015 Moonbeom Kyle KWON. All rights reserved.
//

#import "ObjectPool.h"


@interface ObjectPool ()

@property (strong, nonatomic) NSMutableArray *unUsedObjectPool;
@property (strong, nonatomic) NSMutableArray *usedObjectPool;

@end

@implementation ObjectPool

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        _unUsedObjectPool = [NSMutableArray new];
        _usedObjectPool = [NSMutableArray new];
    }
    
    return self;
}

-(id)getObjectWithClass:(Class)class
{
    id unUsedObject;
    for (id object in _unUsedObjectPool) {
        if ([object isKindOfClass:class] == YES) {
            unUsedObject = object;
            break;
        }
    }
    
    if (unUsedObject == nil) {
        unUsedObject = [class new];
        [_usedObjectPool addObject:unUsedObject];
        
    } else {
        
        [_usedObjectPool addObject:unUsedObject];
        [_unUsedObjectPool removeObject:unUsedObject];
    }
    
    return unUsedObject;
}

-(void)releaseObject:(id)object
{
    for (NSObject *object in _usedObjectPool) {
        if ([object isEqual:object] == YES) {
            [_unUsedObjectPool addObject:object];
            [_usedObjectPool removeObject:object];
            break;
        }
    }
}

-(void)releaseAllObjects
{
    NSUInteger usedObjectCount = [_usedObjectPool count];
    
    for (int i=0; i<usedObjectCount; i++) {
        [_unUsedObjectPool addObject:_usedObjectPool.lastObject];
        [_usedObjectPool removeLastObject];
    }
}

@end
