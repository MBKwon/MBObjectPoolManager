//
//  DemoViewController.m
//  MBObjectPool
//
//  Created by Moonbeom Kyle KWON on 2/5/14.
//  Copyright (c) 2014 Moonbeom Kyle KWON. All rights reserved.
//

#import "DemoViewController.h"
#import "MBObjectPoolManager.h"

@interface DemoViewController ()

@property (strong, nonatomic) NSMutableArray *objectArray;

@end

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _objectArray = [NSMutableArray new];
    
    
    for (int i=0; i<5; i++) {
        [_objectArray addObject:[[MBObjectPoolManager defaultManager] getObjectWithClass:[UIButton class]]];
    }
    
    for (int i=0; i<2; i++) {
        [[MBObjectPoolManager defaultManager] releaseObject:[_objectArray objectAtIndex:i]];
    }
    
    for (int i=0; i<3; i++) {
        [_objectArray addObject:[[MBObjectPoolManager defaultManager] getObjectWithClass:[UIButton class]]];
    }
    
    [[MBObjectPoolManager defaultManager] releaseAllObjects];
    [[MBObjectPoolManager defaultManager] releaseAllMemory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
