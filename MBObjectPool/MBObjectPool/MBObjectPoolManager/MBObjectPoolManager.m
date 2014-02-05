//
//  MBObjectPoolManager.m
//  MBObjectPool
//
//  Created by Moonbeom Kyle KWON on 2/5/14.
//  Copyright (c) 2014 Moonbeom Kyle KWON. All rights reserved.
//

#import "MBObjectPoolManager.h"

@interface MBObjectPoolManager ()

@property (strong, nonatomic) NSMutableArray *unUsedObjectPool;
@property (strong, nonatomic) NSMutableArray *usedObjectPool;

@end

@implementation MBObjectPoolManager


+(MBObjectPoolManager *)defaultManager
{
    static MBObjectPoolManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MBObjectPoolManager new];
        
        instance.unUsedObjectPool = [NSMutableArray new];
        instance.usedObjectPool = [NSMutableArray new];
    });
    
    return instance;
}

-(id)getObjectWithClass:(Class)class
{
    NSObject *unUsedObject;
    
    for (NSObject *object in _unUsedObjectPool) {
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
    int usedObjectCount = [_usedObjectPool count];
    
    for (int i=0; i<usedObjectCount; i++) {
            [_unUsedObjectPool addObject:_usedObjectPool.lastObject];
            [_usedObjectPool removeLastObject];
    }
}

-(void)releaseAllMemory
{
    [_unUsedObjectPool removeAllObjects];
    [_usedObjectPool removeAllObjects];
}

@end
