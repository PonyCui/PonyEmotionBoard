//
//  PEBEmotionItemPresenter.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-25.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PEBEmotionItemInteractor, PEBEmotionItemCollectionViewCell;

@interface PEBEmotionItemPresenter : NSObject

@property (nonatomic, weak) PEBEmotionItemCollectionViewCell *userInterface;

@property (nonatomic, strong) PEBEmotionItemInteractor *itemInteractor;

- (void)insertTextToTextInputContainer:(id<UITextInput>)container;

@end
