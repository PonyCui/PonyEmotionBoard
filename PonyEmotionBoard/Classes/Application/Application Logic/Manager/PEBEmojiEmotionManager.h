//
//  PEBEmojiEmotionManager.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PEBPacket;

/**
 *  Emoji、类Emoji表情管理器
 */
@interface PEBEmojiEmotionManager : NSObject

+ (PEBPacket *)emojiPacket;

+ (NSUInteger)hash;

@end
