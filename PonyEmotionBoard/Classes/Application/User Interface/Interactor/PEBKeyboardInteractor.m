//
//  PEBKeyboardInteractor.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBKeyboardInteractor.h"
#import "PEBEmotionGroupInteractor.h"
#import "PEBApplication+PEBCore.h"
#import "PEBEmotionManager.h"

@implementation PEBKeyboardInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sendAsyncEmotionPacketsRequest];
    }
    return self;
}

- (void)sendAsyncEmotionPacketsRequest {
    [[[[PEBApplication sharedInstance] core] emotionManager] findAvailabelPackets:^(NSArray *result) {
        self.emotionGroupInteractors =  [self groupInteractorsWithPackets:result];
    }];
}

- (NSArray *)groupInteractorsWithPackets:(NSArray *)packets {
    NSMutableArray *groupInteractors = [NSMutableArray array];
    [packets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PEBEmotionGroupInteractor *groupInteractor = [[PEBEmotionGroupInteractor alloc] initWithPacket:obj];
        if (groupInteractor != nil) {
            [groupInteractors addObject:groupInteractor];
        }
    }];
    return [groupInteractors copy];
}

@end
