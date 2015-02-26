//
//  PEBKeyboardViewController.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PEBKeyboardPresenter;

@interface PEBKeyboardViewController : UIViewController

@property (nonatomic, strong) PEBKeyboardPresenter *eventHandler;

@property (nonatomic, weak) id<UITextInput> textInputContainer;

@property (nonatomic, assign) BOOL isPresented;

- (void)configureViewLayouts;

- (void)updateGroupCollectionView;

- (void)updateItemCollectionView;

@end
