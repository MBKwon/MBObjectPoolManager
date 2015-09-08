//
//  MBObjectPoolManager.h
//  MBObjectPool
//
//  Created by Moonbeom Kyle KWON on 2/5/14.
//  Copyright (c) 2014 Moonbeom Kyle KWON. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ObjectPoolDelegate <NSObject>

-(instancetype)initForReuse;

@end



@interface MBObjectPoolManager : NSObject


+(instancetype)defaultManager;

-(id)getObjectWithClass:(Class)class;
-(void)releaseObject:(id)object;
-(void)releaseAllObjects;
-(void)releaseAllMemory;


@end
