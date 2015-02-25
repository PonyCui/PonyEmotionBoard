//
//  PEBEmotionItemPresenter.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-25.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionItemPresenter.h"
#import "PEBEmotionItemCollectionViewCell.h"
#import "PEBEmotionItemInteractor.h"

@implementation PEBEmotionItemPresenter

- (void)updateView {
    self.userInterface.hidden = self.itemInteractor == nil;
    self.userInterface.iconImageView.image = self.itemInteractor.iconImage;
    self.userInterface.iconTitleLabel.text = self.itemInteractor.collectionText;
}

- (void)setItemInteractor:(PEBEmotionItemInteractor *)itemInteractor {
    _itemInteractor = itemInteractor;
    [self updateView];
}

@end
