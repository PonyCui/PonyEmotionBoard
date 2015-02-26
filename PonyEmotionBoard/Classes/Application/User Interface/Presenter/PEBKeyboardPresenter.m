//
//  PEBKeyboardPresenter.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBKeyboardPresenter.h"
#import "PEBKeyboardViewController.h"
#import "PEBKeyboardInteractor.h"

@implementation PEBKeyboardPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.keyboardInteractor = [[PEBKeyboardInteractor alloc] init];
    }
    return self;
}

- (void)updateView {
    [self.userInterface updateView];
}

@end
