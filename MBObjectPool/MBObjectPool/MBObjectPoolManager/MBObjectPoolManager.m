//
//  MBObjectPoolManager.m
//  MBObjectPool
//
//  Created by Moonbeom Kyle KWON on 2/5/14.
//  Copyright (c) 2014 Moonbeom Kyle KWON. All rights reserved.
//

#import "MBObjectPoolManager.h"

static dispatch_queue_t getDispatchQueue () {
    static dispatch_queue_t dispatchQ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatchQ = dispatch_queue_create("com.objectPool.dispatchQueue", DISPATCH_QUEUE_SERIAL);
    });
    
    return dispatchQ;
}

@interface MBObjectPoolManager ()

@property (strong, nonatomic) NSMutableArray *unUsedObjectPool;
@property (strong, nonatomic) NSMutableArray *usedObjectPool;

@end

@implementation MBObjectPoolManager


+(instancetype)defaultManager
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
    __block NSObject *unUsedObject;
    dispatch_sync(getDispatchQueue(), ^{
        
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
        
    });
    return unUsedObject;
}

-(void)releaseObject:(id)object
{
    dispatch_async(getDispatchQueue(), ^{
        for (NSObject *object in _usedObjectPool) {
            if ([object isEqual:object] == YES) {
                [_unUsedObjectPool addObject:object];
                [_usedObjectPool removeObject:object];
                break;
            }
        }
    });
}

-(void)releaseAllObjects
{
    dispatch_async(getDispatchQueue(), ^{
        int usedObjectCount = [_usedObjectPool count];
        
        for (int i=0; i<usedObjectCount; i++) {
            [_unUsedObjectPool addObject:_usedObjectPool.lastObject];
            [_usedObjectPool removeLastObject];
        }
    });
}

-(void)releaseAllMemory
{
    dispatch_async(getDispatchQueue(), ^{
        [_unUsedObjectPool removeAllObjects];
        [_usedObjectPool removeAllObjects];
    });
}

@end
