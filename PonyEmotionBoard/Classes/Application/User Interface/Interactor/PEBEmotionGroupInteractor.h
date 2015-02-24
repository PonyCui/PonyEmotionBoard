//
//  PEBEmotionGroupInteractor.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PEBEmotionGroupType) {
    PEBEmotionGroupTypeEmoji,
    PEBEmotionGroupTypeCustom,
    PEBEmotionGroupTypeBand
};

@interface PEBEmotionGroupInteractor : NSObject

@property (nonatomic, assign) PEBEmotionGroupType type;

/**
 *  NSArray -> PEBEmotionItemInteractor
 */
@property (nonatomic, copy) NSArray *emotionItemInteractors;

@property (nonatomic, strong) UIImage *iconImage;

@end
