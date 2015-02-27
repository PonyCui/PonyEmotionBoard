//
//  PEBElement.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PEBElementType) {
    PEBElementTypeEmoji = 1,
    PEBElementTypeEmojiSimilar = 2,
    PEBElementTypeImage = 3,
    PEBElementTypeAnimate = 4
};

/**
 *  表情元素
 */
@interface PEBElement : NSObject<NSCoding>

@property (nonatomic, copy) NSString *identifier;

/**
 *  表情类型
 */
@property (nonatomic, assign) PEBElementType type;

/**
 *  表情标题
 *  @Keep Unique!!!
 */
@property (nonatomic, copy) NSString *titleString;

/**
 *  表情的本地路径
 */
@property (nonatomic, copy) NSString *localURLString;

/**
 *  表情的远程路径
 */
@property (nonatomic, copy) NSString *remoteURLString;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
