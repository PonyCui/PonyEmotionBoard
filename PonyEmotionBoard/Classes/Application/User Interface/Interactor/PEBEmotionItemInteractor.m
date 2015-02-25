//
//  PEBEmotionItemInteractor.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionItemInteractor.h"

@implementation PEBEmotionItemInteractor

- (UIImage *)iconImage {
    if (_iconImage == nil) {
        _iconImage = [UIImage imageNamed:[NSString stringWithFormat:@"Expression_%u", arc4random()%80+1]];
    }
    return _iconImage;
}

- (NSString *)emotionText {
    return @"[开心]";
}

- (NSString *)emotionDescription {
    return @"开心";
}

@end
