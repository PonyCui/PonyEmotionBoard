//
//  PEBEmotionManager.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionManager.h"
#import "PEBEmojiEmotionManager.h"

@interface PEBEmotionManager ()

@property (nonatomic, copy) NSString *storeFilePath;

@property (nonatomic, copy) NSArray *packetArray;

@end

@implementation PEBEmotionManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self readPacketFromStore];
    }
    return self;
}

- (void)findAvailabelPackets:(void (^)(NSArray *))completionBlock {
    if (completionBlock) {
        completionBlock(self.packetArray);
    }
}

- (void)setPacketArray:(NSArray *)packetArray {
    _packetArray = packetArray;
    [self savePacketInStore];
}

#pragma mark - PacketStore

/**
 *  当前使用Plist文件保存表情元数据
 *  如果有需要，你可以升级至CoreData
 */
- (void)savePacketInStore {
    [self.packetArray writeToFile:self.storeFilePath atomically:YES];
}

- (void)readPacketFromStore {
    self.packetArray = [NSArray arrayWithContentsOfFile:self.storeFilePath];
    if (self.packetArray == nil) {
        self.packetArray = @[[PEBEmojiEmotionManager emojiPacket]];
    }
}

- (NSString *)storeFilePath {
    if (_storeFilePath == nil) {
        NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _storeFilePath = [directoryPath stringByAppendingString:@"/PEBEmotionData.plist"];
    }
    return _storeFilePath;
}

@end
