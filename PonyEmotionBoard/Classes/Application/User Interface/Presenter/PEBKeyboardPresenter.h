//
//  PEBKeyboardPresenter.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PEBKeyboardViewController, PEBKeyboardInteractor;

@interface PEBKeyboardPresenter : NSObject

@property (nonatomic, weak) PEBKeyboardViewController *userInterface;

@property (nonatomic, strong) PEBKeyboardInteractor *keyboardInteractor;

- (void)updateView;

@end
