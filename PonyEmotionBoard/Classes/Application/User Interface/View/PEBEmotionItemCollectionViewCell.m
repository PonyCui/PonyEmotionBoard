//
//  PEBEmotionItemCollectionViewCell.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-25.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionItemCollectionViewCell.h"
#import "PEBEmotionItemPresenter.h"

@implementation PEBEmotionItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.clipsToBounds = YES;
}

- (PEBEmotionItemPresenter *)eventHandler {
    if (_eventHandler == nil) {
        _eventHandler = [[PEBEmotionItemPresenter alloc] init];
        _eventHandler.userInterface = self;
    }
    return _eventHandler;
}

@end
