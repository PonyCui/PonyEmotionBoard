//
//  PEBEmojiEmotionManager.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmojiEmotionManager.h"
#import "PEBPacket.h"
#import "PEBElement.h"

@implementation PEBEmojiEmotionManager

+ (PEBPacket *)emojiPacket {
    NSDictionary *dataDictionary = [self dataDictionary];
    PEBPacket *packet = [[PEBPacket alloc] initWithDictionary:dataDictionary];
    NSMutableArray *elements = [NSMutableArray array];
    [dataDictionary[@"emotions"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PEBElement *element = [[PEBElement alloc] initWithDictionary:obj];
        [elements addObject:element];
    }];
    packet.elements = elements;
    return packet;
}

+ (NSDictionary *)dataDictionary {
    NSString *emojiDataFilePath = [[NSBundle mainBundle] pathForResource:@"PEBEmojiPacket" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:emojiDataFilePath];
}

+ (NSUInteger)hash {
    NSString *emojiDataFilePath = [[NSBundle mainBundle] pathForResource:@"PEBEmojiPacket" ofType:@"plist"];
    NSData *packetData = [NSData dataWithContentsOfFile:emojiDataFilePath];
    return [packetData hash];
}

@end
