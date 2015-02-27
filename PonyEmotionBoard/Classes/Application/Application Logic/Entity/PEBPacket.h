//
//  PEBPack.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PEBPacketType) {
    PEBPacketTypeEmoji = 1,
    PEBPacketTypeCustom = 2,
    PEBPacketTypeBand = 3
};

/**
 *  表情包
 */
@interface PEBPacket : NSObject<NSCoding>

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, assign) PEBPacketType type;

/**
 *  表情包标题
 */
@property (nonatomic, copy) NSString *titleString;

/**
 *  表情包图标地址
 *  可以是[UIImage imageName:@"*"]，也可以是Http URL
 */
@property (nonatomic, copy) NSString *iconURLString;

/**
 *  NSArray -> PEBElement
 */
@property (nonatomic, copy) NSArray *elements;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
