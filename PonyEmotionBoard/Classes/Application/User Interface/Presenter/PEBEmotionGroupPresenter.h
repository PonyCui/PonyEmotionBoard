//
//  PEBEmotionGroupPresenter.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PEBEmotionGroupCollectionViewCell, PEBEmotionGroupInteractor;

@interface PEBEmotionGroupPresenter : NSObject

@property (nonatomic, weak) PEBEmotionGroupCollectionViewCell *userInterface;

@property (nonatomic, strong) PEBEmotionGroupInteractor *groupInteractor;

- (void)updateView;

@end
