//
//  PEBEmotionGroupPresenter.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionGroupPresenter.h"
#import "PEBEmotionGroupCollectionViewCell.h"
#import "PEBEmotionGroupInteractor.h"

@implementation PEBEmotionGroupPresenter

- (void)updateView {
    self.userInterface.iconImageView.image = self.groupInteractor.iconImage;
}

- (void)setGroupInteractor:(PEBEmotionGroupInteractor *)groupInteractor {
    _groupInteractor = groupInteractor;
    [self updateView];
}

@end
