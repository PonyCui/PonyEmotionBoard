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
    if (_emotionItemInteractors == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSUInteger i=0; i<80; i++) {
            PEBEmotionItemInteractor *demo = [[PEBEmotionItemInteractor alloc] init];
            [array addObject:demo];
        }
        _emotionItemInteractors = array;
    }
    return _emotionItemInteractors;
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:@"EmotionsEmojiHL"];
}

@end
