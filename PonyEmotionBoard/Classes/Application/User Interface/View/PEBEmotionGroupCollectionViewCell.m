//
//  PEBEmotionGroupCollectionViewCell.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionGroupCollectionViewCell.h"
#import "PEBEmotionGroupPresenter.h"

@implementation PEBEmotionGroupCollectionViewCell

- (PEBEmotionGroupPresenter *)eventHandler {
    if (_eventHandler == nil) {
        _eventHandler = [[PEBEmotionGroupPresenter alloc] init];
        _eventHandler.userInterface = self;
    }
    return _eventHandler;
}

@end
