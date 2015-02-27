//
//  PEBCore.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBCore.h"
#import "PEBWireframe.h"
#import "PEBEmotionManager.h"

@implementation PEBCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureDependencies];
    }
    return self;
}

- (void)configureDependencies {
    _wireframe = [[PEBWireframe alloc] init];
    _emotionManager = [[PEBEmotionManager alloc] init];
}

@end
