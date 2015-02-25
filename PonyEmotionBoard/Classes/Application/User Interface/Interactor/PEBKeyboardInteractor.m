//
//  PEBKeyboardInteractor.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBKeyboardInteractor.h"
#import "PEBEmotionGroupInteractor.h"

@implementation PEBKeyboardInteractor

- (NSArray *)emotionGroupInteractors {
    if (_emotionGroupInteractors == nil) {
        PEBEmotionGroupInteractor *demo = [[PEBEmotionGroupInteractor alloc] init];
        PEBEmotionGroupInteractor *demo2 = [[PEBEmotionGroupInteractor alloc] init];
        _emotionGroupInteractors = @[demo, demo2];
    }
    return _emotionGroupInteractors;
}

@end
