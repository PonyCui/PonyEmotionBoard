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
        _emotionGroupInteractors = @[demo];
    }
    return _emotionGroupInteractors;
}

@end
