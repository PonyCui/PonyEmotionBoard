//
//  PEBKeyboardDelegateObject.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/26.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PEBKeyboardPresenter;

@interface PEBKeyboardDelegateObject : NSObject
                                       <UICollectionViewDataSource,
                                        UICollectionViewDelegate,
                                        UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) PEBKeyboardPresenter *eventHandler;

@property (nonatomic, weak) id<UITextInput> textInputContainer;

- (void)updatePageControl;

- (void)updateGroupSelection;

@end
