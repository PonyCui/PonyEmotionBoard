//
//  PEBEmotionGroupInteractor.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionGroupInteractor.h"
#import "PEBEmotionItemInteractor.h"

@implementation PEBEmotionGroupInteractor

- (PEBEmotionGroupType)type {
    return PEBEmotionGroupTypeEmoji;
}

- (NSArray *)emotionItemInteractors {
    PEBEmotionItemInteractor *demo = [[PEBEmotionItemInteractor alloc] init];
    return @[demo];
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:@"EmotionsEmojiHL"];
}

@end
