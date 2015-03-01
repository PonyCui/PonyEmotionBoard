//
//  PEBEmotionManager.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionManager.h"
#import "PEBEmojiEmotionManager.h"
#import "PEBPacket.h"
#import "PEBElement.h"
#import "PEBDefines.h"

@interface PEBEmotionManager ()

@property (nonatomic, copy) NSDictionary *emojiSimilarDictionary;

@property (nonatomic, copy) NSString *storeFilePath;

@property (nonatomic, copy) NSArray *packetArray;

@end

@implementation PEBEmotionManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self readPacketFromStore];
        [self emojiSimilarDictionary];
    }
    return self;
}

- (void)findAvailabelPackets:(void (^)(NSArray *))completionBlock {
    if (completionBlock) {
        completionBlock(self.packetArray);
    }
}

#pragma mark - Emoji Similar

- (NSDictionary *)emojiSimilarDictionary {
    if (_emojiSimilarDictionary == nil) {
        NSMutableDictionary *emojiSimilarDictionary = [NSMutableDictionary dictionary];
        [self.packetArray enumerateObjectsUsingBlock:^(PEBPacket *obj, NSUInteger idx, BOOL *stop) {
            [obj.elements enumerateObjectsUsingBlock:^(PEBElement *obj, NSUInteger idx, BOOL *stop) {
                if (obj.type == PEBElementTypeEmojiSimilar) {
                    [emojiSimilarDictionary setObject:obj forKey:obj.titleString];
                }
            }];
        }];
        _emojiSimilarDictionary = [emojiSimilarDictionary copy];
    }
    return _emojiSimilarDictionary;
}

- (NSAttributedString *)addEmotionsToAttributedString:(NSAttributedString *)attributedString {
    static NSRegularExpression *regularExpression;
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            regularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\u005B.*?]"
                                                                          options:kNilOptions
                                                                            error:nil];
        });
    }
    NSMutableAttributedString *mutableAttributedString = [attributedString mutableCopy];
    NSString *textString = [mutableAttributedString string];
    NSArray *textMatches = [regularExpression matchesInString:textString
                                                      options:NSMatchingReportCompletion
                                                        range:NSMakeRange(0, [textString length])];
    [textMatches
     enumerateObjectsWithOptions:NSEnumerationReverse
     usingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL *stop) {
         NSString *emotionString = [textString substringWithRange:obj.range];
         NSString *emotionKey = [emotionString stringByReplacingOccurrencesOfString:@"[" withString:@""];
         emotionKey = [emotionKey stringByReplacingOccurrencesOfString:@"]" withString:@""];
         NSAttributedString *emotionAttributedString = [self emotionAttributedStringForKey:emotionKey
                                                                 referenceAttributedString:[mutableAttributedString attributedSubstringFromRange:obj.range]];
         [mutableAttributedString replaceCharactersInRange:obj.range withAttributedString:emotionAttributedString];
     }];
    return [mutableAttributedString copy];
}

- (NSAttributedString *)emotionAttributedStringForKey:(NSString *)aKey
                            referenceAttributedString:(NSAttributedString *)referenceAttributedString {
    if (self.emojiSimilarDictionary[aKey] != nil) {
        PEBElement *emojiSimilarElement = self.emojiSimilarDictionary[aKey];
        UIImage *emojiImage;
        if (emojiSimilarElement.localURLString != nil) {
            emojiImage = [UIImage imageNamed:emojiSimilarElement.localURLString];
        }
        if (emojiImage != nil) {
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            UIFont *referenceFont = [referenceAttributedString attribute:NSFontAttributeName
                                                                 atIndex:0
                                                          effectiveRange:nil];
            NSParagraphStyle *referenceParagraphStyle = [referenceAttributedString
                                                         attribute:NSParagraphStyleAttributeName
                                                         atIndex:0
                                                         effectiveRange:nil];
            if (referenceFont == nil) {
                referenceFont = [UIFont systemFontOfSize:17.0];
            }
            attachment.image = emojiImage;
            CGFloat lineHeight = referenceParagraphStyle != nil ? referenceParagraphStyle.minimumLineHeight : referenceFont.lineHeight;
            attachment.bounds = CGRectMake(0,
                                           referenceFont.descender - floor((lineHeight - referenceFont.lineHeight) / 2),
                                           lineHeight,
                                           lineHeight);
            NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachment];
            return attributedString;
        }
    }
    return nil;
}

#pragma mark - PacketStore

- (void)setPacketArray:(NSArray *)packetArray {
    _packetArray = packetArray;
    [self savePacketInStore];
}

/**
 *  当前使用Plist文件保存表情元数据
 *  如果有需要，你可以升级至CoreData
 */
- (void)savePacketInStore {
    [NSKeyedArchiver archiveRootObject:self.packetArray toFile:self.storeFilePath];
}

- (void)readPacketFromStore {
    self.packetArray= [NSKeyedUnarchiver unarchiveObjectWithFile:self.storeFilePath];
    if (self.packetArray == nil) {
        self.packetArray = @[[PEBEmojiEmotionManager emojiPacket]];
    }
    else {
        NSUInteger lockHash = [[[NSUserDefaults standardUserDefaults] valueForKey:kPEBEmojiPacketVersionLock] unsignedIntegerValue];
        if (lockHash != [PEBEmojiEmotionManager hash]) {
            NSMutableArray *packetArray = [self.packetArray mutableCopy];
            if ([packetArray count] >= 1) {
                [packetArray setObject:[PEBEmojiEmotionManager emojiPacket] atIndexedSubscript:0];
            }
            self.packetArray = packetArray;
        }
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