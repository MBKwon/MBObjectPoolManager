//
//  ObjectPool.h
//  MBObjectPool
//
//  Created by MB KWON on 9/8/15.
//  Copyright (c) 2015 Moonbeom Kyle KWON. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectPool : NSObject


-(id)getObjectWithClass:(Class)class;
-(void)releaseObject:(id)object;
-(void)releaseAllObjects;
-(void)releaseAllOnMemory;

@end
