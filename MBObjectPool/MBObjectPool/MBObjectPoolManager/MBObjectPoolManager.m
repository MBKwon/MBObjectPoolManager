//
//  MBObjectPoolManager.m
//  MBObjectPool
//
//  Created by Moonbeom Kyle KWON on 2/5/14.
//  Copyright (c) 2014 Moonbeom Kyle KWON. All rights reserved.
//

#import "MBObjectPoolManager.h"
#import "ObjectPool.h"

static dispatch_queue_t getDispatchQueue () {
    static dispatch_queue_t dispatchQ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatchQ = dispatch_queue_create("com.objectPool.dispatchQueue", DISPATCH_QUEUE_SERIAL);
    });
    
    return dispatchQ;
}

@interface MBObjectPoolManager ()

@property (strong, nonatomic) NSMutableDictionary *objectPoolCollection;

@end

@implementation MBObjectPoolManager


+(instancetype)defaultManager
{
    static MBObjectPoolManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MBObjectPoolManager new];
        
        instance.objectPoolCollection = [NSMutableDictionary new];
    });
    
    return instance;
}

-(ObjectPool *)getPoolFromCollection:(Class)className
{
    ObjectPool *pool = _objectPoolCollection[NSStringFromClass(className)];
    if (pool == nil) {
        pool = [ObjectPool new];
        _objectPoolCollection[NSStringFromClass(className)] = pool;
    }
    
    return pool;
}

-(id)getObjectWithClass:(Class)class
{
    __block id<ObjectPoolDelegate> unUsedObject;
    dispatch_sync(getDispatchQueue(), ^{
        
        unUsedObject = [[self getPoolFromCollection:class] getObjectWithClass:class];
        if ([unUsedObject respondsToSelector:@selector(initForReuse)]) {
            unUsedObject = [unUsedObject initForReuse];
        }
    });
    return unUsedObject;
}

-(void)releaseObject:(id)object
{
    dispatch_async(getDispatchQueue(), ^{
        [[self getPoolFromCollection:[object class]] releaseObject:object];
    });
}

-(void)releaseAllObjects
{
    dispatch_async(getDispatchQueue(), ^{
        NSArray *allKeys = _objectPoolCollection.allKeys;
        for (id key in allKeys) {
            ObjectPool *pool = _objectPoolCollection[key];
            [pool releaseAllObjects];
        }
    });
}

-(void)releaseAllOnMemory
{
    dispatch_async(getDispatchQueue(), ^{
        NSArray *allKeys = _objectPoolCollection.allKeys;
        for (id key in allKeys) {
            ObjectPool *pool = _objectPoolCollection[key];
            [pool releaseAllOnMemory];
        }
    });
}

@end
